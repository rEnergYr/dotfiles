# GitHub Workflows

Automated process for my development

## Directory & file structure

```
📂 Workflows
┣ 📜 linter.yaml (lint the code base)
┣ 📜 build-docker.yaml (build docker image & push to dockerhub)
┣ 📜 npm.yaml (push package to npm registry)
┗ 📜 release.yaml (create tag and release using the package version)
```

## GitHub Secrets

```dotenv
DOCKER_USERNAME
DOCKER_TOKEN
DOCKER_REPOSITORY
NPM_TOKEN
```

## PR Labels

| Name             | Color   | Description                                |
|------------------|---------|--------------------------------------------|
| feature ✨       | #A2EEEF | New feature                                |
| bugfix 🐞        | #D73A4A | Fix something that doesn't work            |
| documentation 📚 | #0075CA | Improvements or additions to documentation |
| release 🎉       | #8BB85D | Draft a new release                        |
| automerge 🔀     | #D787EB | Merge branch using CI                      |
