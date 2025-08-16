#!/bin/bash

# WhatsApp Number Reporter Simulator - Installation Script
# For Kali Linux and other Linux distributions

echo "🚀 WhatsApp Number Reporter Simulator - Installation"
echo "=================================================="
echo "This script will install the educational tool on your system."
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Warning: Running as root is not recommended for security reasons."
    echo "   Consider running as a regular user."
    read -p "   Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check Python version
echo "🔍 Checking Python version..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    echo "✅ Python 3 found: $PYTHON_VERSION"
    
    # Check if version is 3.7 or higher
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d'.' -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d'.' -f2)
    
    if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 7 ]; then
        echo "✅ Python version is compatible (3.7+)"
    else
        echo "❌ Python version $PYTHON_VERSION is too old. Please install Python 3.7 or higher."
        exit 1
    fi
else
    echo "❌ Python 3 not found. Please install Python 3.7 or higher."
    echo "   On Kali Linux: sudo apt update && sudo apt install python3"
    exit 1
fi

# Create installation directory
INSTALL_DIR="/opt/whatsapp-reporter-simulator"
echo ""
echo "📁 Creating installation directory: $INSTALL_DIR"

if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  Directory already exists. Backing up..."
    sudo mv "$INSTALL_DIR" "${INSTALL_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
fi

sudo mkdir -p "$INSTALL_DIR"
sudo chown $USER:$USER "$INSTALL_DIR"

# Copy files
echo "📋 Copying files..."
cp whatsapp_number_reporter.py "$INSTALL_DIR/"
cp test_simulation.py "$INSTALL_DIR/"
cp README.md "$INSTALL_DIR/"
cp requirements.txt "$INSTALL_DIR/"
cp LICENSE "$INSTALL_DIR/"

# Make scripts executable
chmod +x "$INSTALL_DIR/whatsapp_number_reporter.py"
chmod +x "$INSTALL_DIR/test_simulation.py"

# Create logs directory
mkdir -p "$INSTALL_DIR/logs"

# Create symlink for easy access
echo "🔗 Creating symlink for easy access..."
if [ -L "/usr/local/bin/whatsapp-reporter" ]; then
    sudo rm "/usr/local/bin/whatsapp-reporter"
fi

sudo ln -s "$INSTALL_DIR/whatsapp_number_reporter.py" "/usr/local/bin/whatsapp-reporter"

# Create desktop shortcut (optional)
if command -v xdg-desktop-menu &> /dev/null; then
    echo "🖥️  Creating desktop shortcut..."
    cat > /tmp/whatsapp-reporter.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=WhatsApp Reporter Simulator
Comment=Educational cybersecurity tool
Exec=python3 $INSTALL_DIR/whatsapp_number_reporter.py
Icon=terminal
Terminal=true
Categories=Education;Security;
Keywords=cybersecurity;education;simulation;
EOF

    xdg-desktop-menu install /tmp/whatsapp-reporter.desktop
    rm /tmp/whatsapp-reporter.desktop
fi

# Test installation
echo ""
echo "🧪 Testing installation..."
cd "$INSTALL_DIR"
python3 test_simulation.py

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Installation completed successfully!"
    echo ""
    echo "🎉 Usage:"
    echo "   whatsapp-reporter                    # Run the tool"
    echo "   whatsapp-reporter --educational      # Show educational info"
    echo "   whatsapp-reporter --save-logs        # Save logs to file"
    echo ""
    echo "📚 Educational Tool Ready!"
    echo "   This tool demonstrates cybersecurity concepts including:"
    echo "   • API rate limiting and anti-abuse systems"
    echo "   • Input validation and sanitization"
    echo "   • Logging and audit trails"
    echo "   • Ethical hacking principles"
    echo ""
    echo "⚠️  Remember: This is for EDUCATIONAL PURPOSES ONLY!"
    echo "   No real reports are submitted to any platform."
    echo ""
    echo "📁 Installation location: $INSTALL_DIR"
    echo "🔗 Command available: whatsapp-reporter"
else
    echo ""
    echo "❌ Installation test failed. Please check the error messages above."
    exit 1
fi
