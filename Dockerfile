FROM python:3.6-stretch

# Nano
RUN apt-get update && apt-get install -y nano
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
RUN git clone git://github.com/markdoggen/ironpython2.git IronLanguages
WORKDIR IronLanguages
RUN apt-get update && apt-get install -y make
RUN make release
ENV IRONPYTHONPATH=/usr/src/ironpython/IronLanguages/Src/StdLib/Lib:$IRONPYTHONPATH

# GoAccess and lxml
RUN apt-get update && apt-get install -y goaccess libxml2-dev libxslt1-dev

# cURL, wget, Varnish and Redis tools
RUN apt-get update && apt-get install -y curl wget varnish redis-tools

WORKDIR /app

CMD ["/bin/bash"]

