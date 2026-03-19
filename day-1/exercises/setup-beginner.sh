#!/bin/bash
set -e

# =============================================================================
# Beginner Git Workshop — Repository Generator
# =============================================================================
# Creates a git-recipe-book/ directory containing a beginner-friendly Git
# workshop with 14 commits, 3 feature branches, and 6 challenge levels.
# The project is a collaborative recipe book (plain text + markdown files).
# =============================================================================

# === AUTHORS ===
AUTHOR_ALICE="Alice Chen <alice@taskmanager.dev>"
AUTHOR_BOB="Bob Martinez <bob@taskmanager.dev>"
AUTHOR_CAROL="Carol Kim <carol@taskmanager.dev>"
AUTHOR_DAVE="Dave Wilson <dave@taskmanager.dev>"

# === DETERMINISTIC DATES ===
BASE_DATE="2026-01-15T09:00:00"
COMMIT_NUM=0

# === HELPER FUNCTIONS ===

write_file() {
  local filepath="$1"
  local content="$2"
  mkdir -p "$(dirname "$filepath")"
  printf '%s' "$content" > "$filepath"
}

make_commit() {
  local author="$1"
  local message="$2"
  COMMIT_NUM=$((COMMIT_NUM + 1))
  local date_offset=$((COMMIT_NUM * 3600))
  local commit_date
  commit_date=$(date -u -j -f "%Y-%m-%dT%H:%M:%S" "$BASE_DATE" +%s 2>/dev/null || date -u -d "$BASE_DATE" +%s 2>/dev/null)
  commit_date=$((commit_date + date_offset))
  local formatted_date
  formatted_date=$(date -u -j -f "%s" "$commit_date" "+%Y-%m-%dT%H:%M:%S +0000" 2>/dev/null || date -u -d "@$commit_date" "+%Y-%m-%dT%H:%M:%S +0000" 2>/dev/null)
  export GIT_AUTHOR_DATE="$formatted_date"
  export GIT_COMMITTER_DATE="$formatted_date"
  git add -A
  git commit --author="$author" -m "$message" --quiet
  unset GIT_AUTHOR_DATE GIT_COMMITTER_DATE
}

# === INIT ===

REPO_DIR="git-recipe-book"

if [ -d "$REPO_DIR" ]; then
  echo "ERROR: Directory '$REPO_DIR' already exists. Remove it first or run in a different directory."
  exit 1
fi

mkdir "$REPO_DIR"
cd "$REPO_DIR"
git init --quiet
git checkout -b main --quiet 2>/dev/null || git checkout -b main

# =============================================================================
# MAIN HISTORY — 14 Commits
# =============================================================================

# --- Commit 1 (Alice): chore: initial project setup ---

write_file "README.md" '# Recipe Book

A collaborative collection of our favorite recipes.

## How to Contribute

1. Add your recipe as a `.txt` file in the `recipes/` folder
2. Follow the format: Title, Ingredients, Instructions
3. Commit your changes with a descriptive message
'

write_file ".gitignore" '# OS files
.DS_Store
Thumbs.db

# Editor files
*.swp
*.swo
*~
'

make_commit "$AUTHOR_ALICE" "chore: initial project setup"

# --- Commit 2 (Alice): feat: add pasta carbonara recipe ---

write_file "recipes/pasta-carbonara.txt" 'Pasta Carbonara
==============

A classic Roman pasta dish.

Ingredients:
- 400g spaghetti
- 200g guanciale (cured pork cheek), cut into small strips
- 4 large egg yolks
- 100g Pecorino Romano cheese, finely grated
- Freshly ground black pepper
- Salt for pasta water

Instructions:
1. Bring a large pot of salted water to boil
2. Cook spaghetti until al dente
3. While pasta cooks, fry guanciale in a large pan until crispy
4. In a bowl, whisk egg yolks with grated Pecorino and black pepper
5. Drain pasta, reserving 1 cup of pasta water
6. Add hot pasta to the guanciale pan (heat OFF)
7. Quickly pour egg mixture over pasta and toss vigorously
8. Add pasta water a little at a time until creamy
9. Serve immediately with extra Pecorino and black pepper

Tips:
- Never add cream — authentic carbonara gets its creaminess from eggs and cheese
- Remove pan from heat before adding egg mixture to avoid scrambling
- Use guanciale, not bacon — the flavor is completely different
'

make_commit "$AUTHOR_ALICE" "feat: add pasta carbonara recipe"

# --- Commit 3 (Bob): feat: add chocolate cake recipe ---

write_file "recipes/chocolate-cake.txt" 'Chocolate Cake
=============

A rich, moist chocolate cake for any occasion.

Ingredients:
- 2 cups all-purpose flour
- 2 cups sugar
- 3/4 cup cocoa powder
- 2 teaspoons baking soda
- 1 teaspoon salt
- 2 eggs
- 1 cup buttermilk
- 1 cup hot water
- 1/2 cup vegetable oil
- 2 teaspoons vanilla extract

Instructions:
1. Preheat oven to 175°C (350°F)
2. Mix all dry ingredients in a large bowl
3. Add eggs, buttermilk, oil, and vanilla — beat for 2 minutes
4. Stir in hot water (batter will be thin, that is normal)
5. Pour into two greased 9-inch round pans
6. Bake for 30-35 minutes until toothpick comes out clean
7. Cool in pans for 10 minutes, then turn out onto wire racks
8. Frost with your favorite chocolate frosting when completely cool

Tips:
- Hot water blooms the cocoa — do not skip this step
- Do not overmix the batter after adding water
- Cake layers can be frozen for later assembly
'

make_commit "$AUTHOR_BOB" "feat: add chocolate cake recipe"

# --- Commit 4 (Carol): feat: add greek salad recipe ---

write_file "recipes/greek-salad.txt" 'Greek Salad (Horiatiki)
======================

A refreshing traditional Greek salad — no lettuce needed!

Ingredients:
- 4 large ripe tomatoes, cut into chunks
- 1 English cucumber, sliced into half-moons
- 1 green bell pepper, sliced into rings
- 1 small red onion, thinly sliced
- 200g feta cheese (one block)
- Kalamata olives, a generous handful
- Extra virgin olive oil
- Dried oregano
- Salt and pepper

Instructions:
1. Cut tomatoes into large chunks — do not dice them small
2. Slice cucumber into thick half-moons
3. Cut bell pepper into rings
4. Thinly slice red onion
5. Arrange vegetables on a large plate
6. Place the block of feta on top (do not crumble it)
7. Scatter olives over the salad
8. Drizzle generously with olive oil
9. Sprinkle with oregano, salt, and pepper
10. Serve with crusty bread to soak up the juices

Tips:
- Use the ripest tomatoes you can find — this makes or breaks the salad
- Real horiatiki never has lettuce
- The feta should be a single slab, not crumbled
'

make_commit "$AUTHOR_CAROL" "feat: add greek salad recipe"

# --- Commit 5 (Alice): docs: add cooking tips ---

write_file "cooking-tips.md" '# Cooking Tips

## General Tips

- Read the entire recipe before starting
- Prep all ingredients before you begin cooking (mise en place)
- Taste as you go — you can always add more seasoning, but you cannot take it away
- Let meat rest after cooking to redistribute the juices
- Clean as you go to keep your workspace manageable

## Seasoning Guide

- Salt enhances other flavors — add a pinch even to sweet dishes
- Fresh herbs go in at the end, dried herbs go in at the beginning
- Toast whole spices in a dry pan before grinding for maximum flavor
- Acid (lemon juice, vinegar) brightens and balances rich dishes
- When in doubt, finish with a squeeze of lemon
'

make_commit "$AUTHOR_ALICE" "docs: add cooking tips"

# --- Commit 6 (Bob): feat: add shopping list ---

write_file "shopping-list.txt" 'Weekly Shopping List
===================

Pantry Staples:
- Extra virgin olive oil
- Salt and pepper
- All-purpose flour
- Sugar
- Cocoa powder
- Dried oregano
- Dried pasta (spaghetti)

Dairy & Eggs:
- Eggs (1 dozen)
- Buttermilk
- Pecorino Romano cheese
- Feta cheese

Meat:
- Guanciale (or pancetta as backup)

Produce:
- Tomatoes (4 large)
- Cucumber (1 English)
- Green bell pepper
- Red onion
- Lemons

Other:
- Kalamata olives
- Vanilla extract
- Vegetable oil
'

make_commit "$AUTHOR_BOB" "feat: add shopping list"

# --- Commit 7 (Carol): feat: add pancakes recipe ---

write_file "recipes/pancakes.txt" 'Fluffy Pancakes
===============

Light, fluffy pancakes perfect for a lazy weekend breakfast.

Ingredients:
- 1 1/2 cups all-purpose flour
- 3 1/2 teaspoons baking powder
- 1 tablespoon sugar
- 1/4 teaspoon salt
- 1 1/4 cups milk
- 1 egg
- 3 tablespoons melted butter
- 1 teaspoon vanilla extract

Instructions:
1. Mix flour, baking powder, sugar, and salt in a large bowl
2. Make a well in the center and pour in milk, egg, melted butter, and vanilla
3. Mix until smooth — a few small lumps are fine, do not overmix!
4. Heat a lightly oiled griddle or pan over medium-high heat
5. Pour about 1/4 cup batter per pancake onto the griddle
6. Cook until bubbles form on the surface and edges look set
7. Flip and cook until golden brown on the other side
8. Serve immediately with maple syrup, fresh berries, or whipped cream

Tips:
- Do not overmix — lumpy batter makes fluffier pancakes
- Let the batter rest for 5 minutes before cooking
- The first pancake is always a test — adjust heat as needed
- Keep cooked pancakes warm in a 90°C (200°F) oven while making the rest
'

make_commit "$AUTHOR_CAROL" "feat: add pancakes recipe"

# --- Commit 8 (Alice): docs: update cooking tips with baking section ---

write_file "cooking-tips.md" '# Cooking Tips

## General Tips

- Read the entire recipe before starting
- Prep all ingredients before you begin cooking (mise en place)
- Taste as you go — you can always add more seasoning, but you cannot take it away
- Let meat rest after cooking to redistribute the juices
- Clean as you go to keep your workspace manageable

## Seasoning Guide

- Salt enhances other flavors — add a pinch even to sweet dishes
- Fresh herbs go in at the end, dried herbs go in at the beginning
- Toast whole spices in a dry pan before grinding for maximum flavor
- Acid (lemon juice, vinegar) brightens and balances rich dishes
- When in doubt, finish with a squeeze of lemon

## Baking Basics

- Measure flour by spooning into the cup and leveling off — never pack it
- Bring eggs and butter to room temperature before baking
- Do not open the oven door during the first 20 minutes of baking
- Invest in an oven thermometer — most ovens are off by 10-15 degrees
- Baking is chemistry: follow measurements precisely
'

make_commit "$AUTHOR_ALICE" "docs: update cooking tips with baking section"

# --- Commit 9 (Bob): fix: correct chocolate cake baking temperature ---

write_file "recipes/chocolate-cake.txt" 'Chocolate Cake
=============

A rich, moist chocolate cake for any occasion.

Ingredients:
- 2 cups all-purpose flour
- 2 cups sugar
- 3/4 cup cocoa powder
- 2 teaspoons baking soda
- 1 teaspoon salt
- 2 eggs
- 1 cup buttermilk
- 1 cup hot water
- 1/2 cup vegetable oil
- 2 teaspoons vanilla extract

Instructions:
1. Preheat oven to 180°C (350°F)
2. Mix all dry ingredients in a large bowl
3. Add eggs, buttermilk, oil, and vanilla — beat for 2 minutes
4. Stir in hot water (batter will be thin, that is normal)
5. Pour into two greased 9-inch round pans
6. Bake for 30-35 minutes until toothpick comes out clean
7. Cool in pans for 10 minutes, then turn out onto wire racks
8. Frost with your favorite chocolate frosting when completely cool

Tips:
- Hot water blooms the cocoa — do not skip this step
- Do not overmix the batter after adding water
- Cake layers can be frozen for later assembly
'

make_commit "$AUTHOR_BOB" "fix: correct chocolate cake baking temperature"

# --- Commit 10 (Carol): docs: add measurement conversions to tips ---

write_file "cooking-tips.md" '# Cooking Tips

## General Tips

- Read the entire recipe before starting
- Prep all ingredients before you begin cooking (mise en place)
- Taste as you go — you can always add more seasoning, but you cannot take it away
- Let meat rest after cooking to redistribute the juices
- Clean as you go to keep your workspace manageable

## Seasoning Guide

- Salt enhances other flavors — add a pinch even to sweet dishes
- Fresh herbs go in at the end, dried herbs go in at the beginning
- Toast whole spices in a dry pan before grinding for maximum flavor
- Acid (lemon juice, vinegar) brightens and balances rich dishes
- When in doubt, finish with a squeeze of lemon

## Baking Basics

- Measure flour by spooning into the cup and leveling off — never pack it
- Bring eggs and butter to room temperature before baking
- Do not open the oven door during the first 20 minutes of baking
- Invest in an oven thermometer — most ovens are off by 10-15 degrees
- Baking is chemistry: follow measurements precisely

## Measurement Conversions

| Metric   | US         |
|----------|------------|
| 100g     | 3.5 oz     |
| 250ml    | 1 cup      |
| 15ml     | 1 tbsp     |
| 5ml      | 1 tsp      |
| 180°C    | 350°F      |
| 200°C    | 400°F      |
| 220°C    | 425°F      |
'

make_commit "$AUTHOR_CAROL" "docs: add measurement conversions to tips"

# --- Commit 11 (Alice): feat: add recipe categories to README ---

write_file "README.md" '# Recipe Book

A collaborative collection of our favorite recipes.

## Recipes

### Main Dishes
- [Pasta Carbonara](recipes/pasta-carbonara.txt)

### Salads
- [Greek Salad](recipes/greek-salad.txt)

### Breakfast
- [Fluffy Pancakes](recipes/pancakes.txt)

### Desserts
- [Chocolate Cake](recipes/chocolate-cake.txt)

## Other Files

- [Cooking Tips](cooking-tips.md) — Helpful tips and conversions
- [Shopping List](shopping-list.txt) — Weekly shopping essentials

## How to Contribute

1. Add your recipe as a `.txt` file in the `recipes/` folder
2. Follow the format: Title, Ingredients, Instructions
3. Commit your changes with a descriptive message
'

make_commit "$AUTHOR_ALICE" "feat: add recipe categories to README"

# --- Commit 12 (Bob): chore: add verification script ---

write_file "check.sh" '#!/bin/bash
# Recipe Book Workshop — Challenge Verification Script
# Usage: bash check.sh <level>

LEVEL="$1"

if [ -z "$LEVEL" ] || [ "$LEVEL" -lt 1 ] 2>/dev/null || [ "$LEVEL" -gt 6 ] 2>/dev/null; then
  echo "Usage: bash check.sh <level>"
  echo "  level: 1-6"
  echo ""
  echo "  Level 1: Core Workflow (10 pts)"
  echo "  Level 2: Exploring History (15 pts)"
  echo "  Level 3: Branching Basics (20 pts)"
  echo "  Level 4: Going Back (25 pts)"
  echo "  Level 5: FF vs Non-FF Merge (30 pts)"
  echo "  Level 6: Merge Conflict — BONUS (40 pts)"
  exit 1
fi

pass() { echo "✅ PASS: Level $LEVEL — $1"; exit 0; }
fail() {
  echo "❌ FAIL: Level $LEVEL — $1"
  if [ -n "$2" ]; then
    echo "   💡 Hint: $2"
  fi
  exit 1
}

case "$LEVEL" in
  1)
    # Level 1: Core Workflow — add a new recipe and commit it
    NEW_RECIPES=$(git diff --name-only HEAD~0 --diff-filter=A 2>/dev/null | grep "^recipes/" || true)
    ALL_RECIPES=$(git ls-files "recipes/" 2>/dev/null)
    ORIGINAL_RECIPES="recipes/chocolate-cake.txt
recipes/greek-salad.txt
recipes/pancakes.txt
recipes/pasta-carbonara.txt"
    NEW_COUNT=0
    while IFS= read -r f; do
      if [ -n "$f" ]; then
        IS_ORIGINAL=false
        while IFS= read -r orig; do
          if [ "$f" = "$orig" ]; then
            IS_ORIGINAL=true
            break
          fi
        done <<< "$ORIGINAL_RECIPES"
        if [ "$IS_ORIGINAL" = false ]; then
          NEW_COUNT=$((NEW_COUNT + 1))
        fi
      fi
    done <<< "$ALL_RECIPES"

    if [ "$NEW_COUNT" -ge 1 ]; then
      # Check it is actually committed, not just staged
      UNCOMMITTED=$(git diff --cached --name-only 2>/dev/null | grep "^recipes/" || true)
      UNTRACKED=$(git ls-files --others --exclude-standard "recipes/" 2>/dev/null || true)
      if [ -n "$UNTRACKED" ]; then
        fail "Found a new recipe file but it is not tracked by Git yet." "Use: git add recipes/your-recipe.txt"
      fi
      # Verify last commit contains a recipe file
      LAST_COMMIT_FILES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | grep "^recipes/" || true)
      if [ -z "$LAST_COMMIT_FILES" ]; then
        fail "A new recipe exists but was not in your most recent commit." "Stage and commit: git add recipes/your-file.txt && git commit -m \"feat: add my recipe\""
      fi
      pass "New recipe added and committed!"
    else
      fail "No new recipe file found in the recipes/ folder." "Create a recipe file: echo \"My Recipe\" > recipes/my-recipe.txt"
    fi
    ;;

  2)
    # Level 2: Exploring History — create answers.txt with blame/log/diff findings
    if ! git ls-files --error-unmatch "answers.txt" >/dev/null 2>&1; then
      if [ -f "answers.txt" ]; then
        fail "answers.txt exists but is not committed." "Use: git add answers.txt && git commit -m \"docs: add history exploration answers\""
      else
        fail "File answers.txt not found." "Create answers.txt with your answers and commit it."
      fi
    fi

    # Check for Bob (the answer to "who added the chocolate cake recipe?")
    if grep -qi "bob" answers.txt 2>/dev/null; then
      pass "answers.txt found with correct attribution!"
    else
      fail "answers.txt does not mention the right author." "Use git log and git blame to find who added the chocolate cake recipe."
    fi
    ;;

  3)
    # Level 3: Branching Basics — create feature/my-recipe branch with commits
    if ! git rev-parse --verify "feature/my-recipe" >/dev/null 2>&1; then
      fail "Branch feature/my-recipe not found." "Create it with: git branch feature/my-recipe  or  git checkout -b feature/my-recipe"
    fi

    AHEAD=$(git log --oneline main..feature/my-recipe 2>/dev/null | wc -l | tr -d " ")
    if [ "$AHEAD" -lt 1 ]; then
      fail "Branch feature/my-recipe has no commits ahead of main." "Switch to it and make at least one commit."
    fi

    CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
    if [ "$CURRENT_BRANCH" != "main" ]; then
      fail "You are not back on main (currently on: ${CURRENT_BRANCH:-detached HEAD})." "Switch back with: git checkout main"
    fi

    pass "Branch feature/my-recipe exists with $AHEAD commit(s), and you are on main!"
    ;;

  4)
    # Level 4: Going Back — restore the original pasta carbonara recipe
    if [ ! -f "recipes/pasta-carbonara.txt" ]; then
      fail "recipes/pasta-carbonara.txt is missing!" "The file should still exist — check git status."
    fi

    if grep -qi "guanciale" "recipes/pasta-carbonara.txt" && \
       grep -qi "pecorino" "recipes/pasta-carbonara.txt" && \
       grep -qi "egg yolk" "recipes/pasta-carbonara.txt"; then
      if grep -qi "alfredo" "recipes/pasta-carbonara.txt" || grep -qi "mozzarella" "recipes/pasta-carbonara.txt"; then
        fail "The file still contains wrong ingredients (alfredo/mozzarella)." "Restore the file from an earlier commit where it was correct."
      else
        pass "Pasta carbonara restored to the authentic recipe!"
      fi
    else
      fail "The pasta carbonara recipe is missing key ingredients (guanciale, pecorino, egg yolks)." "Look at git log -- recipes/pasta-carbonara.txt to find when it was correct."
    fi
    ;;

  5)
    # Level 5: FF vs Non-FF Merge — merge both feature branches into main
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
    if [ "$CURRENT_BRANCH" != "main" ]; then
      fail "You are not on main (currently on: ${CURRENT_BRANCH:-detached HEAD})." "Switch to main first: git checkout main"
    fi

    BREAKFAST_MERGED=false
    DESSERT_MERGED=false

    if git merge-base --is-ancestor "feature/breakfast-menu" HEAD 2>/dev/null; then
      BREAKFAST_MERGED=true
    fi
    if git merge-base --is-ancestor "feature/dessert-updates" HEAD 2>/dev/null; then
      DESSERT_MERGED=true
    fi

    if [ "$BREAKFAST_MERGED" = false ] && [ "$DESSERT_MERGED" = false ]; then
      fail "Neither feature branch has been merged into main." "Use: git merge feature/breakfast-menu  and  git merge feature/dessert-updates"
    elif [ "$BREAKFAST_MERGED" = false ]; then
      fail "feature/breakfast-menu has not been merged yet." "Use: git merge feature/breakfast-menu"
    elif [ "$DESSERT_MERGED" = false ]; then
      fail "feature/dessert-updates has not been merged yet." "Use: git merge feature/dessert-updates"
    fi

    # Check at least one merge commit exists (non-FF merge creates one)
    MERGE_COMMITS=$(git log --oneline --merges main 2>/dev/null | wc -l | tr -d " ")
    if [ "$MERGE_COMMITS" -lt 1 ]; then
      fail "Both branches are merged but no merge commit found." "One of the merges should create a merge commit automatically (non-fast-forward)."
    fi

    pass "Both branches merged into main with $MERGE_COMMITS merge commit(s)!"
    ;;

  6)
    # Level 6: Merge Conflict (BONUS) — merge feature/improved-tips and resolve conflicts
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
    if [ "$CURRENT_BRANCH" != "main" ]; then
      fail "You are not on main (currently on: ${CURRENT_BRANCH:-detached HEAD})." "Switch to main first: git checkout main"
    fi

    if ! git merge-base --is-ancestor "feature/improved-tips" HEAD 2>/dev/null; then
      fail "feature/improved-tips has not been merged into main." "Use: git merge feature/improved-tips — then resolve the conflict!"
    fi

    # Check for conflict markers
    if grep -rq "<<<<<<" cooking-tips.md 2>/dev/null || grep -rq ">>>>>>" cooking-tips.md 2>/dev/null; then
      fail "Conflict markers still present in cooking-tips.md!" "Edit the file to remove <<<<<<, ======, and >>>>>> lines, then commit."
    fi

    # Check both sections are present
    HAS_MEASUREMENT=false
    HAS_FOOD_SAFETY=false

    if grep -qi "Measurement" cooking-tips.md 2>/dev/null; then
      HAS_MEASUREMENT=true
    fi
    if grep -qi "Food Safety" cooking-tips.md 2>/dev/null; then
      HAS_FOOD_SAFETY=true
    fi

    if [ "$HAS_MEASUREMENT" = false ] && [ "$HAS_FOOD_SAFETY" = false ]; then
      fail "cooking-tips.md is missing both Measurement Conversions and Food Safety sections." "When resolving conflicts, keep content from BOTH sides."
    elif [ "$HAS_MEASUREMENT" = false ]; then
      fail "cooking-tips.md is missing the Measurement Conversions section." "You need to keep the content from main (Measurement Conversions) AND the branch (Food Safety)."
    elif [ "$HAS_FOOD_SAFETY" = false ]; then
      fail "cooking-tips.md is missing the Food Safety section." "You need to keep the content from main (Measurement Conversions) AND the branch (Food Safety)."
    fi

    pass "Merge conflict resolved — cooking-tips.md has both sections!"
    ;;
esac
'

make_commit "$AUTHOR_BOB" "chore: add verification script"

# --- Commit 13 (Alice): docs: add challenge instructions to README ---

write_file "README.md" '# Recipe Book — Git Workshop

A collaborative recipe book used to practice Git skills!

## 🎯 Challenge Levels

Work through each level in order. Use `bash check.sh <level>` to verify.

---

### Level 1: Core Workflow (10 points)

**Create a new recipe and commit it.**

1. Create a new `.txt` file in the `recipes/` folder (any recipe you like!)
2. Stage the file with `git add`
3. Commit with a descriptive message

Useful commands: `git status`, `git add`, `git commit`

```bash
bash check.sh 1
```

---

### Level 2: Exploring History (15 points)

**Use Git history to answer questions.**

Answer these questions by exploring the commit history:
1. Who added the chocolate cake recipe? (Use `git log`)
2. What change was made in commit "fix: correct chocolate cake baking temperature"? (Use `git diff` or `git show`)
3. Who wrote the "Seasoning Guide" section in cooking-tips.md? (Use `git blame`)

Create a file called `answers.txt` with your answers and commit it.

Useful commands: `git log`, `git log --oneline`, `git show <commit>`, `git diff <commit1> <commit2>`, `git blame <file>`

```bash
bash check.sh 2
```

---

### Level 3: Branching Basics (20 points)

**Create a branch, make changes, and switch back.**

1. Create a new branch called `feature/my-recipe`
2. Switch to it
3. Add a new recipe (or modify an existing file) and commit
4. Switch back to `main`

Useful commands: `git branch`, `git checkout -b`, `git switch`, `git checkout`

```bash
bash check.sh 3
```

---

### Level 4: Going Back in Time (25 points)

**Restore the pasta carbonara recipe to its original version.**

Something went wrong! The pasta carbonara recipe has been replaced with a
wrong version. Your task: restore it to the authentic recipe from an earlier
commit.

Start by checking the file: `cat recipes/pasta-carbonara.txt`
Then explore its history: `git log -- recipes/pasta-carbonara.txt`

Useful commands: `git log -- <file>`, `git checkout <commit> -- <file>`, `git restore --source=<commit> -- <file>`, `git show <commit>:<file>`

```bash
bash check.sh 4
```

---

### Level 5: Merging Branches (30 points)

**Merge two feature branches into main.**

Two team members have been working on separate branches:
- `feature/breakfast-menu` — new breakfast recipes
- `feature/dessert-updates` — updated dessert section

Your task: merge BOTH branches into `main`.

**Tip**: Try merging `feature/breakfast-menu` first, then `feature/dessert-updates`.
Pay attention to how the two merges behave differently!

Useful commands: `git branch -a`, `git log --oneline --graph --all`, `git merge <branch>`

```bash
bash check.sh 5
```

---

### Level 6: Merge Conflict — BONUS (40 points)

**Resolve a merge conflict.**

The branch `feature/improved-tips` has updates to `cooking-tips.md`, but it
conflicts with changes already on main.

1. Try to merge: `git merge feature/improved-tips`
2. Git will tell you there is a conflict in `cooking-tips.md`
3. Open the file and look for conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
4. Edit the file to keep the best of BOTH versions
5. Stage and commit the resolved file

The goal: `cooking-tips.md` should have BOTH the "Measurement Conversions"
section (from main) AND the "Food Safety" section (from the branch).

Useful commands: `git merge`, `git status`, `git add`, `git commit`, `git diff`

```bash
bash check.sh 6
```

---

## 📊 Scoring

| Level | Challenge          | Points |
|-------|--------------------|--------|
| 1     | Core Workflow      | 10     |
| 2     | Exploring History  | 15     |
| 3     | Branching Basics   | 20     |
| 4     | Going Back         | 25     |
| 5     | FF vs Non-FF Merge | 30     |
| 6     | Merge Conflict     | 40     |
| **Total** |                | **140** |

## 📁 Project Structure

```
recipes/
  pasta-carbonara.txt
  chocolate-cake.txt
  greek-salad.txt
  pancakes.txt
cooking-tips.md
shopping-list.txt
README.md
check.sh
```

## 👥 Driver Rotation (Mob Programming)

If working in groups, rotate the driver (person typing) after each level:

| Level | Driver   |
|-------|----------|
| 1     | Person A |
| 2     | Person B |
| 3     | Person C |
| 4     | Person A |
| 5     | Person B |
| 6     | Person C |

The navigator(s) help guide but do not type. Switch after completing each level!
'

make_commit "$AUTHOR_ALICE" "docs: add challenge instructions to README"

# --- Commit 14 (Dave): fix: update pasta recipe — THE MISTAKE ---

write_file "recipes/pasta-carbonara.txt" 'Pasta Carbonara
==============

A quick and easy pasta dish.

Ingredients:
- 400g spaghetti
- 1 jar store-bought alfredo sauce
- 1 cup shredded mozzarella cheese
- 2 tablespoons butter
- Garlic powder to taste
- Salt and pepper

Instructions:
1. Bring a large pot of salted water to boil
2. Cook spaghetti until al dente
3. Drain pasta and return to pot
4. Add butter and stir until melted
5. Pour alfredo sauce over pasta and stir
6. Add mozzarella cheese and stir until melted
7. Season with garlic powder, salt, and pepper
8. Serve immediately

Tips:
- Any jar sauce works — pick your favorite brand
- Add some milk if the sauce is too thick
- Sprinkle with parsley for a nice presentation
'

make_commit "$AUTHOR_DAVE" "fix: update pasta recipe"

# =============================================================================
# SHA RECORDING
# =============================================================================

COMMIT_10_SHA=$(git log --reverse --oneline main | sed -n '10p' | awk '{print $1}')
COMMIT_8_SHA=$(git log --reverse --oneline main | sed -n '8p' | awk '{print $1}')
COMMIT_3_SHA=$(git log --reverse --oneline main | sed -n '3p' | awk '{print $1}')
COMMIT_9_SHA=$(git log --reverse --oneline main | sed -n '9p' | awk '{print $1}')
PASTA_ORIGINAL_COMMIT=$(git log --reverse --oneline main | sed -n '2p' | awk '{print $1}')
MISTAKE_COMMIT=$(git log --oneline main | head -1 | awk '{print $1}')

# =============================================================================
# CHALLENGE BRANCHES
# =============================================================================

# --- feature/breakfast-menu (Level 5 — fast-forward merge) ---
# Created from main HEAD (commit 14) — can fast-forward since main won't move

git checkout -b feature/breakfast-menu --quiet

write_file "recipes/french-toast.txt" 'French Toast
============

The perfect weekend breakfast — crispy outside, custardy inside.

Ingredients:
- 4 thick slices of brioche or challah bread
- 2 large eggs
- 1/2 cup milk
- 1 teaspoon vanilla extract
- 1/2 teaspoon cinnamon
- Pinch of nutmeg
- Butter for cooking
- Maple syrup for serving

Instructions:
1. Whisk eggs, milk, vanilla, cinnamon, and nutmeg in a shallow dish
2. Melt butter in a skillet over medium heat
3. Dip each bread slice in the egg mixture, letting it soak for 10 seconds per side
4. Cook in the skillet until golden brown, about 3 minutes per side
5. Serve with maple syrup, fresh berries, or powdered sugar

Tips:
- Day-old bread works best — it absorbs more custard
- Do not soak too long or the bread will fall apart
- Keep a low-medium heat for even cooking
'

make_commit "$AUTHOR_CAROL" "feat: add french toast recipe"

# Update shopping list with breakfast items
write_file "shopping-list.txt" 'Weekly Shopping List
===================

Pantry Staples:
- Extra virgin olive oil
- Salt and pepper
- All-purpose flour
- Sugar
- Cocoa powder
- Dried oregano
- Dried pasta (spaghetti)
- Cinnamon
- Nutmeg
- Vanilla extract
- Maple syrup

Dairy & Eggs:
- Eggs (1 dozen)
- Buttermilk
- Pecorino Romano cheese
- Feta cheese
- Butter

Meat:
- Guanciale (or pancetta as backup)

Bread:
- Brioche or challah loaf

Produce:
- Tomatoes (4 large)
- Cucumber (1 English)
- Green bell pepper
- Red onion
- Lemons
- Fresh berries

Other:
- Kalamata olives
- Vegetable oil
'

make_commit "$AUTHOR_CAROL" "docs: update shopping list with breakfast items"

# --- feature/dessert-updates (Level 5 — non-fast-forward merge) ---
# Created from commit 10 — main has commits 11-14 beyond this point

git checkout main --quiet
git checkout -b feature/dessert-updates "$COMMIT_10_SHA" --quiet

write_file "recipes/tiramisu.txt" 'Tiramisu
========

The classic Italian coffee-flavored dessert.

Ingredients:
- 6 egg yolks
- 3/4 cup sugar
- 500g mascarpone cheese
- 2 cups heavy cream
- 2 cups strong espresso, cooled
- 3 tablespoons coffee liqueur (optional)
- 1 package ladyfinger biscuits (savoiardi)
- Cocoa powder for dusting
- Dark chocolate shavings (optional)

Instructions:
1. Whisk egg yolks and sugar until thick and pale yellow
2. Add mascarpone and mix until smooth
3. In a separate bowl, whip heavy cream to stiff peaks
4. Gently fold whipped cream into the mascarpone mixture
5. Mix espresso with coffee liqueur in a shallow dish
6. Quickly dip each ladyfinger in the coffee (do not soak!)
7. Layer dipped ladyfingers in a 9x13 dish
8. Spread half the cream mixture over the ladyfingers
9. Repeat with another layer of dipped ladyfingers and cream
10. Cover and refrigerate for at least 6 hours (overnight is best)
11. Dust with cocoa powder and chocolate shavings before serving

Tips:
- Use strong espresso, not regular coffee
- The quick dip is key — soggy ladyfingers ruin the texture
- This always tastes better the next day
'

make_commit "$AUTHOR_ALICE" "feat: add tiramisu recipe"

# Add frosting to chocolate cake
write_file "recipes/chocolate-cake.txt" 'Chocolate Cake
=============

A rich, moist chocolate cake for any occasion.

Ingredients:
- 2 cups all-purpose flour
- 2 cups sugar
- 3/4 cup cocoa powder
- 2 teaspoons baking soda
- 1 teaspoon salt
- 2 eggs
- 1 cup buttermilk
- 1 cup hot water
- 1/2 cup vegetable oil
- 2 teaspoons vanilla extract

Frosting:
- 1/2 cup butter, softened
- 2/3 cup cocoa powder
- 3 cups powdered sugar
- 1/3 cup milk
- 1 teaspoon vanilla extract

Instructions:
1. Preheat oven to 180°C (350°F)
2. Mix all dry ingredients in a large bowl
3. Add eggs, buttermilk, oil, and vanilla — beat for 2 minutes
4. Stir in hot water (batter will be thin, that is normal)
5. Pour into two greased 9-inch round pans
6. Bake for 30-35 minutes until toothpick comes out clean
7. Cool in pans for 10 minutes, then turn out onto wire racks

Frosting Instructions:
1. Beat butter until fluffy
2. Mix in cocoa powder
3. Alternate adding powdered sugar and milk, beating until smooth
4. Add vanilla and beat for 2 more minutes
5. Frost the cooled cake layers

Tips:
- Hot water blooms the cocoa — do not skip this step
- Do not overmix the batter after adding water
- Cake layers can be frozen for later assembly
- Chill the frosted cake for 30 minutes before serving for cleaner slices
'

make_commit "$AUTHOR_BOB" "feat: add chocolate cake frosting recipe"

# --- feature/improved-tips (Level 6 — merge conflict) ---
# Created from commit 8 — conflicts with commit 10's measurement conversions

git checkout main --quiet
git checkout -b feature/improved-tips "$COMMIT_8_SHA" --quiet

write_file "cooking-tips.md" '# Cooking Tips

## General Tips

- Read the entire recipe before starting
- Prep all ingredients before you begin cooking (mise en place)
- Taste as you go — you can always add more seasoning, but you cannot take it away
- Let meat rest after cooking to redistribute the juices
- Clean as you go to keep your workspace manageable

## Seasoning Guide

- Salt enhances other flavors — add a pinch even to sweet dishes
- Fresh herbs go in at the end, dried herbs go in at the beginning
- Toast whole spices in a dry pan before grinding for maximum flavor
- Acid (lemon juice, vinegar) brightens and balances rich dishes
- When in doubt, finish with a squeeze of lemon
- A pinch of sugar can balance overly acidic sauces

## Baking Basics

- Measure flour by spooning into the cup and leveling off — never pack it
- Bring eggs and butter to room temperature before baking
- Do not open the oven door during the first 20 minutes of baking
- Invest in an oven thermometer — most ovens are off by 10-15 degrees
- Baking is chemistry: follow measurements precisely

## Food Safety

- Wash hands for at least 20 seconds before and after handling food
- Keep raw meat separate from other ingredients
- Use a meat thermometer: chicken 74°C (165°F), beef 63°C (145°F)
- Refrigerate leftovers within 2 hours
- When in doubt, throw it out
'

make_commit "$AUTHOR_DAVE" "docs: add food safety tips and extra seasoning advice"

# =============================================================================
# FINAL STATE
# =============================================================================

git checkout main --quiet

# =============================================================================
# GENERATE SOLUTIONS-BEGINNER.MD (outside the repo)
# =============================================================================

cd ..

cat > SOLUTIONS-BEGINNER.md << SOLUTIONS_EOF
# Recipe Book Workshop — Solutions Guide

> FOR INSTRUCTORS ONLY. Do not share with participants.

## Level 1: Core Workflow (10 points)

**Task**: Create a new recipe file and commit it.

**Solution**:
\`\`\`bash
# Create any recipe file in the recipes/ folder
echo "My Favorite Sandwich
====================

Ingredients:
- 2 slices of bread
- Your favorite fillings

Instructions:
1. Put fillings between bread
2. Enjoy!" > recipes/my-sandwich.txt

# Stage and commit
git add recipes/my-sandwich.txt
git commit -m "feat: add my sandwich recipe"
\`\`\`

**What students learn**: The basic add → commit workflow.

**Common mistakes**:
- Forgetting to \`git add\` before committing
- Creating the file outside the \`recipes/\` folder
- Not committing (just staging)

---

## Level 2: Exploring History (15 points)

**Task**: Use git log, diff, and blame to answer questions.

**Answers**:
1. **Who added the chocolate cake recipe?** Bob Martinez (commit $COMMIT_3_SHA)
2. **What changed in the temperature fix?** 175°C was changed to 180°C (commit $COMMIT_9_SHA)
3. **Who wrote the Seasoning Guide?** Alice Chen (commit 5 — \`git blame cooking-tips.md\`)

**Solution**:
\`\`\`bash
# Question 1: Who added chocolate cake?
git log --oneline -- recipes/chocolate-cake.txt
# or
git log --all --oneline | head -14

# Question 2: What changed in the temperature fix?
git show $COMMIT_9_SHA
# or
git diff $COMMIT_3_SHA $COMMIT_9_SHA -- recipes/chocolate-cake.txt

# Question 3: Who wrote the Seasoning Guide?
git blame cooking-tips.md

# Create and commit answers
echo "1. Bob Martinez added the chocolate cake recipe
2. The baking temperature was changed from 175°C to 180°C
3. Alice Chen wrote the Seasoning Guide section" > answers.txt

git add answers.txt
git commit -m "docs: add history exploration answers"
\`\`\`

**What students learn**: Reading commit history, comparing changes, tracking line authorship.

**Common mistakes**:
- Confusing \`git log\` output order (newest first by default)
- Not knowing how to exit the pager (press \`q\`)
- Forgetting to commit answers.txt

---

## Level 3: Branching Basics (20 points)

**Task**: Create a branch, add a commit, return to main.

**Solution**:
\`\`\`bash
# Create and switch to new branch
git checkout -b feature/my-recipe
# or: git switch -c feature/my-recipe

# Add something and commit
echo "My Special Recipe" > recipes/special.txt
git add recipes/special.txt
git commit -m "feat: add special recipe"

# Switch back to main
git checkout main
# or: git switch main
\`\`\`

**What students learn**: Branch creation, switching, and that branches are independent.

**Common mistakes**:
- Creating the branch but not switching to it (\`git branch\` vs \`git checkout -b\`)
- Forgetting to switch back to main
- Making the commit on main instead of the branch

---

## Level 4: Going Back in Time (25 points)

**Task**: Restore pasta-carbonara.txt to its original version (before commit 14 broke it).

**The problem**: Commit $MISTAKE_COMMIT by Dave replaced the authentic carbonara recipe with a store-bought alfredo version.

**Solution** (multiple approaches):
\`\`\`bash
# Option A: Restore from the original commit
git checkout $PASTA_ORIGINAL_COMMIT -- recipes/pasta-carbonara.txt
git commit -m "fix: restore authentic pasta carbonara recipe"

# Option B: Using git restore (Git 2.23+)
git restore --source=$PASTA_ORIGINAL_COMMIT -- recipes/pasta-carbonara.txt
git add recipes/pasta-carbonara.txt
git commit -m "fix: restore authentic pasta carbonara recipe"

# Option C: Revert the mistake commit
git revert $MISTAKE_COMMIT
# (this works but also shows them revert)
\`\`\`

**What students learn**: Restoring files from previous commits, understanding that Git keeps all history.

**Common mistakes**:
- Not knowing which commit had the correct version (use \`git log -- recipes/pasta-carbonara.txt\`)
- Using \`git revert\` without understanding what it does
- Forgetting to commit after restoring

---

## Level 5: FF vs Non-FF Merge (30 points)

**Task**: Merge both feature branches into main.

**Solution** (merge breakfast first for FF, then dessert for non-FF):
\`\`\`bash
# Make sure you are on main
git checkout main

# Merge breakfast-menu (fast-forward)
git merge feature/breakfast-menu
# Output: "Fast-forward" — no merge commit created

# Merge dessert-updates (non-fast-forward)
git merge feature/dessert-updates
# Output: Creates a merge commit — you may need to save the merge message
\`\`\`

**Why the difference?**
- \`feature/breakfast-menu\` was created from commit 14 (main's latest) — main can simply "fast-forward" to include those commits
- \`feature/dessert-updates\` was created from commit 10 — main has moved ahead (commits 11-14), so Git must create a merge commit to combine the histories

**What students learn**: The difference between fast-forward and non-fast-forward merges.

**Common mistakes**:
- Not being on main when merging
- Merging dessert first (both become non-FF, which still passes but misses the learning)
- Panicking at the merge commit message editor (just save and exit)

---

## Level 6: Merge Conflict — BONUS (40 points)

**Task**: Merge feature/improved-tips and resolve the conflict in cooking-tips.md.

**Solution**:
\`\`\`bash
# Start the merge
git merge feature/improved-tips
# Git will report a CONFLICT in cooking-tips.md

# Open cooking-tips.md and find the conflict markers:
# <<<<<<< HEAD
# (main's version — has Measurement Conversions)
# =======
# (branch's version — has Food Safety + extra seasoning tip)
# >>>>>>> feature/improved-tips

# Edit the file to keep BOTH sections:
# - Keep the extra seasoning tip from the branch
# - Keep the Measurement Conversions from main
# - Add the Food Safety section from the branch

# Stage and commit
git add cooking-tips.md
git commit -m "merge: resolve conflict in cooking tips"
\`\`\`

**The conflict happens because**: Both main (commit 10) and the branch modified the end of cooking-tips.md after commit 8. Main added "Measurement Conversions", while the branch added "Food Safety" and an extra seasoning tip.

**What students learn**: How to read conflict markers, that conflicts mean Git needs human help, keeping content from both sides.

**Common mistakes**:
- Deleting one side entirely instead of keeping both
- Leaving conflict markers (\`<<<<<<<\`, \`=======\`, \`>>>>>>>\`) in the file
- Not committing after resolving
- Using \`git merge --abort\` to give up

SOLUTIONS_EOF

echo ""
echo "================================================"
echo "  Beginner Git Workshop repo created!"
echo "  Students start on the main branch."
echo "  Good luck!"
echo "================================================"
echo ""
echo "Generated files:"
echo "  - git-recipe-book/    (the workshop repo)"
echo "  - SOLUTIONS-BEGINNER.md  (instructor guide)"
