# Exercise 2: Team Up — Collaborative Git with GitHub

**Goal:** Experience a full collaborative workflow using GitHub — remotes, branches, pull requests, and code review.

**Project:** A simple counter web page (`index.html`, `script.js`, `style.css` — included in this folder).

---

## Phase 1: Set Up the Remote Repository

> One team member (the "owner") does this. Others wait.

1. Go to [GitHub](https://github.com/) and create a **new repository**.
   - Name it whatever you like (e.g., `counter-app`).
   - **Do not** initialize with a README, `.gitignore`, or license.

2. Clone the empty repository:
   ```bash
   git clone <your-repository-url>
   cd <repo-name>
   ```

3. Copy the starter files (`index.html`, `script.js`, `style.css`) from this exercise folder into your repo.

4. Push the initial code:
   ```bash
   git add .
   git commit -m "Initial commit: counter app"
   git push origin main
   ```

---

## Phase 2: Collaborators Join

1. The owner invites teammates as collaborators:
   - Go to **Settings > Collaborators** in the GitHub repo.
   - Add each teammate by GitHub username.

2. Each collaborator clones the repository:
   ```bash
   git clone <repository-url>
   cd <repo-name>
   ```

3. Verify everyone has the same starting code:
   ```bash
   git log --oneline
   ```

---

## Phase 3: Feature Branches

Each person creates their own feature branch and implements a change.

```bash
git switch -c feature/<yourname>
```

### Feature Ideas

Pick one (or invent your own):

| Feature | Hint |
|---------|------|
| Add a **reset** button | New `<button>` in HTML, event listener in JS |
| Add a **double** button (+2 / -2) | Modify JS to add new listeners |
| Show the **timestamp** of last change | Use `new Date().toLocaleTimeString()` in JS |
| Add a **counter limit** (min 0, max 100) | Add conditions in the increment/decrement handlers |
| Style the page with **colors and fonts** | Modify `style.css` |
| Add a **dark mode** toggle | Add a button + CSS class toggle |
| Display counter in **words** (e.g., "five") | Add a number-to-words function in JS |
| Add **keyboard shortcuts** (+/- keys) | Use `keydown` event listener |

> Feel free to use ChatGPT or other resources if you need help with HTML/CSS/JS specifics.

After implementing your feature:

```bash
git add .
git commit -m "Add <feature description>"
```

---

## Phase 4: Push and Create a Pull Request

1. Push your branch:
   ```bash
   git push origin feature/<yourname>
   ```

2. On GitHub, create a **Pull Request**:
   - Go to the repository page.
   - Click **"Pull requests"** > **"New pull request"**.
   - Select your branch in the "compare" dropdown.
   - Add a title and description explaining your changes.
   - Click **"Create pull request"**.

---

## Phase 5: Code Review

1. Review a teammate's pull request:
   - Go to the **"Pull requests"** tab.
   - Click on their PR.
   - Review the **"Files changed"** tab.
   - Leave comments or suggestions.

2. Address feedback on your own PR if needed:
   ```bash
   # Make changes on your branch
   git add .
   git commit -m "Address review feedback"
   git push origin feature/<yourname>
   ```
   The PR updates automatically.

---

## Phase 6: Merge and Handle Conflicts

1. Merge the first pull request on GitHub (click **"Merge pull request"**).

2. Before merging the next PR, the author should update their branch:
   ```bash
   git switch main
   git pull origin main
   git switch feature/<yourname>
   git merge main
   ```
   Resolve any conflicts that arise, then push:
   ```bash
   git push origin feature/<yourname>
   ```

3. Repeat until all PRs are merged.

---

## Phase 7: Sync Everyone

After all PRs are merged, everyone pulls the latest:

```bash
git switch main
git pull origin main
```

Open `index.html` in a browser to see the combined result!

---

## Reflection Questions

1. Why do we use feature branches instead of committing directly to `main`?
2. What is the purpose of code review?
3. What happens if two people edit the same line in different branches?
4. How does `git pull` differ from `git fetch`?
