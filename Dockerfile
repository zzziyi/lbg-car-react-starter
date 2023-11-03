# Stage 1: Build the React application
FROM node:14 AS build

# Set the working directory in the Docker image
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to work directory
COPY package.json package-lock.json ./

# Install node modules and build assets
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the React application from Nginx
FROM nginx:alpine

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside once the container has launched
EXPOSE 80

# Start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]

