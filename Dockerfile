# Use PHP 8.1 Apache base image
FROM php:8.1-apache

# Install yt-dlp dependencies and curl
RUN apt-get update && apt-get install -y \
    curl \
    ffmpeg \
    python3-pip && \
    pip install -U yt-dlp

# Copy your project files into Apache web root
COPY . /var/www/html/

# Enable Apache mod_rewrite if needed
RUN a2enmod rewrite

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
