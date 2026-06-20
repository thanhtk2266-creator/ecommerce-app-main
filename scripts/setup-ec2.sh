#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting deployment...${NC}\n"

# 1. Update system packages
echo -e "${YELLOW}📦 Step 1: Updating system packages...${NC}"
sudo apt-get update
sudo apt-get upgrade -y

# 2. Install Docker
echo -e "${YELLOW}🐳 Step 2: Installing Docker...${NC}"
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh

    # Add current user to docker group
    sudo usermod -aG docker $(whoami)
    echo "⚠️ Please log out and log back in for docker group changes to take effect"
else
    echo "✓ Docker already installed"
fi

# 3. Install Docker Compose
echo -e "${YELLOW}🔧 Step 3: Installing Docker Compose...${NC}"
DOCKER_COMPOSE_VERSION="2.20.2"
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "✓ Docker Compose already installed"
fi

# 4. Install Git
echo -e "${YELLOW}📝 Step 4: Installing Git...${NC}"
if ! command -v git &> /dev/null; then
    sudo apt-get install -y git
else
    echo "✓ Git already installed"
fi

# 5. Install Nginx
echo -e "${YELLOW}🌐 Step 5: Installing Nginx...${NC}"
if ! command -v nginx &> /dev/null; then
    sudo apt-get install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
else
    echo "✓ Nginx already installed"
fi

# 6. Install Certbot for SSL
echo -e "${YELLOW}🔐 Step 6: Installing Certbot for SSL...${NC}"
if ! command -v certbot &> /dev/null; then
    sudo apt-get install -y certbot python3-certbot-nginx
else
    echo "✓ Certbot already installed"
fi

# 7. Create app directory
echo -e "${YELLOW}📁 Step 7: Creating application directory...${NC}"
APP_DIR="/home/ec2-user/ecommerce-app"
mkdir -p $APP_DIR
cd $APP_DIR

# 8. Clone or pull repository
echo -e "${YELLOW}📥 Step 8: Setting up Git repository...${NC}"
if [ -d "$APP_DIR/.git" ]; then
    echo "Repository already exists, pulling latest changes..."
    git pull origin main
else
    echo "Cloning repository..."
    echo "⚠️ You need to update the clone URL below:"
    echo "git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git $APP_DIR"
    read -p "Enter your GitHub repository URL: " REPO_URL
    git clone $REPO_URL $APP_DIR
fi

# 9. Create .env file
echo -e "${YELLOW}⚙️ Step 9: Setting up environment variables...${NC}"
if [ ! -f "$APP_DIR/.env" ]; then
    cp "$APP_DIR/.env.example" "$APP_DIR/.env"
    echo "✓ .env file created"
    echo "⚠️ IMPORTANT: Edit .env file with production values:"
    echo "   nano $APP_DIR/.env"
else
    echo "✓ .env file already exists"
fi

# 10. Create SSL directory
echo -e "${YELLOW}🔐 Step 10: Creating SSL directory...${NC}"
mkdir -p $APP_DIR/ssl

# 11. Build and start Docker containers
echo -e "${YELLOW}🚀 Step 11: Building and starting containers...${NC}"
cd $APP_DIR
docker-compose up -d --build

# Check if containers are running
echo -e "\n${GREEN}✅ Deployment completed!${NC}\n"
echo "Checking container status:"
docker-compose ps

echo -e "\n${YELLOW}⚠️ Next steps:${NC}"
echo "1. Update .env file with production values:"
echo "   nano $APP_DIR/.env"
echo ""
echo "2. Run your application and test it:"
echo "   http://localhost (or your server IP)"
echo ""
echo "3. Setup domain & SSL (optional):"
echo "   sudo certbot certonly --standalone -d yourdomain.com"
echo ""
echo "4. Update Nginx configuration:"
echo "   nano /etc/nginx/nginx.conf"
echo "   Then restart: sudo systemctl restart nginx"
echo ""
echo "📊 Useful commands:"
echo "   View logs: docker-compose logs -f"
echo "   Restart services: docker-compose restart"
echo "   Stop services: docker-compose down"
echo "   Update & redeploy: docker-compose pull && docker-compose up -d"
