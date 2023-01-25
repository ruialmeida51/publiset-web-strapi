# Using node 16-alpine
FROM node:16-alpine

# Install libvips-dev
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

# Set node_env. If none is provided, default to development.
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

# Set our working directory as /opt/
WORKDIR /opt/

# Copy the package.json to package-lock in our current directory.
COPY ./package.json ./package-lock.json ./

# Where to find the node_modules in the opt folder.
ENV PATH /opt/node_modules/.bin:$PATH

# Install the web app
RUN npm install

# Set our working directory to /opt/app/
WORKDIR /opt/app

# Copy everything in the local machine to the docker directory
COPY ./ .

# Build the project
RUN npm run build

# Expose the port
EXPOSE 1337

# Start the project as develop
CMD ["npm", "run", "develop"]