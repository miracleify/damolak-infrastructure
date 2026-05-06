FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm install --only=production

# Copy app source code
COPY app ./app

EXPOSE 5050

CMD ["node", "app/index.js"]