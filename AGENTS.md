# AGENTS.md

This is a personal sandbox repository containing standalone code experiments and snippets.

## Languages

JavaScript, PHP, Python (2.x), C, Shell/Bash, Turbo Pascal, HTML/CSS, Meteor.js, TypeScript, Lua

## Build/Test Commands

No formal build system or test framework. Files are standalone scripts/programs.

- **Meteor app** (`meteor/leaderboard/`): Run with `meteor run`
- **C programs**: Compile with `gcc filename.c -o output`
- **Python scripts**: Run with `python filename.py`
- **Shell scripts**: Run with `bash filename.sh` or `./filename.sh`
- **TypeScript** (`new/`): Various Node.js/Deno/Bun projects with their own package.json
- **Lua scripts** (`new/lua/`): Run with `lua filename.lua`

## Code Style Guidelines

No enforced style configs. Observed conventions:

- **Indentation**: Tabs (JS, C, PHP), 4 spaces (Python)
- **JS**: Mix of ES6 and older syntax
- **Python**: Python 2 syntax (print without parentheses)
- **C**: K&R-style braces
- **Naming**: snake_case for Python/Shell, camelCase for JS

## Error Handling

No consistent pattern - these are experiments/proofs of concept, not production code.

## Sensitive Files - DO NOT COMMIT

The following patterns contain sensitive data and should never be committed:

### Private Keys & Certificates
- `*.pem` - Private keys and certificates
- `*.key` - Private key files
- `**/certbot/**` - Let's Encrypt certificate data

### Credentials & Secrets
- `.env`, `.envrc` - Environment variable files
- `*password*.txt`, `*key*.txt` - Credential files
- `clientkey.json` - API client keys (e.g., Philips Hue)
- `teams.json`, `team-*.json` - Slack OAuth tokens
- `config.json` in `new/node/` - Contains infrastructure endpoints

### Tokens & API Keys
- Files containing `xoxb-*` patterns (Slack bot tokens)
- Files containing `xoxp-*` patterns (Slack user tokens)

### Logs with Sensitive Data
- `new/php/slack-emoji-reactor/**/log/*.txt` - Contains tokens in logs

### Infrastructure Data
- `new/docker/ntrc/metabase/data/` - Database and certificate data
- VPC flow logs (`*.log.gz` with AWS account IDs)

## Directory Overview (new/)

| Directory | Purpose |
|-----------|---------|
| `athena/` | AWS Athena query examples |
| `bun/` | Bun runtime experiments |
| `chrome/` | Chrome extension (AWS SSO clicker) |
| `dagger*/` | Dagger CI/CD experiments |
| `docker/` | Docker configs (Metabase, nginx) |
| `hue/` | Philips Hue smart lighting control |
| `k8s/` | Kubernetes manifests |
| `lua/` | Lua date/time scripts |
| `nix/` | Nix flake configurations |
| `node/` | Node.js experiments (Kafka, Pulumi, AWS SDK, etc.) |
| `php/` | Slack emoji reactor (PHP/Lambda) |
| `pulumi/` | Pulumi IaC experiments |
| `shell/` | Shell scripts (AWS, K8s, Kafka utilities) |
| `slack/` | Slack app (Deno/Bolt) |
| `typescript/` | TypeScript experiments |
| `wasm/` | WebAssembly experiments |
