FROM node:13.12.0-alpine as build

WORKDIR /app

COPY ./package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx

COPY --from=build /app/build /usr/share/nginx/html

COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]

