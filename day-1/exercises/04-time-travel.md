# Exercise 4: Going Back in Time

**Goal:** Learn to revisit old commits, undo changes safely, and get a first look at merge conflicts.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first.

---

## Part A: Detached HEAD — Visiting the Past

1. Find an older commit hash:
   ```bash
   git log --oneline
   ```

2. Check out that commit:
   ```bash
   git checkout <old-commit-hash>
   ```
   Git will warn you about a **"detached HEAD"** state. This means you are looking at an old snapshot but not on any branch.

3. Look around — your files are exactly as they were at that point in time:
   ```bash
   ls
   cat pancakes.txt
   ```

4. Go back to the present:
   ```bash
   git switch main
   ```

5. **Bonus:** Create a branch from an old commit:
   ```bash
   git checkout <old-commit-hash>
   git switch -c old-experiment
   ```
   Now you can make changes based on that old state. Switch back to `main` when done:
   ```bash
   git switch main
   ```

---

## Part B: git revert — Safe Undo

`git revert` creates a **new** commit that undoes the changes from a previous commit. History is preserved.

1. First, make a commit to revert. Edit `pancakes.txt` and add a bad line:
   ```
   Add pineapple for extra flavor.
   ```
   ```bash
   git add pancakes.txt
   git commit -m "Add questionable ingredient"
   ```

2. Now revert that commit:
   ```bash
   git revert HEAD
   ```
   Git opens your editor for the revert message — save and close it.

3. Check the log:
   ```bash
   git log --oneline
   ```
   You should see both the original commit and the revert commit.

4. Verify the file is back to normal:
   ```bash
   cat pancakes.txt
   ```

---

## Part C: git reset — Rewriting History

> **Warning:** `git reset` rewrites history. Use it only on commits you haven't shared with others.

### Soft Reset (keeps changes staged)

1. Make a commit:
   ```bash
   echo "test content" > test.txt
   git add test.txt
   git commit -m "Add test file"
   ```

2. Undo the commit but keep the changes staged:
   ```bash
   git reset --soft HEAD~1
   ```

3. Check:
   ```bash
   git status
   ```
   `test.txt` is still staged, but the commit is gone.

### Mixed Reset (keeps changes unstaged) — the default

1. Commit again:
   ```bash
   git commit -m "Add test file again"
   ```

2. Undo the commit and unstage:
   ```bash
   git reset HEAD~1
   ```

3. Check:
   ```bash
   git status
   ```
   `test.txt` is now an untracked/modified file.

### Hard Reset (discards everything)

> **Danger:** This permanently deletes uncommitted changes.

1. Commit once more:
   ```bash
   git add test.txt
   git commit -m "Add test file once more"
   ```

2. Completely discard the commit and all changes:
   ```bash
   git reset --hard HEAD~1
   ```

3. Check:
   ```bash
   git status
   ls
   ```
   `test.txt` is completely gone.

---

## Part D: Merge Conflict Preview

Tomorrow we'll resolve conflicts properly. For now, let's see what one looks like.

1. Create two branches that edit the **same line** of the same file:
   ```bash
   git switch -c spicy-version
   ```

2. Edit `pancakes.txt` — change the ingredients line to:
   ```
   Ingredients: flour, eggs, milk, butter, chili flakes
   ```
   ```bash
   git add pancakes.txt
   git commit -m "Add chili flakes to pancakes"
   ```

3. Switch back to main and make a different edit to the **same line**:
   ```bash
   git switch main
   ```
   Edit `pancakes.txt` — change the ingredients line to:
   ```
   Ingredients: flour, eggs, milk, butter, vanilla extract
   ```
   ```bash
   git add pancakes.txt
   git commit -m "Add vanilla extract to pancakes"
   ```

4. Try to merge:
   ```bash
   git merge spicy-version
   ```
   Git will report a **merge conflict**.

5. Open the file to see the conflict markers:
   ```bash
   cat pancakes.txt
   ```
   You'll see something like:
   ```
   <<<<<<< HEAD
   Ingredients: flour, eggs, milk, butter, vanilla extract
   =======
   Ingredients: flour, eggs, milk, butter, chili flakes
   >>>>>>> spicy-version
   ```

6. For now, resolve it by choosing one version (or combining them). Edit the file to remove the markers, then:
   ```bash
   git add pancakes.txt
   git commit -m "Resolve pancake ingredient conflict"
   ```

7. Clean up:
   ```bash
   git branch -d spicy-version
   ```

---

## Reflection Questions

1. What is the difference between `git revert` and `git reset`?
2. When would you use `--soft` vs `--mixed` vs `--hard` reset?
3. Why is `git revert` considered "safe" while `git reset --hard` is "dangerous"?
4. What do the `<<<<<<<`, `=======`, and `>>>>>>>` markers mean in a conflict?
