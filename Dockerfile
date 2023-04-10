FROM node:16-alpine3.12

WORKDIR /app/

COPY ./public/ /app/public
COPY ./src /app/src/
COPY babel.config.js /app/
COPY jsconfig.json /app/
COPY package.json /app/
COPY vue.config.js /app/
# COPY yarn.lock /app/

# RUN  yarn install
CMD [ "yarn", "serve" ]