#!/bin/bash

# Disable extensionUnification
python3 - <<'PY'
import json, os

paths = [
  os.path.expanduser("~/.local/share/code-server/User/settings.json"),
  os.path.expanduser("~/.config/code-server/User/settings.json"),
]

for path in paths:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    data = {}
    if os.path.exists(path):
        try:
            with open(path, "r", encoding="utf-8") as f:
                data = json.load(f)
        except Exception:
            data = {}
    data["chat.extensionUnification.enabled"] = False
    data["extensions.autoCheckUpdates"] = False
    data["extensions.autoUpdate"] = False
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")
    print("Wrote:", path)
PY


# Download files
# Copilot
wget --retry-on-http-error=429 -O github.copilot-chat.vsix.gz \
  "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/0.35.3/vspackage"

gunzip github.copilot-chat.vsix.gz
code-server --install-extension github.copilot-chat.vsix
rm github.copilot-chat.vsix
