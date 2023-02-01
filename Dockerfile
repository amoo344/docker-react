FROM node:14.13.0-alpine 

WORKDIR /app

COPY ./package.json ./

RUN npm install -g svgo

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx

COPY --from=0 /app/build /usr/share/nginx/html

COPY --from=0 /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]

