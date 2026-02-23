# Exercise 1: When Worlds Collide

**Goal:** Learn to create, understand, and resolve merge conflicts confidently.

---

## Part A: Create a Controlled Conflict

1. Create a fresh practice repository (or use your recipe-book from Day 1):
   ```bash
   mkdir conflict-lab
   cd conflict-lab
   git init
   ```

2. Create a starting file and commit:
   ```bash
   cat > menu.txt << 'EOF'
   Today's Menu
   ============
   Appetizer: Soup
   Main: Pasta
   Dessert: Cake
   EOF
   git add menu.txt
   git commit -m "Add initial menu"
   ```

3. Create a branch and change the main course:
   ```bash
   git switch -c italian-menu
   ```
   Edit `menu.txt` — change the Main line to:
   ```
   Main: Risotto
   ```
   ```bash
   git add menu.txt
   git commit -m "Change main to risotto"
   ```

4. Switch back to `main` and make a **different** change to the same line:
   ```bash
   git switch main
   ```
   Edit `menu.txt` — change the Main line to:
   ```
   Main: Sushi
   ```
   ```bash
   git add menu.txt
   git commit -m "Change main to sushi"
   ```

5. Merge and trigger the conflict:
   ```bash
   git merge italian-menu
   ```
   Git will tell you there is a conflict in `menu.txt`.

---

## Part B: Read the Conflict Markers

Open `menu.txt`. You will see something like:

```
Today's Menu
============
Appetizer: Soup
<<<<<<< HEAD
Main: Sushi
=======
Main: Risotto
>>>>>>> italian-menu
Dessert: Cake
```

| Marker | Meaning |
|--------|---------|
| `<<<<<<< HEAD` | Start of **your current branch's** version |
| `=======` | Separator between the two versions |
| `>>>>>>> italian-menu` | End of **the incoming branch's** version |

---

## Part C: Resolve the Conflict Manually

1. Edit `menu.txt` — remove the markers and choose (or combine) the content:
   ```
   Today's Menu
   ============
   Appetizer: Soup
   Main: Sushi & Risotto
   Dessert: Cake
   ```

2. Stage the resolved file:
   ```bash
   git add menu.txt
   ```

3. Complete the merge:
   ```bash
   git commit -m "Resolve menu conflict: combine sushi and risotto"
   ```

4. Clean up:
   ```bash
   git branch -d italian-menu
   ```

---

## Part D: Using VS Code's Merge Tool

If you use VS Code, it provides a visual interface for conflicts:

1. Create another conflict (repeat Part A with different content).
2. When the conflict occurs, open the file in VS Code.
3. You will see colored highlights and buttons:
   - **Accept Current Change** (your branch)
   - **Accept Incoming Change** (the other branch)
   - **Accept Both Changes**
   - **Compare Changes** (side-by-side view)
4. Click the option you want, then stage and commit.

---

## Part E: Multi-File Conflict Challenge

1. Create two files with shared content:
   ```bash
   echo "Chef: Gordon" > kitchen.txt
   echo "Price: $25" > pricing.txt
   git add kitchen.txt pricing.txt
   git commit -m "Add kitchen and pricing info"
   ```

2. On a new branch, change **both** files:
   ```bash
   git switch -c branch-a
   # Change Chef to "Jamie" in kitchen.txt
   # Change Price to "$30" in pricing.txt
   git add -A && git commit -m "Branch A changes"
   ```

3. On `main`, make **different** changes to the same files:
   ```bash
   git switch main
   # Change Chef to "Julia" in kitchen.txt
   # Change Price to "$20" in pricing.txt
   git add -A && git commit -m "Main changes"
   ```

4. Merge and resolve **both** conflicts:
   ```bash
   git merge branch-a
   ```

---

## Part F: Aborting a Merge

If a conflict feels too complex and you want to start over:

```bash
git merge --abort
```

This returns your repository to the state it was in before you ran `git merge`.

---

## Reflection Questions

1. Why does Git not automatically resolve conflicts?
2. When would you use `git merge --abort` instead of resolving the conflict?
3. How can good communication with teammates help prevent conflicts?
