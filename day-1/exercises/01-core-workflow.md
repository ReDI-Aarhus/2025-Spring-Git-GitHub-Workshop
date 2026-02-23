# Exercise 1: Your First Repository

**Goal:** Learn the core Git workflow — creating a repository, tracking files, staging changes, and committing.

**Scenario:** You are starting a personal recipe book. Each recipe is a text file. No coding knowledge needed!

---

## Part A: Create Your Repository

1. Open your terminal and create a new folder:
   ```bash
   mkdir recipe-book
   cd recipe-book
   ```

2. Initialize a Git repository:
   ```bash
   git init
   ```

3. Check the status — you should see an empty repository:
   ```bash
   git status
   ```

---

## Part B: Your First Commit

1. Create your first recipe file:
   ```bash
   # Use any text editor you like. Example with nano:
   nano pancakes.txt
   ```
   Add some content:
   ```
   Simple Pancakes
   ================
   Ingredients: flour, eggs, milk, butter
   Mix everything together and cook on a hot pan.
   ```

2. Check what Git sees:
   ```bash
   git status
   ```
   You should see `pancakes.txt` listed as an **untracked** file.

3. Stage the file (tell Git you want to include it in the next commit):
   ```bash
   git add pancakes.txt
   ```

4. Check the status again — the file should now be under "Changes to be committed":
   ```bash
   git status
   ```

5. Commit the file with a descriptive message:
   ```bash
   git commit -m "Add pancakes recipe"
   ```

---

## Part C: Edit, Diff, and Commit Again

1. Open `pancakes.txt` and add a step:
   ```
   Simple Pancakes
   ================
   Ingredients: flour, eggs, milk, butter
   Mix everything together and cook on a hot pan.
   Flip after 2 minutes. Serve with maple syrup.
   ```

2. See exactly what changed:
   ```bash
   git diff
   ```

3. Stage and commit:
   ```bash
   git add pancakes.txt
   git commit -m "Add flipping instructions to pancakes"
   ```

---

## Part D: Add More Files

1. Create a second recipe:
   ```bash
   nano omelette.txt
   ```
   ```
   Cheese Omelette
   ================
   Ingredients: eggs, cheese, salt, pepper
   Beat eggs, pour into pan, add cheese, fold and serve.
   ```

2. Stage and commit:
   ```bash
   git add omelette.txt
   git commit -m "Add cheese omelette recipe"
   ```

---

## Part E: Ignoring Files

Sometimes you have files you don't want Git to track (editor backups, OS files, etc.).

1. Create a file you want to ignore:
   ```bash
   echo "my secret ingredient notes" > notes.tmp
   ```

2. Create a `.gitignore` file:
   ```bash
   nano .gitignore
   ```
   Add:
   ```
   *.tmp
   ```

3. Check that Git ignores the `.tmp` file:
   ```bash
   git status
   ```
   You should see `.gitignore` as untracked, but **not** `notes.tmp`.

4. Stage and commit:
   ```bash
   git add .gitignore
   git commit -m "Add .gitignore to exclude temp files"
   ```

---

## Reflection Questions

1. What is the difference between an **untracked** file and a **modified** file?
2. Why do we have a separate "staging" step instead of committing directly?
3. What happens if you run `git commit` without running `git add` first?
