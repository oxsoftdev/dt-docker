# ubuntu:16.04
# mssql-python-pyodbc
# Python runtime with pyodbc to connect to SQL Server

# apt-get and system utilities
apt update && apt-get install -y \
    curl apt-utils ca-certificates apt-transport-https debconf-utils gcc build-essential g++-5 \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server drivers
apt update && ACCEPT_EULA=Y apt install -y msodbcsql unixodbc-dev

# install SQL Server tools
apt update && ACCEPT_EULA=Y apt install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
/bin/bash -c 'source ~/.bashrc'

# python libraries
apt update && apt install -y \
    python3 python3-pip python3-dev python3-setuptools \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# install necessary locales
apt update && apt install -y locales \
    && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# upgrade pip
pip3 install --upgrade pip

# install SQL Server Python SQL Server connector module - pyodbc
pip install --user --no-cache-dir pyodbc

# install additional utilities
apt update && apt install -y vim

