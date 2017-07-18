import logging

from ._ContainerMixin import ContainerMixin
from ..metaclasses.Singleton import Singleton

logger = logging.getLogger('dt-docker')


class RedisContainer(ContainerMixin):

    def __init__(self, client, name):
        self.client = client
        self.name = name

    def run(self, port, environment=None):
        try:
            container = self.client.containers.run(**{
                'name': self.name,
                'image': 'redis',
                'detach': True,
                'environment': environment,
                'network': self.name,
                'ports': {
                    '6379/tcp': port
                }
            })
            #
            logger.info("redis-container::%s - created" % self.name)
            return container
        except:
            logger.exception(
                "redis-container::%s - failed to be created" % self.name)
            raise


class RedisContainers(metaclass=Singleton):

    def __init__(self, client):
        self.bitso = RedisContainer(client, 'bitso')
        self.poloniex = RedisContainer(client, 'poloniex')

    def initialize(self):
        self.bitso.run(63791, None)
        self.poloniex.run(63792, None)

