# PHP-DOCKER-STACK-DEMO
# Dockerizing PHP Applications Guide

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Docker Configuration](#docker-configuration)
- [Step-by-Step Setup](#step-by-step-setup)
- [Development Environment](#development-environment)
- [Production Considerations](#production-considerations)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker Engine (version 20.10 or later)
- Docker Compose (version 2.0 or later)
- Git (optional, but recommended for version control)

## Project Structure

Your project should follow this basic structure:
```
your-php-app/
├── src/                     # PHP application source code
├── docker/                  # Docker-related files
│   ├── php/                # PHP configuration
│   │   └── Dockerfile      # PHP container configuration
│   └── nginx/              # Nginx configuration (if using)
│       └── default.conf    # Nginx server configuration
├── docker-compose.yml      # Service orchestration
├── .dockerignore          # Files to exclude from builds
└── README.md              # This documentation
```

## Docker Configuration

### PHP Dockerfile

Create `docker/php/Dockerfile`:

```dockerfile
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . /var/www

# Set permissions
RUN chown -R www-data:www-data /var/www

# Switch to non-root user
USER www-data
```

### Docker Compose Configuration

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: docker/php/Dockerfile
    container_name: php-app
    restart: unless-stopped
    working_dir: /var/www
    volumes:
      - ./:/var/www
    networks:
      - app-network

  nginx:
    image: nginx:alpine
    container_name: php-nginx
    restart: unless-stopped
    ports:
      - "8000:80"
    volumes:
      - ./:/var/www
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    networks:
      - app-network

  db:
    image: mysql:8.0
    container_name: php-db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
    volumes:
      - dbdata:/var/lib/mysql
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  dbdata:
    driver: local
```

## Step-by-Step Setup

1. **Initialize Your Project**
   ```bash
   mkdir your-php-app
   cd your-php-app
   ```

2. **Create Docker Configuration Files**
   - Create the directory structure shown above
   - Copy the Dockerfile and docker-compose.yml content
   - Create a `.dockerignore` file:
     ```
     .git
     .gitignore
     .env
     vendor/
     node_modules/
     ```

3. **Configure Environment Variables**
   ```bash
   cp .env.example .env
   ```
   Update the `.env` file with your database credentials and other configurations.

4. **Build and Start Containers**
   ```bash
   docker-compose up -d --build
   ```

5. **Install Dependencies**
   ```bash
   docker-compose exec app composer install
   ```

6. **Set Permissions**
   ```bash
   docker-compose exec app chmod -R 775 storage bootstrap/cache
   ```

## Development Environment

### Accessing Containers

- PHP container: `docker-compose exec app bash`
- MySQL container: `docker-compose exec db mysql -u root -p`
- Logs: `docker-compose logs -f [service_name]`

### Common Commands

```bash
# Start containers
docker-compose up -d

# Stop containers
docker-compose down

# Rebuild containers
docker-compose up -d --build

# View logs
docker-compose logs -f

# Run composer commands
docker-compose exec app composer install
```

## Production Considerations

1. **Security**
   - Remove development tools and dependencies
   - Use production-optimized PHP configuration
   - Implement proper access controls
   - Use secure networking configurations

2. **Performance**
   - Enable PHP OPcache
   - Configure appropriate PHP-FPM settings
   - Implement caching strategies
   - Use production-ready web server configurations

3. **Monitoring**
   - Implement health checks
   - Set up logging and monitoring
   - Configure backup strategies

## Troubleshooting

### Common Issues and Solutions

1. **Permission Issues**
   ```bash
   # Fix storage permissions
   docker-compose exec app chown -R www-data:www-data storage
   chmod -R 775 storage
   ```

2. **Container Won't Start**
   - Check logs: `docker-compose logs [service_name]`
   - Verify port availability
   - Ensure all required environment variables are set

3. **Database Connection Issues**
   - Verify database credentials in `.env`
   - Ensure database service is running
   - Check network connectivity between containers

### Getting Help

If you encounter issues:
1. Check the Docker and container logs
2. Review the configurations for syntax errors
3. Verify environment variables are properly set
4. Consult the official Docker and PHP documentation
5. Search for similar issues in the community forums

## Additional Resources

- [Official Docker Documentation](https://docs.docker.com/)
- [PHP Official Docker Images](https://hub.docker.com/_/php)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)