FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
#We are specifing that we are going to copy from builder(excat name of the previous step)
# and we need to specify the folder, in this case the build folder that is inside the wordir /app
# and as per nginx documentation, we need to send the files/folde into html folder
COPY --from=builder /app/build /usr/share/nginx/html
