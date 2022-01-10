FROM node:14-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . /app

RUN apk update && npm install -g @vue/cli
COPY package.json .
ENV NODE_OPTIONS=--max_old_space_size=4096
RUN npm install

CMD npm run serve