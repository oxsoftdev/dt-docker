import os
import time
import logging

from constants import BASEPATH
from ._ContainerMixin import ContainerMixin
from ..metaclasses.Singleton import Singleton

logger = logging.getLogger('dt-docker')


class MssqlContainer(ContainerMixin, metaclass=Singleton):

    def __init__(self, client):
        self.client = client
        self._src = os.path.join(BASEPATH, '_assets/sql-scripts/mssql')
        self._dst = '/usr/src/sql'
        self._sqlcmd = '/opt/mssql-tools/bin/sqlcmd'
        self._server = 'localhost'

    @property
    def name(self):
        return 'mssql'

    @property
    def username(self):
        return os.environ['MSSQL_SERVER_UID']

    @property
    def password(self):
        return os.environ['MSSQL_SERVER_PWD']

    @property
    def sql_scripts(self):
        return (
            'bitso-ddl.sql',
            'bitso-procedures.sql',
            'poloniex-ddl.sql'
        )

    def run(self):
        try:
            container = self.client.containers.run(**{
                'name': self.name,
                'image': 'microsoft/mssql-server-linux',
                'detach': True,
                'environment': {
                    'ACCEPT_EULA': 'Y',
                    'SA_PASSWORD': self.password
                },
                'network': self.name,
                'ports': {
                    '1433/tcp': 1433
                }
            })
            #
            logger.info("container::%s - created" % self.name)
            return container
        except:
            logger.exception(
                "container::%s - failed to be created" % self.name)
            raise

    def _exec_sql_script(self, tsql, name):
        try:
            self.copy_sql(tsql, os.path.join(self._dst, name))
            cmd = '{sqlcmd} -S {server} -U {username} -P {password} -i {path}'
            container = self.get()
            container.exec_run(
                cmd.format(**{
                    'sqlcmd': self._sqlcmd,
                    'server': self._server,
                    'username': self.username,
                    'password': self.password,
                    'path': os.path.join(self._dst, name)
                }))
            #
            logger.info(
                "container::%s - script %s executed" %
                (self.name, name))
        except:
            logger.exception(
                "container::%s - script %s failed on execution" %
                (self.name, name))
            raise

    def _exec_sql_scripts(self):
        for sql_script in self.sql_scripts:
            with open(os.path.join(self._src, sql_script)) as f:
                self._exec_sql_script(f.read(), sql_script)

    def _connect_network(self, network):
        self.client.networks.get(network).connect(self.name)

    def initialize(self):
        container = self.run()
        time.sleep(2 * 60)
        container.exec_run('mkdir -p %s' % self._dst)
        self._exec_sql_scripts()
        self._connect_network('bitso')
        self._connect_network('poloniex')

