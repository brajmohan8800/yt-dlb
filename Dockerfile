# Use an official lightweight Python image
FROM python:3.11-slim

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ffmpeg \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install yt-dlp
RUN python3 -m pip install --no-cache-dir --upgrade pip yt-dlp

# Copy project files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Expose port
EXPOSE 80

# Default command
CMD ["php", "-S", "0.0.0.0:80", "-t", "."]
