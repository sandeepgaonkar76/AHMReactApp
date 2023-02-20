# Use an official Node.js runtime as a parent image
FROM node:14-slim AS build

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the app files to the container
COPY . .

# Build the React app
RUN npm run build

# Use NGINX as the web server
FROM nginx:1.21-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
