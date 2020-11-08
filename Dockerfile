# base image ubuntu
FROM ubuntu:18.04

LABEL Name="meteor-tutorial Version=1.0.0"
LABEL maintainer="Jiam Seo <jams7777@gmail.com>"

# Install wget and install/updates certificates node
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates bzip2 apt-transport-https \
						apt-utils vim curl ssh git \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get install --no-install-recommends --no-install-suggests -y nodejs \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install yarn && rm -rf /var/lib/apt/lists/*

ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_VERSION 12.19.0
ENV METEOR_ALLOW_SUPERUSER=true
ENV ROOT_URL="http://localhost:3000"

# work dir make
RUN mkdir /app
RUN chmod 777 -R /app
RUN mkdir /app/web
RUN chmod 777 -R /app/web
# volume connect path
RUN mkdir /app/web2
RUN chmod 777 -R /app/web2

# Install npm lastest
RUN /usr/bin/npm install npm -g

RUN curl "https://install.meteor.com/" | sh

# work root
WORKDIR /app/web

# meteor user add ( meteor / meteor )
RUN useradd --password meteor --create-home meteor
RUN chown -R meteor:meteor /app/web

RUN chmod 755 /home/meteor/.bashrc

# alais setting
RUN  echo "alias app='cd /app/web'" >> /home/meteor/.bashrc

RUN  echo "echo " >> /home/meteor/.bashrc
RUN  echo "echo " >> /home/meteor/.bashrc
RUN  echo "echo ' ************  Meteor Tutorial Docker [ local ]             ************* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' *****                                                            ******* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' ***** << info >>                                                 ******* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' *****           app : project folder                             ******* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' ***** meteor create : create project                             ******* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' ***** meteor run    : start meteor                               ******* ' " >> /home/meteor/.bashrc
RUN  echo "echo ' ************************************************************************ ' " >> /home/meteor/.bashrc

RUN chmod 644 /home/meteor/.bashrc

USER meteor

RUN meteor --version

# Volume setting
VOLUME ["/app/web2"]

# Port setting
EXPOSE 3000 3001

CMD ["/bin/bash"]
