FROM node:18-alpine

WORKDIR /app

# Copy package.json dan package-lock.json dulu, install dependencies
COPY package*.json ./
RUN npm install

# Copy prisma schema dan migrations ke container
COPY prisma ./prisma
COPY prisma/migrations ./prisma/migrations

# Copy source code dan config
COPY src ./src
COPY tsconfig.json ./
COPY nest-cli.json ./

# Generate Prisma Client berdasarkan schema
RUN npx prisma generate

# Build NestJS app
RUN npm run build

EXPOSE 3000

CMD ["node", "dist/main"]
