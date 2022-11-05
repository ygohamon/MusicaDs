FROM node:14.16.1-slim

ENV USER=devbot

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create devbot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/devbot -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/devbot

COPY package*.json ./
RUN npm install
VOLUME [ "/home/devbot" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
