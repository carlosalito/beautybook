# builder
FROM node:12-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


# distribution
FROM node:12-alpine

WORKDIR /app
COPY package.json /app
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "run", "start:prod"]