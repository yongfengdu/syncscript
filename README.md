# Sync values.yaml files to GenAIExample and GenAIComps

GenAIInfra/helm-charts/valuefiles.yaml is used to track which files in GenAIInfra is copied to the other 2 repos.

Before we have a better way to sync(e.g. Automatically Pull Request), we'll use the script to detect and prepare PRs to do sync manually.

## Prerequisite
We expect to have 3 repos cloned at the same directory level, and run:

`syncfiles.sh`
