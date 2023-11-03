# Dockerfile
FROM node:14

WORKDIR /app

COPY app .
RUN npm install
RUN npm install nodemon

EXPOSE 3000

CMD ["npx", "nodemon", "app.js"]
