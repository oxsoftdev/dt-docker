from ..metaclasses import Singleton


class NetworkManager(metaclass=Singleton):

    def __init__(self, client):
        self.client = client

    def create_bitso(self):
        self._create_network('bitso')

    def create_mssql(self):
        self._create_network('mssql')

    def create_poloniex(self):
        self._create_network('poloniex')

    def _create_network(self, network):
        self.client.networks.create(name=network, driver='bridge')

