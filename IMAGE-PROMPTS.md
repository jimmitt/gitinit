# Image recreation prompts

Built-in image_gen edits; corresponding original PNGs are edit targets.

## i/05-git-repo.png

Use case: text-localization
Asset type: GitInit chapter 05 tutorial illustration.
Input image: edit target, original HgInit comparison of Rose's and Joel's repositories.
Recreate this image faithfully for Git. Preserve two outlined repository columns, handwritten typography, stacked shadowed cards, white background, green paired cards, gray older cards, and all history layers except the Mercurial-only 'Backed out changeset' card which must be removed. Expand width to fit legible hashes, no cropping.
Replace numeric revisions with the following exact hash-and-message labels in BOTH columns. Top down:
"1b03ab7: merge"
paired green cards Rose left "f923c90: mmmmango", Rose right "0bd396c: Bananas Yum"; reverse their positions in Joel's column.
"8646f8c: merge"
paired green cards Rose left "44aefde: Better Avocados", Rose right "bf5854c: Better Chile"; reverse in Joel column.
"d828920: Undo thing from the past"
"9545248: Queso = Cheese!"
"0849ca9: merge"
paired green cards Rose left "6890266: spicier kind of chile", Rose right "4ecdb24: potato chips"; reverse in Joel column.
"a52881e: Change crunch to smoosh"
"c1fb7e7: Initial version of guacamole"
Titles "Rose's Repository" and "Joel's Repository".
Constraints: same hash for same message in both copies, no numeric revision prefixes, no extra commits, no new decorative elements. Retain original composition and complete history. These are stacked history cards as in original, not a new simplified graph.

## i/05-git-repo-3.png

Use case: text-localization
Input image: edit target, original HgInit stable/dev history illustration.
Recreate faithfully for Git: preserve white background, hand-drawn black outlined tall repository boxes, handwritten labels, shadowed commit cards, tag-shaped Version-1.0 labels pointing right to release commit, gray scribble and gold "murky ancient history" at bottom.
Titles "Stable Repository" and "Dev Repository". Remove "14: added tag" cards entirely: Git tags do not create commits. Top release card in each: "1b03ab7: merge" with small label "stable (HEAD)" above it in each repository (the new dev clone still has branch stable at this point).
Below release: two cards "0bd396c: Bananas Yum" and "f923c90: mmmmango".
Below pair: "8646f8c: merge".
Below: paired "bf5854c: Better Chile" and "44aefde: Better Avocados".
Bottom scribble/capsule "murky ancient history".
Both Version-1.0 tag pointers aim at 1b03ab7 merge cards, not the branch labels. Preserve all these layers and side by side arrangement; expand enough for readable hashes, no crops. Small bottom caption: "History reachable from stable; other refs omitted." No extra commits, no numeric revision prefixes, no invented arrows.

## i/05-git-complex.png

Use case: text-localization
Input image: edit target original HgInit repository network.
Recreate this hand-drawn diagram for Git retaining the exact node arrangement, named teams and heavy black directional arrows on white background. Each node is a hand-drawn empty repository rectangle labeled at top, as original. Add tiny "Git repository" inside each box.
Top row left to right "Stable", "Dev", "QA Team A", "Dev Team A", "Alice".
Right column under Alice "Bob", then "Charles", then "David", then "Alice, again", then "Fhjs kqzx" (use original nonsense contributor label as closely as possible).
Middle-lower row "QA Team B" then "Dev Team B" then David.
Exact arrows: Alice -> Dev Team A; Bob -> Dev Team A; Charles -> Dev Team A; Dev Team A -> QA Team A; QA Team A -> Dev. David -> Dev Team B; Alice, again -> Dev Team B; bottom contributor -> Dev Team B; Dev Team B -> QA Team B; QA Team B -> Dev; Dev -> Stable.
All arrows represent the direction selected work is integrated, not parent links or necessarily a direct push. Add small bottom legend "Arrows show the flow of accepted changes." No Git logo or other decoration, preserve original loose black sketch style and generous white spaces. Avoid crossed labels.

## i/05-git-repo-4.png

Use case: text-localization
Input image: edit target original HgInit stable/dev evolution diagram. Recreate faithfully for Git, preserving side-by-side outlined Stable Repository and Dev Repository, handwritten shadowed history cards, white background, purple-outlined tag-shaped pointers, yellow operation badge, bottom gray scribbles with gold "murky ancient history".
All local numeric revision prefixes become hashes. Remove ALL faded "added tag" cards; Git tags are not commits.
Stable top: "e05c954: less salt", with small "stable (HEAD)" label above. Tag "Version-1.1" points to that card.
Stable below: "1b03ab7: merge", tag "Version-1.0" points to it.
Dev top: "a70bf6e: merge", small "dev (HEAD)" above.
Dev second row: left "e05c954: less salt", small "origin/stable" beside it; right "7f2a640: more avocado flavor". Tag "Version-1.1" points to less-salt card.
Dev below: "1b03ab7: merge", tag "Version-1.0" points to it.
Both repos lower layers: pair "0bd396c: Bananas Yum" and "f923c90: mmmmango"; then "8646f8c: merge"; then pair "bf5854c: Better Chile" and "44aefde: Better Avocados"; then scribble/gold ancient-history capsule.
Preserve heavy curved arrow left less-salt card to right less-salt card; yellow badge says "fetch" (not pull).
Small bottom caption "Branch histories shown; other refs omitted."
Retain original complete hierarchy, no extra commits. No added-tag boxes. Expand canvas for clear legible text.

## i/05-git-tags.png

Use case: precise-object-edit
Asset type: recreated instructional Windows application screenshot for GitInit, replacing a Mercurial-only .hgtags merge screenshot.
Input image: source reference for period Windows chrome, framing and instructional screenshot role. Change application to a Windows Command Prompt because Git has no tracked tag file or tag conflict here; do not fake a KDiff3 tag merge.
Keep compact landscape window, blue Windows title bar, conventional minimize/maximize/close controls, thin border. Title "Command Prompt - Git tag and merge check". Black console, readable white monospace text, no desktop outside window.
Exact console text, no additional output:
C:\Users\joel\recipes> git log -1 --oneline Version-1.0
1b03ab7 merge

C:\Users\joel\recipes> git log -1 --oneline Version-1.1
60ddc01 less salt

C:\Users\joel\recipes> git status --short
M  guac

C:\Users\joel\recipes> git diff --staged -- guac
diff --git a/guac b/guac
--- a/guac
+++ b/guac
@@ -5,7 +5,7 @@
 * 1-2 jalapeno chiles, stems and seeds removed, minced
 * 2 tablespoons cilantro leaves, finely chopped
 * 1 tablespoon of fresh lime or lemon juice
-* 1/2 teaspoon coarse salt
+* 1 grain table salt, split in half
 * A dash of freshly grated black pepper
 * 1/2 ripe tomato, seeds and pulp removed, chopped
 * 1 ripe young Mango, in season.

Constraints: faithfully legible literal commands and text, M in first column indicates staged modification, both tags unchanged, no .hgtags file and no conflict markers. This is an illustrative recreation, not a photo. Widen as needed, avoid clipping lines.

## i/02-git-web.png

Use case: precise-object-edit
Input image: original HgInit empty central repository browser screenshot, reference for blue Windows-era chrome and instructional purpose.
Recreate its Git equivalent as a compact Windows Command Prompt screenshot with blue title bar "Command Prompt - CentralRepo.git", minimize/maximize/close buttons, black console, white monospace text. Do not show browser or Mercurial logo: local Git bare repos have no built-in web UI.
Exact console:
C:\> git init --bare -b main C:/CentralRepo.git
Initialized empty Git repository in C:/CentralRepo.git/

C:\> git --git-dir=C:/CentralRepo.git show-ref

C:\>
Preserve blank space after show-ref to show no branches yet. No invented output or status messages. Readable, uncropped, landscape window.

## i/02-git-web-2.png

Use case: precise-object-edit
Input image: original HgInit populated repository browser screenshot, reference for blue Windows-era chrome and instructional purpose.
Recreate Git equivalent as Windows Command Prompt screenshot. Blue title bar "Command Prompt - CentralRepo.git", normal window buttons, black console and white monospace text. It shows same two commits as original and committed recipe, not a fake built-in Git web UI.
Exact console:
C:\> git --git-dir=C:/CentralRepo.git log --oneline main
a52881e Change crunch to smoosh
c1fb7e7 Initial version of guacamole recipe

C:\> git --git-dir=C:/CentralRepo.git show main:guac
* 2 ripe avocados
* 1/2 red onion, minced (about 1/2 cup)
* 1-2 serrano chiles, stems and seeds removed, minced
* 2 tablespoons cilantro leaves, finely chopped
* 1 tablespoon of fresh lime or lemon juice
* 1/2 teaspoon coarse salt
* A dash of freshly grated black pepper
* 1/2 ripe tomato, seeds and pulp removed, chopped

Smoosh all ingredients together.
Serve with tortilla chips.

C:\>
Readable exact text, no clipping, no invented output, no browser/Mercurial logo. Landscape screenshot with enough room for all lines.

## i/git-logo.png

Built-in image_gen, original i/logo.png edit target.

Use case: text-localization
Input image: edit target original HgInit logo.
Recreate logo for GitInit retaining simple white rectangular card, thin black outline and black offset shadow, left-aligned gold-brown bold sans-serif wordmark, same compact portrait composition. Replace large "Hg" with "Git", keep "Init" below in slightly smaller bold type. Replace top black "80" with small black "git". Replace bottom black "200.59" with small black "version control". No chemical atomic number or mass because Git isn't an element. Match original gold-brown #bd8746. Tight framing matching reference proportions, crisp typography, all text fits within card. No additional icon or decoration.

## i/git-homenav-2-1.png

Built-in image_gen, original i/homenav-2-1.png edit target.

Use case: text-localization
Input image: edit target HgInit two-state Ground up Mercurial navigation sprite.
Recreate sprite with exact original layout: narrow vertical image, two equal-height states stacked without gap, each state is rounded white rectangle occupying left 80% width and a right-pointing arrow on its right. Top state gold-brown border/title/arrow; bottom state gray border/title/arrow. Both states must match geometry exactly for CSS hover switching.
Replace title in both with "Ground Up" on first line and "Git" on second line. Replace faint periodic table artwork with a similarly faint light-gray Git commit-history network: small connected commit circles and one branching and rejoining line, low contrast behind lower portion. No Mercurial/Hg/periodic element symbols. Keep original gold-brown #b58145 and gray #888, simple typography, two states only, no shadows, no extra spacing or external framing. Aspect ratio 151:352, full frame sprite.

Follow-up edit of first result:

Edit this navigation sprite only to replace the solid BLACK outside the rounded white cards and outside the arrow silhouettes with flat pale cream #f7faec, matching the website background. Keep the white card interiors, gold/gray borders and titles, arrows, graph illustrations, two equal-height stacked states and exact full-frame composition unchanged. No black exterior remains; no extra padding.
