#!/bin/bash
set -e

echo "🚀 Setting up your Pro Development Environment..."

# Install global npm packages
npm install -g pnpm
npm install -g @anthropic-ai/mcp-playwright
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @anthropic-ai/mcp-brave-search

# Setup Git
if [ -z "$(git config --global user.name)" ]; then
  git config --global user.name "Developer"
fi
if [ -z "$(git config --global user.email)" ]; then
  git config --global user.email "dev@example.com"
fi

git config --global init.defaultBranch main
git config --global pull.rebase false

# Setup SSH permissions
if [ -d ~/.ssh ]; then
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/* 2>/dev/null || true
fi

# Install project dependencies if package.json exists
if [ -f package.json ]; then
  echo "📦 Installing npm dependencies..."
  pnpm install
fi

# Setup Python virtual environment if requirements.txt exists
if [ -f requirements.txt ]; then
  echo "🐍 Setting up Python environment..."
  python3 -m venv .venv
  source .venv/bin/activate
  pip install -r requirements.txt
fi

# Setup Zsh plugins
if [ -f ~/.zshrc ]; then
  # Add useful aliases
  echo "
# Custom aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gpl='git pull'
alias gst='git stash'
alias gsp='git stash pop'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -fd'

# Development shortcuts
alias dev='npm run dev'
alias build='npm run build'
alias test='npm run test'
alias lint='npm run lint'
alias format='npm run format'
" >> ~/.zshrc
fi

echo "✅ Setup complete! Your environment is ready."
echo ""
echo "🔧 Available tools:"
echo "   - Node.js 20 + TypeScript"
echo "   - Python 3.12"
echo "   - Docker & Docker Compose"
echo "   - GitHub CLI (gh)"
echo "   - pnpm, npm"
echo "   - VS Code with Copilot & extensions"
echo ""
echo "📝 Useful aliases: gs, ga, gc, gp, dev, build, test"