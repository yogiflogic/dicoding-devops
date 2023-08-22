FROM node:18-alpine AS base
WORKDIR /src
COPY package*.json ./

FROM base AS production
ENV NODE_ENV=production
RUN npm ci
COPY ./*.js ./
CMD ["node", "consumer.js"]

FROM base AS dev
RUN apk add --no-cache bash
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh

ENV NODE_ENV=development
RUN npm install
COPY ./*.js ./
CMD ["node", "consumer.js"]