# Use the official Node.js image as base image
FROM node:latest as build

# Set the working directory in the container
WORKDIR /app

COPY package*.json ./

# Copy the frontend application code into the container
COPY . .

# Install dependencies
RUN npm install

RUN npm install -g react 

RUN npm install -g react-scripts

RUN npm run build

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html/

COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port on which the React application will run
EXPOSE 80

EXPOSE 3001

# Command to start the React application
CMD ["nginx", "-g", "daemon off;"]
