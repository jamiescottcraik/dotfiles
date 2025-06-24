# Copilot Coding Agent Environment

Custom environment configuration for @jamiescottcraik's repositories.

## What's Included

### 🔧 Environment Variables & Aliases
- Smart project detection and auto-activation of virtual environments
- Git shortcuts (`gs`, `gl`, `gp`, etc.)
- Development shortcuts (`nr`, `dc`, `py`, etc.)
- Auto-loading of `.env` files

### 📦 Pre-installed Tools

#### Node.js/JavaScript
- TypeScript, ts-node, nodemon
- Prettier, ESLint, Biome
- Vercel CLI, Netlify CLI
- Build tools (concurrently, wait-on)

#### Python
- IPython, Black, Flake8, pytest
- Django, FastAPI, uvicorn
- Data science stack (pandas, numpy, matplotlib)
- AI/ML tools (OpenAI, Langchain)
- Database clients (PostgreSQL, MongoDB, Redis)

#### Ruby
- Bundler, Rails, RuboCop, Solargraph

#### Development Tools
- GitHub CLI with Copilot extension
- Docker utilities with BuildKit enabled
- Pre-commit hooks support

## Usage

These files are automatically loaded when you:
1. Open a Codespace
2. Use Copilot to run commands
3. Start a new terminal session

### Quick Commands

```bash
# Check what type of project you're in
check_project

# Common workflows
nr dev        # npm run dev
dc up         # docker-compose up
py manage.py  # python manage.py
gs            # git status

# Create and enter directory
mkcd new-feature

# Check what's running on ports
ports

# Quick HTTP server
serve 3000
```

### Adding Project-Specific Config

Create a `.env` file in your project root - it will be automatically loaded.

### Extending

To add more tools, update the files in your dotfiles repo:
- `env.sh` - Environment variables and aliases
- `requirements.txt` - Python packages
- `postStart.sh` - One-time setup commands
