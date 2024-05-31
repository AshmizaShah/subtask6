FROM node:14-alpine

WORKDIR /home/ec2-user/subtask6/my-node-app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]
