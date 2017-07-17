from setuptools import find_packages, setup

setup(
    name='dtdocker'
    , version='0.1'
    , author='sebastian'
    , author_email='oxsoftdev@gmail.com'
    , packages=find_packages()
    , url='https://github.com/oxsoftdev/dt-docker'
    , license='LICENSE.txt'
    , install_requires=['docker']
)

