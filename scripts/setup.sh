#!/bin/bash

# Setup script for n8n learning environment
# This script helps you get started quickly with n8n on Linux servers
# Based on production setup experience

echo "Setting up n8n Learning Environment..."

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "Running as root. Consider creating a dedicated user for n8n."
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Update system packages
update_system() {
    echo "📦 Updating system packages..."
    sudo apt update && apt upgrade -y
    echo "✅ System updated"
}

# Install Node.js via NVM (recommended for version management)
install_nodejs() {
    if ! command -v node &> /dev/null; then
        echo "Installing Node.js via NVM..."
        
        # Install NVM
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
        
        # Source NVM
        \. "$HOME/.nvm/nvm.sh"
        
        # Install Node.js version 22
        nvm install 22
        nvm use 22
        nvm alias default 22
        
        echo "Node.js installed via NVM"
    else
        echo "Node.js already installed"
    fi
    
    # Verify Node.js version
    NODE_VERSION=$(node --version | cut -d'v' -f2)
    echo "Node.js version $NODE_VERSION detected"
}

# Install n8n globally
install_n8n() {
    if ! command -v n8n &> /dev/null; then
        echo "Installing n8n globally..."
        npm install -g n8n
        
        if [ $? -eq 0 ]; then
            echo "n8n installed successfully"
            echo "n8n location: $(which n8n)"
        else
            echo "Failed to install n8n"
            exit 1
        fi
    else
        echo "n8n is already installed at: $(which n8n)"
    fi
}

# Setup n8n directories and configuration
setup_n8n_config() {
    echo "Setting up n8n configuration..."
    
    # Create n8n directory if it doesn't exist
    mkdir -p ~/.n8n
    
    # Create .env file with the specific configuration
    echo "Creating .env file..."
    echo "N8N_SECURE_COOKIE=false" > ~/.n8n/.env
    echo "Created .env file at ~/.n8n/.env"
    
    # Export environment variables
    export $(cat ~/.n8n/.env | xargs)
    echo "Environment variables exported"
    
    # Create additional directories
    mkdir -p ~/.n8n/workflows
    mkdir -p ~/.n8n/nodes
    mkdir -p ~/.n8n/ssh
    
    echo "n8n directories created"
}

# Create systemd service for production deployment
create_systemd_service() {
    echo "Creating systemd service for n8n..."
    
    # Get current user
    CURRENT_USER=$(whoami)
    
    # Create systemd service file with specific configuration
    sudo tee /etc/systemd/system/n8n.service > /dev/null << 'EOF'
[Unit]
Description=n8n Automation Service
After=network.target

[Service]
User=obenmeddour3
WorkingDirectory=/home/obenmeddour3/.n8n
EnvironmentFile=/home/obenmeddour3/.n8n/.env
Environment="PATH=/home/obenmeddour3/.nvm/versions/node/v22.18.0/bin:/usr/local/bin:/usr/bin"

ExecStart=/home/obenmeddour3/.nvm/versions/node/v22.18.0/bin/n8n

Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

    # Enable and start the service
    sudo systemctl enable n8n
    sudo systemctl start n8n
    
    echo "Systemd service created, enabled, and started"
    echo "Use 'sudo systemctl status n8n' to check service status"
    echo "Use 'journalctl -u n8n -f' to view logs"
}

# Configure firewall (if ufw is available)
configure_firewall() {
    if command -v ufw &> /dev/null; then
        echo "Configuring firewall..."
        sudo ufw allow 5678/tcp
        echo "Firewall configured to allow n8n port (5678)"
    fi
}

# Main setup function
main() {
    echo "Starting n8n production setup..."
    
    # Check if running as root
    check_root
    
    # Update system (always run)
    update_system
    
    # Install Node.js
    install_nodejs
    
    # Install n8n
    install_n8n
    
    # Setup configuration
    setup_n8n_config
    
    # Start n8n briefly to initialize
    echo "Starting n8n briefly to initialize..."
    timeout 5 n8n || true
    
    # Create systemd service (always run)
    create_systemd_service
    
    # Configure firewall
    read -p "Configure firewall to allow n8n port? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        configure_firewall
    fi
    
    # Create project directories
    echo "Creating project directory structure..."
    mkdir -p n8n-data
    mkdir -p workflows/exports
    mkdir -p logs
    
    echo "Directory structure created"
    
    # Set permissions
    if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "win32" ]]; then
        chmod +x scripts/*.sh
        echo "Script permissions set"
    fi
    
    echo ""
    echo "Setup complete! Next steps:"
    echo ""
    echo "1. Access n8n at http://your-server-ip:5678"
    echo ""
    echo "2. Monitor n8n:"
    echo "   Service status:  sudo systemctl status n8n"
    echo "   View logs:       journalctl -u n8n -f"
    echo ""
    echo "3. Check the docs/ folder for learning materials"
    echo "4. Explore example workflows in workflows/ folder"
    echo ""
    echo "Troubleshooting tips:"
    echo "   - If service fails, check: journalctl -u n8n"
    echo "   - Restart service: sudo systemctl restart n8n"
    echo "   - Check environment: export \$(cat ~/.n8n/.env | xargs)"
    echo "   - Remove database to reset: rm ~/.n8n/database.sqlite"
    echo ""
    echo "Happy automating!"
}

# Run main function
main
