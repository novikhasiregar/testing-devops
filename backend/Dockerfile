# Step 1: Base Image
FROM node:18

# Step 2: Set Working Directory
WORKDIR /app

# Step 3: Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Step 4: Copy source code
COPY . .

# Step 5: Set environment variable
ENV PORT=5000

# Step 6: Start the server
CMD ["node", "server.js"]
