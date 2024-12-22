FROM node:latest

WORKDIR /code

# start with dependencies to enjoy caching
COPY ./package.json /code/package.json
COPY ./package-lock.json /code/package-lock.json
RUN npm install

# copy rest and build
COPY . /code/.
RUN --mount=type=secret,id=.env env $(cat /run/secrets/.env | xargs) npm run build

# start the server
ENV HOST=0.0.0.0
ENV PORT=4321
CMD ["node", "/code/dist/server/entry.mjs"]