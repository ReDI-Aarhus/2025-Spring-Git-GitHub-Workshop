# Exercise 4: Revert and Reset

**Goal:** Learn how to undo mistakes in Git — safely and permanently — using VS Code.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first.

---

## Understanding the Two Undo Tools

| Tool | What it does | Safe to share? |
|------|-------------|---------------|
| **Revert** | Creates a new commit that undoes a previous one. History is kept. | ✅ Yes |
| **Reset** | Moves the branch pointer backwards. History is rewritten. | ⚠️ Only for local commits |

---

## Part A: Discard Unsaved Changes

Before committing, you can throw away edits to a file with a single click.

1. Open `pancakes.txt` and add a bad line at the end:
   ```
   Add dishsoap for extra bubbles.
   ```
   Save the file.

2. In the **Source Control panel**, the file appears under **Changes**.

3. Hover over `pancakes.txt` and click the **↺ (Discard Changes)** icon.

4. VS Code asks for confirmation. Click **Discard Changes**.
   The file goes back to exactly how it was at the last commit.

   > This is like `git checkout -- <file>`. Use it when you want to throw away edits you haven't committed yet.

---

## Part B: Revert a Commit (Safe Undo)

`git revert` creates a **new commit** that cancels out a previous one. Your history is preserved and it's safe for shared work.

1. Open `pancakes.txt` and add:
   ```
   Add pineapple for extra flavor.
   ```
   Save, stage, and commit with the message `Add questionable ingredient`.

2. Open the history view: **Command Palette** (`Ctrl+Shift+P`) → **"Git: View History"**.

3. Find the commit `Add questionable ingredient`. Right-click on it and select **"Revert Commit..."** (or **"Undo Commit"** depending on VS Code version).

4. VS Code creates a new commit that undoes the change. Check the history — you'll see **both** the original and the revert commit.

5. Open `pancakes.txt` to confirm the pineapple line is gone.

   > Revert is always the safe choice when you've already shared your commits with others.

---

## Part C: Reset — Rewriting Local History

> **Warning:** Only use reset on commits that you haven't pushed or shared with anyone.

### Soft Reset — Undo the commit, keep changes staged

1. Add a temporary line to `pancakes.txt`, save, stage, and commit with the message `Add test content`.

2. Open the **Command Palette** and search for **"Git: Undo Last Commit"**.
   VS Code performs a **soft reset** — the commit disappears but your changes stay staged in the Source Control panel, ready to recommit.

   > Use this when you committed too early and want to adjust the message or add more changes.

### Mixed Reset — Undo the commit and unstage changes

1. Commit the staged changes again (same content is still staged from the soft reset).

2. This time, in the terminal:
   ```bash
   git reset HEAD~1
   ```
   The commit is gone and the file is now in **Changes** (unstaged). You can edit further before staging again.

### Hard Reset — Discard the commit entirely

> **Danger:** This permanently deletes the commit and all its changes.

1. Re-add the content and commit it one more time.

2. In the terminal:
   ```bash
   git reset --hard HEAD~1
   ```
   The commit and all changes are completely gone.

3. In the **Source Control panel**, notice the file no longer appears under Changes.

---

## Part D: Preview — Merge Conflicts

Tomorrow we'll resolve conflicts properly. For now, let's see what one looks like.

1. Create a branch called `spicy-version` from the status bar.

2. Open `pancakes.txt` and change the ingredients line to:
   ```
   Ingredients: flour, eggs, milk, butter, chili flakes
   ```
   Stage and commit with the message `Add chili flakes to pancakes`.

3. Switch back to `main` via the status bar.

4. Edit the **same line** in `pancakes.txt`:
   ```
   Ingredients: flour, eggs, milk, butter, vanilla extract
   ```
   Stage and commit with the message `Add vanilla extract to pancakes`.

5. **Command Palette** → **"Git: Merge Branch..."** → select `spicy-version`.

6. VS Code shows a **merge conflict warning** and marks the file with a `C` badge in the Source Control panel. Click the file to open the **Merge Editor**.

7. VS Code shows you both versions side by side. For now, just pick one version by clicking **"Accept Current Change"** or **"Accept Incoming Change"**.

8. Stage the resolved file and commit with the message `Resolve pancake ingredient conflict`.

9. Delete the `spicy-version` branch: **Command Palette** → **"Git: Delete Branch..."**.

---

## Reflection Questions

1. What is the difference between **Discard Changes** (Part A) and **Revert Commit** (Part B)?
2. When would you use **soft reset** vs **hard reset**?
3. Why is `git revert` considered safe while `git reset --hard` is considered dangerous?
4. What do you think causes a merge conflict — when does Git get confused?
