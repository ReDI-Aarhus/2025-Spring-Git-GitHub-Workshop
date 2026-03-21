# Exercise 2: Exploring History

**Goal:** Learn to read the history of a repository — who changed what, when, and why — using VS Code's built-in tools.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first (you need a repo with several commits).

---

## Part A: The Timeline View

VS Code has a built-in **Timeline** panel that shows the commit history for any file.

1. In the **Explorer panel**, click on `pancakes.txt` to open it.

2. At the bottom of the Explorer panel, find the **Timeline** section and expand it.
   You'll see a list of commits that touched this file, with dates and messages.

3. Click on a commit entry to see what changed in that file at that point in time.
   VS Code opens a diff view showing the exact lines added or removed.

   > This replaces `git log` + `git show` for file-level history.

---

## Part B: The Full Repository History

To see commits across the **whole repository** (not just one file), use the **Source Control panel**.

1. Open the **Source Control panel** (`Ctrl+Shift+G`).

2. Click the **`...` (Views and More Actions)** menu at the top of the panel.

3. Select **"View History"** or look for the **Git History / Graph** option.

   > If you don't see this, open the **Command Palette** (`Ctrl+Shift+P`) and search for **"Git: View History"**.

4. A list of all commits appears. Each entry shows:
   - The **commit message**
   - The **author** and **date**
   - A short **hash** (unique ID for that commit)

---

## Part C: Inspecting a Commit

1. In the history list, click on any commit to expand it.

2. You'll see the list of files that were changed in that commit.

3. Click on a file to open the **diff view** — what was added (green) and removed (red).

   > This is the VS Code equivalent of `git show <commit-hash>`.

---

## Part D: Comparing Two Versions

1. In the **Timeline** panel (open a file in Explorer first), right-click on an older commit entry.

2. Select **"Compare with Current"** to see a diff between the selected snapshot and the current file.

   > Useful for answering: "What exactly changed since last week?"

---

## Part E: Viewing Blame (Who Changed Each Line?)

1. Open a file like `pancakes.txt` in the editor.

2. Open the **Command Palette** (`Ctrl+Shift+P`) and search for **"Git: Toggle File Blame"** (you may need to type "blame").

3. VS Code shows an annotation next to each line — the commit hash and message that last modified it.

   > This is the VS Code equivalent of `git blame`. Very useful in team settings to understand *why* a line exists.

---

## Reflection Questions

1. What's the difference between the **Timeline** view (per file) and the **full repository history**?
2. When would you use "Compare with Current" on an old commit?
3. How does the **blame** view help you understand code written by a teammate?
