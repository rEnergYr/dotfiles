<div align="center">

# ⚙️ GitHub Actions Workflows

*Automated CI/CD workflows for modern development*

[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-Automated-1e1e2e.svg?style=for-the-badge&logo=github-actions)](https://github.com/features/actions)
[![Docker](https://img.shields.io/badge/Docker-Enabled-1e1e2e.svg?style=for-the-badge&logo=docker)](https://www.docker.com)
[![NPM](https://img.shields.io/badge/NPM-Publishing-1e1e2e.svg?style=for-the-badge&logo=npm)](https://www.npmjs.com)

</div>

---

## ✨ Features

- 🔍 **Code Linting** - Automated code quality checks
- 🐳 **Docker Build & Push** - Container image automation
- 📦 **NPM Publishing** - Automatic package releases
- 🏷️ **Git Tagging** - Semantic versioning & releases
- 🚀 **Production Ready** - Battle-tested workflows

---

## 📋 Available Workflows

### 🔍 Linter (`linter.yaml`)

Runs code quality checks on your repository.

**Triggers:**

- Push to main branch
- Pull requests

**Features:**

- Multi-language linting support
- Fail-fast on errors
- Detailed error reporting

---

### 🐳 Docker Build (`build-docker.yaml`)

Builds and pushes Docker images to Docker Hub.

**Triggers:**

- Manual dispatch
- Tag creation
- Release publication

**Requires:**

- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_TOKEN` - Docker Hub access token
- `DOCKER_REPOSITORY` - Target repository name

**Features:**

- Multi-platform builds
- Image tagging with Git SHA
- Automated registry push

---

### 📦 NPM Publish (`npm.yaml`)

Publishes packages to NPM registry.

**Triggers:**

- Manual dispatch
- Tag creation (v*)

**Requires:**

- `NPM_TOKEN` - NPM authentication token

**Features:**

- Version validation
- Automated publishing
- Registry authentication

---

### 🏷️ Release (`release.yml`)

Creates Git tags and GitHub releases from package version.

**Triggers:**

- Manual dispatch
- Pull request merge (with `release 🎉` label)

**Features:**

- Reads version from `package.json`
- Creates annotated Git tags
- Generates GitHub releases
- Changelog integration

---

## 📁 Directory Structure

```
github-actions/
├── linter.yaml        # Code quality workflow
├── build-docker.yaml  # Docker build & push
├── npm.yaml          # NPM package publishing
├── release.yml       # Git tagging & releases
└── README.md         # This file
```

---

## 🔐 Required GitHub Secrets

Configure these secrets in your repository settings (`Settings > Secrets and variables > Actions`):

| Secret | Description | Required For |
|--------|-------------|--------------|
| `DOCKER_USERNAME` | Docker Hub account username | Docker workflows |
| `DOCKER_TOKEN` | Docker Hub access token | Docker workflows |
| `DOCKER_REPOSITORY` | Docker repository name | Docker workflows |
| `NPM_TOKEN` | NPM registry authentication token | NPM publishing |

### 🔑 How to Get Tokens

**Docker Hub:**

1. Go to [Docker Hub Account Settings](https://hub.docker.com/settings/security)
2. Click "New Access Token"
3. Copy the token and add to GitHub secrets

**NPM:**

1. Go to [NPM Access Tokens](https://www.npmjs.com/settings/~/tokens)
2. Generate new token with "Automation" type
3. Copy the token and add to GitHub secrets

---

## 🏷️ Pull Request Labels

Create these labels in your repository for optimal workflow automation:

| Label | Color | Description | Emoji |
|-------|-------|-------------|-------|
| **feature** | `#A2EEEF` | New feature or enhancement | ✨ |
| **bugfix** | `#D73A4A` | Bug fix or issue resolution | 🐞 |
| **documentation** | `#0075CA` | Documentation improvements | 📚 |
| **release** | `#8BB85D` | Draft a new release | 🎉 |
| **automerge** | `#D787EB` | Auto-merge via CI | 🔀 |

---

## 🚀 Usage Examples

### Using Linter Workflow

```yaml
# Automatically runs on push/PR
# No configuration needed - just push your code!
```

### Manual Docker Build

```bash
# Trigger manually from Actions tab
# Or create a tag
git tag v1.0.0
git push origin v1.0.0
```

### Publishing to NPM

```bash
# Update package version
npm version patch  # or minor/major

# Push tag to trigger workflow
git push --follow-tags
```

### Creating a Release

1. Update version in `package.json`
2. Create PR with label `release 🎉`
3. Merge PR
4. Workflow creates tag and release automatically

---

## 📝 Workflow Templates

### Basic Linter Setup

```yaml
name: Lint Code

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run lint
```

### Docker Multi-Platform Build

```yaml
- name: Build and push
  uses: docker/build-push-action@v5
  with:
    context: .
    platforms: linux/amd64,linux/arm64
    push: true
    tags: ${{ secrets.DOCKER_REPOSITORY }}:latest
```

---

## 🎯 Best Practices

1. **Use Branch Protection** - Require status checks before merging
2. **Cache Dependencies** - Speed up workflows with caching
3. **Matrix Builds** - Test across multiple Node.js versions
4. **Semantic Versioning** - Follow semver for releases
5. **Conventional Commits** - Use conventional commits for changelog generation

---

## 🔧 Customization

### Adding Custom Linting Steps

```yaml
- name: Custom Lint
  run: |
    npm run lint:typescript
    npm run lint:prettier
    npm run lint:markdown
```

### Environment-Specific Builds

```yaml
env:
  NODE_ENV: production
  BUILD_TARGET: ${{ github.ref_name }}
```

---

## 📊 Workflow Status Badges

Add to your README:

```markdown
![Lint](https://github.com/username/repo/workflows/Lint/badge.svg)
![Build](https://github.com/username/repo/workflows/Docker/badge.svg)
![Release](https://github.com/username/repo/workflows/Release/badge.svg)
```

---

<div align="center">

Crafted in Middle-Stack ⚔️ for automated workflows

*Part of [dotfiles](../..) collection*

</div>
