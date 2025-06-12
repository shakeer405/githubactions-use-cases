# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Copy custom configuration file (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Copy static website files (optional)
# COPY ./html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX (default command in base image)
CMD ["nginx", "-g", "daemon off;"]
