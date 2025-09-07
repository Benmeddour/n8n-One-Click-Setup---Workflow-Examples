# n8n Learning Repository 🚀

Welcome to your n8n learning journey! This repository contains examples, tutorials, and resources to help you master n8n workflow automation.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Installation](#installation)
- [Repository Structure](#repository-structure)
- [Basic Concepts](#basic-concepts)
- [Examples](#examples)
- [Best Practices](#best-practices)
- [Configuration](#configuration)
- [Resources](#resources)
- [Quick Start](#quick-start)
- [Contributing](#contributing)
- [Need Help?](#need-help)
- [License](#license)

## 🚀 Getting Started

n8n is a powerful workflow automation tool that allows you to connect different services and automate tasks. This repository will guide you through:

- Setting up n8n locally
- Creating your first workflows
- Understanding nodes and connections
- Advanced automation techniques
- Best practices and tips

## 💻 Installation

### Automated Setup (Recommended)

Use our automated setup script for a complete n8n installation:

```bash
# Make the setup script executable
chmod +x scripts/setup.sh

# Run the setup script
./scripts/setup.sh
```

The setup script will:

- Update your system packages
- Install Node.js 22 via NVM
- Install n8n globally
- Create systemd service for production deployment
- Configure environment variables
- Start n8n automatically

### Manual Installation

```bash
# Install n8n globally
npm install n8n -g

# Start n8n
n8n start

# Access n8n at http://localhost:5678
```

### Docker Installation

```bash
# Run n8n with Docker
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  n8nio/n8n
```

## 📁 Repository Structure

```
n8n/
├── README.md                           # This file
├── LICENSE                             # MIT License
├── package.json                        # Project metadata
├── .env.example                        # Environment variables template
├── workflows/                         # Example workflows
│   ├── simple-email-notification.json # Email notification workflow
│   └── simple-email-notification.md   # Workflow documentation
└── scripts/                           # Utility scripts
    └── setup.sh                       # Automated n8n installation script
```

## 🎯 Basic Concepts

### What is n8n?

n8n is a free and source-available workflow automation tool. It's designed to help you automate tasks by connecting different services and APIs.

### Key Components

- **Nodes**: Individual steps in your workflow
- **Connections**: Links between nodes that pass data
- **Workflows**: Complete automation sequences
- **Triggers**: Events that start your workflows
- **Webhooks**: HTTP endpoints for external integrations

### Common Use Cases

- Data synchronization between services
- Automated notifications and alerts
- Data processing and transformation
- API integrations and microservices
- Social media automation
- E-commerce automation

## 📚 Examples

### Available Workflows

This repository includes the following example workflow:

- **Simple Email Notification** (`workflows/simple-email-notification.json`)
  - A basic workflow demonstrating email notifications
  - Documentation available in `workflows/simple-email-notification.md`
  - Perfect for beginners to understand n8n fundamentals

### Workflow Categories

- **Email Automation**: Automated email notifications and responses
- **Data Processing**: Transform and manipulate data between services
- **API Integrations**: Connect different services and APIs

## ✅ Best Practices

1. **Plan Your Workflows**: Always sketch out your workflow before building
2. **Use Meaningful Names**: Name your workflows and nodes clearly
3. **Error Handling**: Always include error handling in production workflows
4. **Test Thoroughly**: Test with different data scenarios
5. **Document Your Work**: Add descriptions to complex workflows
6. **Version Control**: Keep your workflows in version control
7. **Security**: Never hardcode sensitive data; use environment variables

## 🔧 Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure your environment variables:

```bash
cp .env.example .env
```

### Setup Script Features

The `scripts/setup.sh` script provides:

- Automated system package updates
- Node.js 22 installation via NVM
- Global n8n installation
- Systemd service creation for production
- Environment configuration
- Automatic service startup

## 📖 Resources

### Official Documentation

- [n8n Documentation](https://docs.n8n.io/)
- [Node Reference](https://docs.n8n.io/integrations/)
- [Community Forum](https://community.n8n.io/)

### Learning Resources

- [n8n YouTube Channel](https://www.youtube.com/c/n8nio)
- [Workflow Templates](https://n8n.io/workflows/)
- [Blog Posts and Tutorials](https://n8n.io/blog/)

### Community

- [Discord Community](https://discord.gg/n8n)
- [GitHub Repository](https://github.com/n8n-io/n8n)
- [Reddit Community](https://www.reddit.com/r/n8n/)

## 🚀 Quick Start

1. **Clone this repository**

   ```bash
   git clone <repository-url>
   cd n8n
   ```

2. **Run the setup script**

   ```bash
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

3. **Access n8n**

   - Open your browser to `http://localhost:5678`
   - Import the example workflow from `workflows/simple-email-notification.json`

4. **Start building workflows!**


## 🆘 Need Help?

- Check the example workflow documentation in `workflows/`
- Review the setup script at `scripts/setup.sh`
- Browse the [n8n community forum](https://community.n8n.io/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Happy automating! 🎉
