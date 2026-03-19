# Exercise 3: Power User

**Goal:** Learn advanced Git techniques that save time and recover from mistakes.

---

## Part A: git stash — Save Work for Later

Sometimes you need to switch branches but aren't ready to commit yet.

1. Make some changes to any file (but do **not** commit):
   ```bash
   echo "work in progress..." >> pancakes.txt
   ```

2. Stash the changes:
   ```bash
   git stash
   ```
   Your working directory is now clean.

3. Check the stash list:
   ```bash
   git stash list
   ```

4. Do something else (switch branches, pull, etc.). When you're ready, restore your work:
   ```bash
   git stash pop
   ```

5. Verify the changes are back:
   ```bash
   git diff
   ```

### Stash with a Message

```bash
git stash push -m "WIP: new pancake topping"
```

### View and Drop Stashes

```bash
# View all stashes
git stash list

# View contents of a specific stash
git stash show stash@{0}

# Apply without removing from list
git stash apply stash@{0}

# Remove a specific stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

---

## Part B: git reflog — Your Safety Net

The reflog records every time HEAD changes. It can recover "lost" commits.

1. Create and commit a file:
   ```bash
   echo "important data" > important.txt
   git add important.txt
   git commit -m "Add important file"
   ```

2. Now "accidentally" delete it with a hard reset:
   ```bash
   git reset --hard HEAD~1
   ```
   The file is gone, and `git log` won't show the commit.

3. Use reflog to find it:
   ```bash
   git reflog
   ```
   Find the entry for "Add important file" and note its hash.

4. Recover the commit:
   ```bash
   git checkout <hash-from-reflog>
   ```
   Or create a branch from it:
   ```bash
   git switch -c recovered-work <hash-from-reflog>
   ```

5. Merge it back if needed:
   ```bash
   git switch main
   git merge recovered-work
   git branch -d recovered-work
   ```

---

## Part C: cherry-pick — Selective Commits

Cherry-pick lets you apply a specific commit from one branch to another.

1. Create a branch with multiple commits:
   ```bash
   git switch -c experiments
   echo "experiment 1" > exp1.txt
   git add exp1.txt && git commit -m "Experiment 1"
   echo "experiment 2" > exp2.txt
   git add exp2.txt && git commit -m "Experiment 2"
   echo "experiment 3" > exp3.txt
   git add exp3.txt && git commit -m "Experiment 3"
   ```

2. Find the hash of "Experiment 2":
   ```bash
   git log --oneline
   ```

3. Switch to main and cherry-pick only that commit:
   ```bash
   git switch main
   git cherry-pick <hash-of-experiment-2>
   ```

4. Verify:
   ```bash
   ls
   git log --oneline
   ```
   Only `exp2.txt` was brought over — not exp1 or exp3.

---

## Part D: Interactive Rebase — Cleaning Up History

Interactive rebase lets you squash, reorder, or edit commits before sharing.

> **Warning:** Never rebase commits that have been pushed to a shared branch.

1. Create several small commits:
   ```bash
   echo "line 1" > story.txt
   git add story.txt && git commit -m "Start story"
   echo "line 2" >> story.txt
   git add story.txt && git commit -m "Add line 2"
   echo "line 3" >> story.txt
   git add story.txt && git commit -m "Add line 3"
   echo "line 4" >> story.txt
   git add story.txt && git commit -m "Fix typo in line 3"
   ```

2. Squash the last 4 commits into one:
   ```bash
   git rebase -i HEAD~4
   ```
   Your editor opens with a list of commits. Change `pick` to `squash` (or `s`) for all but the first:
   ```
   pick abc1234 Start story
   squash def5678 Add line 2
   squash ghi9012 Add line 3
   squash jkl3456 Fix typo in line 3
   ```

3. Save and close. Git opens another editor for the combined commit message. Write a clean message:
   ```
   Write complete story
   ```

4. Verify:
   ```bash
   git log --oneline
   ```
   Four commits have been combined into one.

---

## Part E: Rebase vs Merge

Both integrate changes from one branch into another, but they work differently.

### Merge (what you already know)

```bash
git switch main
git merge feature-branch
```
Creates a **merge commit** — history shows the branches converging.

### Rebase

```bash
git switch feature-branch
git rebase main
```
Replays your commits **on top of** main — history is linear.

### When to Use Each

| Situation | Recommended |
|-----------|-------------|
| Integrating a feature branch into main | `merge` |
| Updating your feature branch with latest main | `rebase` |
| Cleaning up local commits before sharing | `rebase -i` |
| Shared/public branches | **Never rebase** |

### Try It

1. Create a branch, make commits, then rebase onto main:
   ```bash
   git switch -c rebase-demo
   echo "new feature" > feature.txt
   git add feature.txt && git commit -m "Add feature"
   ```

2. Meanwhile, add a commit to main:
   ```bash
   git switch main
   echo "hotfix" > hotfix.txt
   git add hotfix.txt && git commit -m "Apply hotfix"
   ```

3. Rebase the feature branch:
   ```bash
   git switch rebase-demo
   git rebase main
   ```

4. Compare the history:
   ```bash
   git log --oneline --graph --all
   ```
   The feature commit now appears **after** the hotfix, as if you wrote it later.

---

## Reflection Questions

1. When would you use `git stash` instead of creating a WIP commit?
2. How long does the reflog keep entries? (Hint: check `git reflog expire`)
3. What's the risk of rebasing commits that have already been pushed?
4. When is a linear history (rebase) preferable to a branching history (merge)?
