import io
import os
import tarfile


class ContainerMixin:

    def get(self):
        return self.client.containers.get(self.name)

    def copy(self, content, path):
        container = self.get()
        stream = io.BytesIO()
        tar = tarfile.TarFile(fileobj=stream, mode='w')
        content = content.encode('utf8')
        tarinfo = tarfile.TarInfo(name=os.path.split(path)[1])
        tarinfo.size = len(content)
        tar.addfile(tarinfo, io.BytesIO(content))
        tar.close()
        stream.seek(0)
        container.put_archive(os.path.split(path)[0], stream)
        stream.close()

