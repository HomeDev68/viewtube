FROM alpine:3.12
WORKDIR /home/app
ENV NODE_ENV=production

RUN apk upgrade --no-cache -U && \
    apk add --no-cache nodejs-current yarn

COPY package.json yarn.lock ./
RUN yarn install --production --link-duplicates --ignore-optional && \
    yarn cache clean && \
    yarn modclean -n default:safe -r

COPY . .

RUN yarn build

EXPOSE 8066

CMD ["yarn", "start"]