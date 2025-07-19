# Step 1: Base Image
FROM node:18

# Step 2: Set Working Directory
WORKDIR /app

# Step 3: Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Step 4: Copy source code
COPY . .

# Step 5: Build React App
RUN npm run build

# Step 6: Serve the app
RUN npm install -g serve
CMD ["serve", "-s", "build", "-l", "5001"]
