FROM php:8.1-apache

# Install dependencies safely
RUN apt-get update && apt-get install -y \
    curl \
    ffmpeg \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip & install yt-dlp
RUN python3 -m pip install --upgrade pip yt-dlp

# Copy all files into the web root
COPY . /var/www/html/

# Enable Apache rewrite module
RUN a
