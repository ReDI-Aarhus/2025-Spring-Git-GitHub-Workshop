# Exercise 2: Reading the Story of Your Code

**Goal:** Learn to inspect the history of a Git repository — who changed what, when, and why.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first (you need a repo with several commits).

---

## Part A: Viewing the Log

1. See the full commit history:
   ```bash
   git log
   ```
   Each entry shows the **commit hash**, author, date, and message.

2. Try a compact one-line view:
   ```bash
   git log --oneline
   ```

3. See a visual graph (useful once you have branches):
   ```bash
   git log --oneline --graph --all
   ```

4. Limit the output to the last 2 commits:
   ```bash
   git log -2
   ```

---

## Part B: Inspecting a Single Commit

1. Copy a commit hash from `git log --oneline` (e.g., `a1b2c3d`).

2. View the full details of that commit:
   ```bash
   git show <commit-hash>
   ```
   This shows the commit message **and** the exact changes (diff) introduced.

---

## Part C: Comparing Commits

1. Compare two commits to see what changed between them:
   ```bash
   git diff <older-hash>..<newer-hash>
   ```

2. Compare your current working directory against the last commit:
   ```bash
   git diff HEAD
   ```

---

## Part D: Finding Who Changed a Line

1. Run `git blame` on one of your files:
   ```bash
   git blame pancakes.txt
   ```
   Each line shows the commit hash, author, and date of the last change to that line.

---

## Part E: Searching the History

1. Search commit messages for a keyword:
   ```bash
   git log --grep="pancakes"
   ```

2. Search for a string that was added or removed in the code:
   ```bash
   git log -S "maple syrup"
   ```

---

## Reflection Questions

1. When would you use `git log --oneline` vs the full `git log`?
2. How does `git blame` help in a team setting?
3. What is the difference between `git diff` (no arguments) and `git diff HEAD`?
