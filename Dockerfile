FROM node:12 as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
FROM nginx
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
