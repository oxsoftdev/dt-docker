import logging

logger = logging.getLogger('dt-docker')


def containers(client):
    for container in client.containers.list(all=True):
        try:
            container.remove(force=True)
            logger.info("cleanup::container: %s" % container.name)
        except:
            logger.exception("failed to clean up container")


def networks(client):
    networks = list(map(lambda n: n.name, client.networks.list()))
    for network in networks:
        try:
            client.networks.get(network).remove()
            logger.info("cleanup::network: %s" % network.name)
        except:
            logger.exception("failed to clean up network")


def images(client):
    images = client.images.list(all=True)[:]
    for image in images:
        try:
            client.images.remove(image=image.tags[0], force=True)
            logger.info("cleanup::image: %s" % image.tags[0])
        except:
            logger.exception("failed to clean up image")

