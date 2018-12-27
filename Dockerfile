FROM python:3.6-stretch

# Nano, wget and unzip
RUN apt-get update && apt-get install -y nano wget unzip
ENV TERM xterm

# PostgreSQL
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client && rm -rf /var/lib/apt/lists/*

# Pillow, GIT, pngquant and gettext
RUN apt-get update && apt-get install -y libjpeg-dev git pngquant gettext

# Mono
RUN apt-get update && apt-get install -y apt-transport-https dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y mono-complete

# IronPython
WORKDIR /usr/src/ironpython
COPY IronPython.2.7.8.zip .
RUN unzip IronPython.2.7.8.zip
RUN alias ipy='mono /usr/src/ironpython/net45/ipy.exe -X:PrivateBinding'

# GoAccess and lxml
RUN apt-get update && apt-get install -y goaccess=1:0.9.4-1+b1 geoip-database libxml2-dev libxslt1-dev

# cURL, Varnish, Redis tools and S3cmd
RUN apt-get update && apt-get install -y curl varnish redis-tools s3cmd

WORKDIR /app

CMD ["/bin/bash"]
