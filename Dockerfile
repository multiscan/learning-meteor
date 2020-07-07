FROM node:14
USER node
RUN curl https://install.meteor.com/ | sh
ENTRYPOINT /home/node/.meteor/meteor