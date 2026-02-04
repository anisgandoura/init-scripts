#!/bin/bash

# Disable extensionUnification
sed -i 's/}/,\n  "chat.extensionUnification.enabled": false\n}/' ~/.local/share/code-server/User/settings.json

# Download files
# Copilot
wget --retry-on-http-error=429 -O github.copilot-chat.vsix.gz \
  "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/0.35.3/vspackage"

gunzip github.copilot-chat.vsix.gz
code-server --install-extension github.copilot-chat.vsix
rm github.copilot-chat.vsix
