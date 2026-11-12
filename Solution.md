# Git Workflow Assignment – Solution

## Requirement 19 – Addressing Code Review Feedback

During the review of Pull Request #16, I identified that the commit message "Some changes" was too vague and did not follow Git best practices.

I left a comment explaining that commit messages should clearly describe the changes made to the code.

To address this issue, I created a new branch named `feature/step-4-review-fix` and applied the changes with a more descriptive commit message: `Add Avery User instance to main_runner.py`.

I pushed the new branch to GitHub and created Pull Request #17 targeting `develop`. After reviewing the changes, I successfully merged the pull request.

This approach improves the readability and maintainability of the Git history.

## Requirement 21 – Releasing Version 1.0.0

To deliver the first production version of the software, I used Git-flow in Sourcetree.

First, I updated my local `develop` branch with the latest changes from GitHub. I then created a release branch named `release/1.0.0` from `develop`.

After preparing the release, I used the Finish Release option in Git-flow, which merged the release branch into both `master` and `develop`.

I created the version tag `1.0.0` with the message "Release version 1.0.0" and pushed the updated branches and tag to GitHub.

The release branch was deleted locally after the process finished successfully.

This workflow separates development from production and provides a clearly identified version of the software.

## Requirement 22 – Implementing a New Feature

After releasing version 1.0.0, a new requirement was introduced to improve how User objects are displayed.

Since this was a new functionality rather than a production bug, I used a feature branch instead of a hotfix branch.

Using Git-flow, I created `feature/user-string-method` from `develop` and added the following method to the `User` class in `app/core/user.py`:

```python
def __str__(self):
    return f"name: {self.username}, bio: {self.bio}"
```

I committed the changes with the message `Add __str__ method to User class` and pushed the branch to GitHub.

Using a feature branch allows new functionality to be developed independently without directly changing the production version.