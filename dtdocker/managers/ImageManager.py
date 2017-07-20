import os

from ..constants import BASEPATH
from ..metaclasses import Singleton


class ImageManager(metaclass=Singleton):

    def __init__(self, client):
        self.client = client

    def pull_mssql(self):
        self._pull_image('microsoft/mssql-server-linux:latest')

    def pull_python(self):
        self._pull_image('python:latest')

    def pull_redis(self):
        self._pull_image('redis:latest')

    def pull_ubuntu(self):
        self._pull_image('ubuntu:latest')

    def build_botubuntu(self):
        self._build_custom_image({
            'path': os.path.join(BASEPATH, '_assets/custom-images/botubuntu'),
            'tag': 'bot/ubuntu:latest',
            'rm': True
        })

    def _pull_image(image):
        self.client.images.pull(image)

    def _build_custom_image(config):
        self.client.images.build(**config)

