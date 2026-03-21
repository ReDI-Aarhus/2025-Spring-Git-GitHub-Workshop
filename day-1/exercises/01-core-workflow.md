# Exercise 1: Core Workflow — Edit, Stage, Commit

**Goal:** Learn the fundamental Git workflow using VS Code's Source Control panel.

**Scenario:** You are starting a personal recipe book. Each recipe is a text file. No coding knowledge needed!

---

## Before You Start

Open VS Code and use the terminal inside it (**Terminal → New Terminal**) for the few setup steps that require it. Everything else will use the **Source Control panel** (the icon that looks like a branch on the left sidebar, or press `Ctrl+Shift+G` / `Cmd+Shift+G`).

---

## Part A: Create Your Repository

1. In the terminal, create and open a new folder:
   ```bash
   mkdir recipe-book && cd recipe-book && code .
   ```

2. In VS Code, open the **Source Control panel** (`Ctrl+Shift+G`). Click **"Initialize Repository"**.

   > VS Code runs `git init` for you — no command needed!

3. The Source Control panel is now active. Notice it shows **0 changes** — your repository is empty.

---

## Part B: Your First Commit

1. Create a new file: In the **Explorer panel**, click the **New File** icon and name it `pancakes.txt`.

2. Add this content and save (`Ctrl+S`):
   ```
   Simple Pancakes
   ================
   Ingredients: flour, eggs, milk, butter
   Mix everything together and cook on a hot pan.
   ```

3. Switch to the **Source Control panel**. You'll see `pancakes.txt` listed under **Changes** with a `U` badge (Untracked).

4. **Stage the file:** Hover over `pancakes.txt` and click the **`+` (Stage Changes)** icon next to it.
   The file moves to **Staged Changes**.

5. **Write a commit message:** Click in the message box at the top of the Source Control panel and type:
   ```
   Add pancakes recipe
   ```

6. **Commit:** Click the **✓ Commit** button (or press `Ctrl+Enter`).

   > The changes are now saved to Git history!

---

## Part C: Edit, View Diff, and Commit Again

1. Open `pancakes.txt` and add a new line at the end:
   ```
   Flip after 2 minutes. Serve with maple syrup.
   ```
   Save the file.

2. In the **Source Control panel**, click on `pancakes.txt` under **Changes**.
   VS Code opens a **diff view** — additions are shown in green, removals in red.

   > This is the VS Code equivalent of `git diff`.

3. Stage the file (`+` icon), write the message `Add flipping instructions to pancakes`, and commit.

---

## Part D: Add More Files

1. Create `omelette.txt` in the Explorer and add:
   ```
   Cheese Omelette
   ================
   Ingredients: eggs, cheese, salt, pepper
   Beat eggs, pour into pan, add cheese, fold and serve.
   ```

2. Stage and commit with the message `Add cheese omelette recipe`.

---

## Part E: Ignoring Files

Sometimes you have files you don't want Git to track (temp files, editor backups, etc.).

1. Create a file called `notes.tmp` in the Explorer. Add any text to it and save.

2. In the Source Control panel you'll see it listed as untracked. To tell Git to ignore it:
   - Create a new file called `.gitignore` in the Explorer.
   - Add this line and save:
     ```
     *.tmp
     ```

3. Notice `notes.tmp` **disappears** from the Source Control panel — Git is now ignoring it.

4. Stage `.gitignore` and commit with the message `Add .gitignore to exclude temp files`.

---

## Reflection Questions

1. What is the difference between an **untracked** file and a **modified** file in the Source Control panel?
2. Why do we stage changes before committing, instead of committing directly?
3. What happens if you close VS Code without committing — are your file edits lost?
