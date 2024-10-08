# GitHub-action-playground
This is a playground for GitHub Actions.

## Workflows
- github-actions-demo.yml
  - This is a simple workflow that runs on push event.
- on-merge.yml
  - This is a simple workflow that runs on pull_request event.
- condiction-workflow.yml
  - This is a workflof that only runs when the branch is included in the config.yml



## caller and callee workflow
- caller.yml
  - This is a workflow that calls callee-workflow.yml
- callee-workflow.yml
  - This is a workflow that is called by caller.yml