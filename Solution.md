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

---

## Part 2 – Docker Configuration and Gitflow

### Setting Up the PostgreSQL Database

For Part 2, I continued working in the same GitHub repository and followed the Gitflow workflow.

I created a feature branch named `feature/part2-docker` from `develop` to implement the Docker configuration.

First, I modified `docker-compose.yml` by renaming the existing database service from `db` to `postgres`.

I configured PostgreSQL using the `postgres:11.5-alpine` image and exposed port `5432`. I also configured the database username, password, and database name using environment variables.

I updated the application's `DATABASE_URL` and `depends_on` configuration to reference the new `postgres` service.

To protect sensitive information, I stored the database credentials in a local `.env` file, which is excluded from Git using `.gitignore`.

### Creating the Custom Docker Container

I created a new folder named `src` in the root of the repository.

Inside this folder, I created two files:

- `checkstatus.sh`
- `Production-Dockerfile`

The `checkstatus.sh` script uses the PostgreSQL utility `pg_isready` to check whether the database accepts connections.

If PostgreSQL is not ready, the script waits two seconds before checking again. Once the database becomes available, the script prints a success message and exits.

I initially created `Production-Dockerfile` using the `alpine:3.20` image and installed `postgresql-client` to provide the `pg_isready` utility.

I also added a new service named `checkstatus` to `docker-compose.yml`, using `./src` as its build context and `Production-Dockerfile` as its Dockerfile.

I tested the configuration using Docker Compose. PostgreSQL successfully accepted connections, and the `checkstatus` container exited with code `0`.

### Preparing Production Version 1.1.0

Following the assignment requirements, I updated `Production-Dockerfile` to use the image `citycase/assessment2:1.0`.

I executed the image using the command:

`docker run --rm citycase/assessment2:1.0`

The image displayed the message "ERROR VERSION – SOMETHING IS WRONG".

I captured this output and saved the screenshot as `screenshots/part2-error-version.png`. The screenshot was included in the GitHub repository as evidence.

I successfully built the custom Docker image using version `1.0`.

After testing, I committed the changes on `feature/part2-docker` and pushed the branch to GitHub.

I created Pull Request #18 targeting `develop`. Since no merge conflicts were reported, I merged the feature branch into `develop`.

Next, I created `release/1.1.0` from `develop` and pushed it to GitHub.

I created a release Pull Request targeting `master` and merged it successfully.

I then created and pushed the annotated Git tag `1.1.0` to identify this production release.

Finally, I merged `master` back into `develop` to synchronize the release history and pushed the updated branch.

### Fixing the Outdated Production Image – Hotfix 1.1.1

After the production release, I identified that `citycase/assessment2:1.0` was outdated.

I checked the available tags on Docker Hub and identified version `2.0` as the updated image.

Because this issue affected the production release, I followed Gitflow and created a hotfix branch named `hotfix/1.1.1` from `master`.

I updated the first instruction in `src/Production-Dockerfile` from:

`FROM citycase/assessment2:1.0`

to:

`FROM citycase/assessment2:2.0`

I then rebuilt the custom Docker image to verify that the updated version could be used successfully.

During testing, the `checkstatus` container initially exited with code `2` because the shell script had incompatible line endings.

I identified the problem using Docker container logs and converted `checkstatus.sh` to Unix-style LF line endings.

After rebuilding and recreating the containers, the script successfully detected that PostgreSQL was accepting connections.

I verified the result using Docker Compose logs and confirmed that the `checkstatus` container exited with code `0`.

I committed the production image change with the message `Hotfix: update production Docker image to version 2.0` and pushed `hotfix/1.1.1` to GitHub.

I created a hotfix Pull Request targeting `master` and merged it successfully.

Afterward, I created and pushed the annotated Git tag `1.1.1`.

Finally, I merged `master` back into `develop` and pushed the updated branch to GitHub, ensuring that the production fix was included in both branches.

### Conflict Resolution and Gitflow Justification

During Part 2, Git did not report any merge conflicts when integrating the feature, release, or hotfix branches.

However, I encountered a runtime issue caused by Windows-style line endings in the shell script. I resolved this by converting the file to Unix-style LF line endings and rebuilding the Docker image.

I used a feature branch for the initial Docker configuration because it introduced new functionality.

I used a release branch to prepare version `1.1.0` for production and created an annotated Git tag to identify the released version.

I used a hotfix branch for version `1.1.1` because the outdated Docker image was a problem in an already released production version.

The hotfix was merged into `master` and synchronized with `develop` to prevent the same problem from appearing in future releases.

This workflow maintains separation between development and production, preserves a clear history of changes, and makes the release and hotfix process traceable through GitHub commits, pull requests, and version tags.