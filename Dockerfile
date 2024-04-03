# Use the official Node.js image as base image
FROM node:latest as builder

# Set the working directory in the container
WORKDIR /app

# ENV PATH /app/node_modules/.bin:$PATH
# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Copy the frontend application code into the container
COPY . .

# Install dependencies
RUN npm install

RUN npm install -g react 

RUN npm install -g react-scripts

RUN npm run build

FROM nginx:stable-alpine

# COPY --from=builder /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port on which the React application will run
EXPOSE 80

# Command to start the React application
# CMD ["nginx", "-g", "daemon off;"]
COPY --from=builder /app/build /usr/share/nginx/html
