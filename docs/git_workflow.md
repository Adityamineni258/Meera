# Git Workflow

We follow a simple Git workflow based on feature branches. This ensures that the `main` branch is always stable and deployable.

1.  **Create a new branch:**
    When you start working on a new feature or a bug fix, create a new branch from the `main` branch. Use a descriptive branch name that reflects the feature or fix you are working on.

    For a new feature:
    ```bash
    git checkout -b feature/your-feature-name
    ```

    For a bug fix:
    ```bash
    git checkout -b fix/your-bug-fix-name
    ```

2.  **Commit your changes:**
    Make your changes and commit them with a clear and descriptive commit message. We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

    Example commit messages:
    - `feat: Add user authentication`
    - `fix: Correct spelling in the welcome message`
    - `docs: Update the project structure documentation`

    ```bash
    git add .
    git commit -m "feat: Implement the new feature"
    ```

3.  **Push your changes:**
    Push your branch to the remote repository.
    ```bash
    git push origin feature/your-feature-name
    ```

4.  **Create a pull request:**
    Open a pull request (PR) from your feature branch to the `main` branch. Provide a clear description of the changes you have made in the PR description. If your PR addresses an issue, link the issue in the description.

5.  **Code Review:**
    At least one other team member must review and approve the PR before it can be merged.

6.  **Merge:**
    Once the PR is approved, it can be merged into the `main` branch.
