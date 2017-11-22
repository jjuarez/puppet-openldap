FROM ruby:2.2
MAINTAINER Javier Juarez <javier.juarez@fon.com>
LABEL version="0.1" description="An image to test puppet modules with spec"

RUN apt-get update -yq && \
    apt-get install -yq git gcc g++ make tar libaugeas0 libaugeas-dev && \
    apt-get clean all

ENV puppet_version "~> 4.10"
ENV module_directory "/module"

RUN mkdir -p ${module_directory}
WORKDIR ${module_directory}
ADD Gemfile ${module_directory}

RUN printf "gem: --no-rdoc --no-ri" >> /etc/gemrc && \
    gem install json --version '1.8.3' && \
    gem install bundler

RUN PUPPET_GEM_VERSION=${puppet_version} bundler install --clean --system --gemfile Gemfile

VOLUME ${module_directory}

CMD rm -fr Gemfile.lock && \
    bundle exec rake spec_clean && \
    bundle exec rake spec

