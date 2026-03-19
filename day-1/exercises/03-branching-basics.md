# Exercise 3: Parallel Universes

**Goal:** Learn to create branches, switch between them, and merge changes back together.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first.

---

## Part A: Create and Switch Branches

1. See what branch you are on:
   ```bash
   git branch
   ```
   You should see `* main` (or `* master`).

2. Create a new branch called `desserts`:
   ```bash
   git branch desserts
   ```

3. Switch to the new branch:
   ```bash
   git switch desserts
   ```
   (Alternative: `git checkout desserts`)

4. Verify you are on the `desserts` branch:
   ```bash
   git branch
   ```

---

## Part B: Make Changes on the Branch

1. Create a new recipe file:
   ```bash
   nano brownies.txt
   ```
   ```
   Chocolate Brownies
   ===================
   Ingredients: chocolate, butter, sugar, eggs, flour
   Melt chocolate and butter, mix in sugar, eggs, flour.
   Bake at 180C for 25 minutes.
   ```

2. Stage and commit:
   ```bash
   git add brownies.txt
   git commit -m "Add brownies recipe"
   ```

---

## Part C: Switch Back and Observe

1. Switch back to `main`:
   ```bash
   git switch main
   ```

2. List your files:
   ```bash
   ls
   ```
   Notice that `brownies.txt` is **gone** — it only exists on the `desserts` branch!

3. Switch back to `desserts` and the file reappears:
   ```bash
   git switch desserts
   ls
   ```

---

## Part D: Visualize Your Branches

1. View the branch graph:
   ```bash
   git log --oneline --graph --all
   ```
   You should see your branches diverging.

---

## Part E: Merge the Branch

1. Switch to the branch you want to merge **into** (usually `main`):
   ```bash
   git switch main
   ```

2. Merge the `desserts` branch:
   ```bash
   git merge desserts
   ```

3. Verify the merge:
   ```bash
   ls
   git log --oneline --graph --all
   ```
   `brownies.txt` should now be on `main` too.

---

## Part F: Clean Up

1. Delete the merged branch (it's no longer needed):
   ```bash
   git branch -d desserts
   ```

2. Verify it's gone:
   ```bash
   git branch
   ```

---

## Bonus: Shortcut

You can create **and** switch to a new branch in one command:
```bash
git switch -c new-branch-name
```

---

## Reflection Questions

1. Why do files "disappear" when you switch branches?
2. What does "fast-forward merge" mean? (Hint: check `git log --graph` after merging.)
3. When might you want to keep a branch instead of deleting it?
