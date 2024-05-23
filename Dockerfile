FROM alpine:3.20

# Define the build argument for the Stremio version
ARG STREMIO_VERSION=v5.0.0-beta.8

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    bash \
    git \
    nginx \
    apache2-utils \
    su-exec \
    curl \
    unzip && \
    rm -rf /var/cache/apk/*

# Create directories for Nginx
RUN mkdir -p /run/nginx /etc/nginx/conf.d

# Add Nginx configuration files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/sites/default.conf

# Expose port for Nginx
EXPOSE 80

# Change to the Stremio Web directory
WORKDIR /stremio-web

# Download and unzip the specific version of Stremio Web
RUN curl -L "https://github.com/stremio/stremio-web/releases/download/${STREMIO_VERSION}/stremio-web.zip" -o stremio-web.zip \
    && unzip stremio-web.zip \
    && rm stremio-web.zip

# Copy over the entrypoint script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set the entrypoint
ENTRYPOINT ["/run.sh"]
