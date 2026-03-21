# Exercise 3: Branching and Merging

**Goal:** Learn to create branches, work on them in isolation, and merge changes back together — all from VS Code.

**Prerequisites:** Complete [Exercise 1](01-core-workflow.md) first.

---

## Part A: Create a New Branch

The **current branch** is always shown in the **bottom-left corner** of the VS Code status bar (e.g., `main`).

1. Click on the branch name in the status bar.
   A picker appears at the top of the screen.

2. Select **"Create new branch..."** and type `desserts` as the branch name. Press Enter.

3. VS Code creates the branch and switches to it automatically.
   Check the bottom-left — it now shows `desserts`.

   > You are now working in isolation. Changes here don't affect `main`.

---

## Part B: Make Changes on the Branch

1. In the **Explorer**, create a new file `brownies.txt` and add:
   ```
   Chocolate Brownies
   ===================
   Ingredients: chocolate, butter, sugar, eggs, flour
   Melt chocolate and butter, mix in sugar, eggs, flour.
   Bake at 180°C for 25 minutes.
   ```

2. In the **Source Control panel**, stage `brownies.txt` (`+` icon) and commit with the message `Add brownies recipe`.

---

## Part C: Switch Branches and Observe

1. Click the branch name in the status bar (`desserts`) and select `main` to switch back.

2. Look at the **Explorer panel** — `brownies.txt` has **disappeared**.
   It only exists on the `desserts` branch!

3. Switch back to `desserts` (click status bar → select `desserts`) — the file reappears.

   > This is one of Git's superpowers: each branch has its own isolated snapshot.

---

## Part D: Visualize Your Branches

1. Open the **Command Palette** (`Ctrl+Shift+P`) and search for **"Git: View History"**.

2. In the history view, notice that `main` and `desserts` are at different points — they have **diverged**.

   > This visual shows you exactly how your branches relate to each other.

---

## Part E: Merge the Branch into Main

1. First, switch to `main` (click the status bar and select `main`).

2. Open the **Command Palette** (`Ctrl+Shift+P`) and search for **"Git: Merge Branch..."**.

3. Select `desserts` from the list. VS Code merges it into `main`.

4. Check the **Explorer** — `brownies.txt` is now on `main` too!

5. Open the history view again to see that the branch has been merged.

---

## Part F: Clean Up

1. To delete the merged branch, open the **Command Palette** and search for **"Git: Delete Branch..."**.

2. Select `desserts`. Since it's been merged, VS Code lets you delete it safely.

---

## Reflection Questions

1. Why do files "disappear" when you switch branches?
2. In what real-world situation would you use a branch? (Think: new feature, bug fix, experiment...)
3. What is a "fast-forward merge" — and why does it happen?
