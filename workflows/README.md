# GitHub Workflows

Automated process for my development

## Directory & file structure

```
📂 Workflows
┣ 📜 linter.yaml (lint the code base)
┣ 📜 build.yaml (build docker image & push to dockerhub)
┗ 📜 release.yaml (create tag and release using the package version)
┗ 📜 npm.yaml (push package to npm registry)
```

## GitHub Secrets

```dotenv
DOCKER_USERNAME
DOCKER_PASSWORD
DOCKER_REPOSITORY
NPM_TOKEN
```

## PR Labels

| Name             | Color   | Description                                |
|------------------|---------|--------------------------------------------|
| feature ✨       | #a2eeef | New feature                                |
| bugfix 🐞        | #d73a4a | Fix something that doesn't work            |
| documentation 📚 | #0075ca | Improvements or additions to documentation |
| release 🎉       | #8BB85D | Draft a new release                        |
| automerge 🔀     | #D787EB | Merge branch using CI                      |
