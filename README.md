# dotfiles → Copilot Coding-Agent

Everything inside `.copilot/` is copied to `~/.copilot/` when a Codespace starts.
Files and their purpose:

| File | Purpose |
| ---- | ------- |
| `env.sh` | Sourced on every interactive shell and Copilot agent session |
| `requirements.txt` | `pip install -r` is executed automatically |
| `postStart.sh` | Runs **once** after the container is built (`chmod +x` it) |

Add any other language-specific manifests you need (e.g. `package.json`, `gemfile`, etc.).
