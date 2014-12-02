FROM saksmlz/docker-ruby

ENV DEBIAN_FRONTEND noninteractive
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1

RUN sed -i '1i deb     http://gce_debian_mirror.storage.googleapis.com/ wheezy         main' /etc/apt/sources.list \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y -qq --no-install-recommends wget unzip python python-openssl ca-certificates-java openssh-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=false --path-update=true --bash-completion=false --rc-path=/.bashrc --disable-installation-options
RUN yes | google-cloud-sdk/bin/gcloud components update pkg-python
RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
ENV HOME /
VOLUME ["/.config"]
CMD bash
