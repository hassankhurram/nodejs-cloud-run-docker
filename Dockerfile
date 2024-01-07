# Use the official Node.js 14 image as the base image
FROM node:20

# Set the working directory in the container
WORKDIR /workspace/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the application code to the working directory
COPY . .

# Expose the port on which the application will run
EXPOSE 8080


# Command to run the application
CMD ["node", "index.js"]
