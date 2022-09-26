# GithubAction

- Create the directory `.github/workflows/`
- Create a `.yml` file there, that will do the automation of build, test and deployment
- alternatively we can create workflow from `action` tab from github repository page
- example of an workflow [here](https://github.com/Shayokh144/SurveyApp/blob/main/.github/workflows/ci_danger_auto_comment_in_PR.yml)


## Workflow
- A workflow is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked in to your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

- Workflows are defined in the .github/workflows directory in a repository, and a repository can have multiple workflows, each of which can perform a different set of tasks. For example, you can have one workflow to build and test pull requests, another workflow to deploy your application every time a release is created, and still another workflow that adds a label every time someone opens a new issue.

### [Worlflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#about-yaml-syntax-for-workflows)

### name
- The name of your workflow. GitHub displays the names of your workflows on your repository's actions page. If you omit name, GitHub sets it to the workflow file path relative to the root of the repository.

### on
- To automatically trigger a workflow, use on to define which events can cause the workflow to run.
- You can define single or multiple events that can a trigger workflow, or set a time schedule. You can also restrict the execution of a workflow to only occur for specific files, tags, or branch changes.
- single event example: `on: push`
- multiple event example: `on: [push, fork]`
- push event has a branches filter that causes your workflow to run only when a push to a branch that matches the branches filter occurs, instead of when any push occurs. Example:

```
on:
  push:
    branches:
      - main
      - 'releases/**'
```
- Example of ignoring branch:

```
on:
  pull_request:
    # Sequence of patterns matched against refs/heads
    branches-ignore:    
      - 'mona/octocat'
      - 'releases/**-alpha'

```
- Example of include and exclude branch at the same time is [here](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#example-including-and-excluding-branches)

### [concurency](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency)
- Use concurrency to ensure that only a single job or workflow using the same concurrency group will run at a time.

## Events
- An event is a specific activity in a repository that triggers a workflow run. For example, activity can originate from GitHub when someone creates a pull request, opens an issue, or pushes a commit to a repository.
- List of all events [here](https://docs.github.com/en/actions/reference/events-that-trigger-workflows)


## [Jobs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobs)
- A job is a set of steps in a workflow that execute on the same runner. Each step is either a shell script that will be executed, or an action that will be run. Steps are executed in order and are dependent on each other. Since each step is executed on the same runner, you can share data from one step to another. For example, you can have a step that builds your application followed by a step that tests the application that was built.
- use of docker in jobs is [here](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idcontainer)
- To use docker container we must use linux runner

## Actions
- An action is a custom application for the GitHub Actions platform that performs a complex but frequently repeated task. Use an action to help reduce the amount of repetitive code that you write in your workflow files. An action can pull your git repository from GitHub, set up the correct toolchain for your build environment, or set up the authentication to your cloud provider.

- One can write his own actions, or can find actions to use in your workflows in the `GitHub Marketplace`.

## Runners
- A runner is a server that runs your workflows when they're triggered. Each runner can run a single job at a time. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS runners to run your workflows; each workflow run executes in a fresh, newly-provisioned virtual machine. GitHub also offers larger runners, which are available in larger configurations.




## Resources
- [Official doc](https://docs.github.com/en/actions/using-workflows)
- [Components of workflow](https://docs.github.com/en/actions/using-workflows/about-workflows#understanding-the-workflow-file)
- [Caching dependencies](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)
- Pattern matcher rules for branch and files is [here](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#patterns-to-match-branches-and-tags)
- Using bash [commands](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions)
- [Pricing](https://github.com/pricing)