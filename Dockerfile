##Build
FROM beevelop/ionic:latest AS ionic
#Create app directory
WORKDIR /usr/src/app
#install dependencies
#A wildcard is used to ensure both package.json and package.lock.json are copied
COPY package*.json ./
RUN npm ci
#Bundle app source
COPY . .
RUN ionic build
## Run
FROM nginx:alpine
#Copy www /usr/share/nginx/html
COPY --from=ionic  /usr/src/app/www /usr/share/nginx/html
