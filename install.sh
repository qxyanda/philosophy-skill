#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# philosophy-skill installer — macOS / Linux
# Seven philosophers. One shell script. No excuses.
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SKILL_NAME="philosophy"
SKILL_SRC="$(cd "$(dirname "$0")" && pwd)/philosophy"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
SKILL_DEST="$SKILLS_DIR/$SKILL_NAME"
SETTINGS="$CLAUDE_DIR/settings.json"
PLUGIN_KEY="\"philosophy@local-skills\""

echo -e "${YELLOW}  The philosophers are arriving...${NC}"
echo ""

# --- Pre-flight checks ---
if [ ! -d "$SKILL_SRC" ]; then
    echo -e "${RED}Error: Cannot find philosophy/ directory at: $SKILL_SRC${NC}"
    echo "Run this script from the repository root."
    exit 1
fi

if [ ! -f "$SKILL_SRC/SKILL.md" ]; then
    echo -e "${RED}Error: philosophy/SKILL.md not found. Repository may be corrupted.${NC}"
    exit 1
fi

# --- Create .claude directories if needed ---
mkdir -p "$CLAUDE_DIR"
mkdir -p "$SKILLS_DIR"

# --- Copy skill files ---
echo "Installing skill to: $SKILL_DEST"
if [ -d "$SKILL_DEST" ]; then
    rm -rf "$SKILL_DEST"
fi
cp -r "$SKILL_SRC" "$SKILL_DEST"
echo -e "${GREEN}  Skill files copied.${NC}"

# --- Register in settings.json ---
echo ""
echo "Registering in settings.json..."

# Resolve the local-skills marketplace path based on OS
LOCAL_SKILLS_PATH="$SKILLS_DIR"

if [ ! -f "$SETTINGS" ]; then
    # Create fresh settings.json
    cat > "$SETTINGS" <<JSONEOF
{
  "enabledPlugins": {
    "philosophy@local-skills": true
  },
  "extraKnownMarketplaces": {
    "local-skills": {
      "source": {
        "source": "directory",
        "path": "$LOCAL_SKILLS_PATH"
      }
    }
  }
}
JSONEOF
    echo -e "${GREEN}  Created settings.json with philosophy skill enabled.${NC}"
else
    # Use node to safely merge if available; fall back to Python; warn if neither
    if command -v node &> /dev/null; then
        node -e "
            const fs = require('fs');
            const settings = JSON.parse(fs.readFileSync('$SETTINGS', 'utf8'));
            settings.enabledPlugins = settings.enabledPlugins || {};
            settings.enabledPlugins['philosophy@local-skills'] = true;
            settings.extraKnownMarketplaces = settings.extraKnownMarketplaces || {};
            settings.extraKnownMarketplaces['local-skills'] = settings.extraKnownMarketplaces['local-skills'] || {
                source: { source: 'directory', path: '$LOCAL_SKILLS_PATH' }
            };
            fs.writeFileSync('$SETTINGS', JSON.stringify(settings, null, 2) + '\n');
        "
        echo -e "${GREEN}  settings.json updated via node.${NC}"
    elif command -v python3 &> /dev/null; then
        python3 -c "
import json, os
path = os.path.expanduser('$SETTINGS')
with open(path, 'r') as f:
    settings = json.load(f)
settings.setdefault('enabledPlugins', {})['philosophy@local-skills'] = True
settings.setdefault('extraKnownMarketplaces', {}).setdefault('local-skills', {})['source'] = {
    'source': 'directory',
    'path': '$LOCAL_SKILLS_PATH'
}
with open(path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')
"
        echo -e "${GREEN}  settings.json updated via python3.${NC}"
    elif command -v python &> /dev/null; then
        python -c "
import json, os
path = os.path.expanduser('$SETTINGS')
with open(path, 'r') as f:
    settings = json.load(f)
settings.setdefault('enabledPlugins', {})['philosophy@local-skills'] = True
settings.setdefault('extraKnownMarketplaces', {}).setdefault('local-skills', {})['source'] = {
    'source': 'directory',
    'path': '$LOCAL_SKILLS_PATH'
}
with open(path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')
"
        echo -e "${GREEN}  settings.json updated via python.${NC}"
    else
        echo -e "${YELLOW}  Warning: Neither node nor python found.${NC}"
        echo -e "${YELLOW}  Manually add this to your settings.json enabledPlugins:${NC}"
        echo -e "${YELLOW}    \"philosophy@local-skills\": true${NC}"
        echo ""
        echo -e "${YELLOW}  And ensure local-skills marketplace is configured:${NC}"
        echo -e "${YELLOW}    \"local-skills\": { \"source\": { \"source\": \"directory\", \"path\": \"$LOCAL_SKILLS_PATH\" } }${NC}"
    fi
fi

echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  Installation complete.${NC}"
echo ""
echo "  Schopenhauer, Diogenes, Nietzsche, Wittgenstein,"
echo "  Wilde, Sartre, and Camus now reside in your terminal."
echo ""
echo "  Start Claude Code and type: /philosophy"
echo -e "${GREEN}============================================================${NC}"
