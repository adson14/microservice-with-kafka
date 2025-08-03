FROM node:18-alpine

RUN apk add --no-cache bash sudo

RUN apk add --no-cache bash sudo git openssh-client curl

RUN npm install -g @nestjs/cli

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN chown -R node:node /usr/src/app

RUN echo "node ALL=(ALL) NOPASSWD: /bin/chown, /bin/rm" >> /etc/sudoers


USER node

EXPOSE 3000

CMD ["./scripts/entrypoint.sh"]