#!/bin/bash

# Download files
# Copilot
wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/1.388.0/vspackage -O copilot.vsix.gz
wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/0.32.5/vspackage -O copilot-chat.vsix.gz

# Disable extensionUnification
sed -i 's/}/,\n  "chat.extensionUnification.enabled": false\n}/' ~/.local/share/code-server/User/settings.json

# Install extensions
gunzip copilot.vsix.gz 
code-server --install-extension copilot.vsix
rm copilot.vsix

gunzip copilot-chat.vsix.gz 
code-server --install-extension copilot-chat.vsix
rm copilot-chat.vsix
