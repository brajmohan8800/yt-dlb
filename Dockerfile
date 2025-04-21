# Use an official PHP image with Apache
FROM php:8.1-apache

# Install required dependencies: yt-dlp and python3
RUN apt-get update && \
    apt-get install -y python3 python3-pip curl ffmpeg && \
    pip3 install yt-dlp

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy project files into the container
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
