FROM shift/ruby:latest

MAINTAINER Vincent Palmer <shift@someone.section.me>

WORKDIR /
RUN apt-get update \
    && apt-get install curl --yes \
    && curl -L -O https://github.com/sensu/sensu/archive/v0.20.5.tar.gz \
    && tar xfvz v0.20.5.tar.gz \
    && mv sensu-0.20.5 sensu \
    && cd sensu \
    && sed -i.bak 's/s\.add_dependency "eventmachine", "1\.0\.3"/s\.add_dependency "eventmachine", "1\.0\.8"/' sensu.gemspec \
    && bundle install \
    && gem install sensu-plugins-slack \
    && gem install sensu-plugins-github \
    && rm -rf ../v0.20.5.tar.gz \
    && rm -rf /var/lib/apt/lists/*

VOLUME /etc/sensu
VOLUME /data
VOLUME /logs
