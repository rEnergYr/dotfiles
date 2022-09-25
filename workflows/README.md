# GitHub Workflows

Automated process for my development

## Directory & file structure

```
📂 Workflows
┗ 📂 Node
  ┣ 📜 linter.yml (lint the code base)
  ┣ 📜 build.yml (build docker image & push to dockerhub)
  ┗ 📜 release.yml (create tag and release using the package version)
```

## GitHub Secrets

```dotenv
DOCKER_USERNAME
DOCKER_PASSWORD
DOCKER_REPOSITORY
```

## PR Labels

| Name             | Color   | Description                                |
|------------------|---------|--------------------------------------------|
| feature ✨        | #a2eeef | New feature                                |
| bugfix 🐞        | #d73a4a | Fix something that doesn't work            |
| documentation 📚 | #0075ca | Improvements or additions to documentation |
| release 🎉       | #8BB85D | Draft a new release                        |
| automerge 🔀     | #D787EB | Merge branch using CI                      |

