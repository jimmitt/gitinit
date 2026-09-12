# Faithful Git adaptation — verification record

Objective: retain Hg Init's six chapters, stories, examples, instructional
sequence and visual structure, changing commands and explanations for Git.

## Source fidelity

Compared with original tutorial at commit `0b30472`, not the abbreviated rewrite
at `d036a01`. Reviewed chapter 00's full diff and chapters 01–05's prose diffs
with command/file blocks separated for the runtime and transcript reviews.

- 00: re-education quiz, Jacob, Subversion stories, Tokyo analogy, branching,
  commit scope and conclusion retained. Corrected snapshot/ancestry claims,
  modern Subversion comparisons, staging, fetch and backup caveats. Removed
  duplicated source ending.
- 01: full CountDown example, Scott Adams edits, Taco story, deletion/restoration,
  status/diff, history and time-travel exercise retained.
- 02: full Joel/Rose team recipe, independent edits, push rejection, merge,
  delayed working-file update and workflow recap retained. Bare local repository
  replaces hg serve; Git inspection screenshots replace hgweb. No anonymous
  write-access configuration is carried over.
- 03: Pig Latin, unpublished undo, Jim, experimental clone, Queso, indirect
  sharing and old potato-chip undo retained. Git restore has no automatic backup;
  mixed reset replaces rollback; pushing to queso avoids the checked-out-branch
  restriction. Real old-revert conflict is shown and resolved while keeping Queso.
- 04: Hass/jalapeno clean merge, banana/mango conflict, KDiff3 and Rose's story
  retained. Explicit tool launch, staging, abort and merge commit behavior added.
- 05: commit identity, release tags, ship party, 200 avocados, salt hotfix,
  release integration, stable/dev replay and QA/team network retained.
  Git tags are separate objects, not .hgtags commits. Fresh replay clones preserve
  the first exercise and fetch only the starting release tag.
- James's original README introduction and changelog restored, with spelling and
  capitalization fixes. Homepage and original-style layout, tip cards, command
  panels and navigation restored with responsive adjustments and attribution.

## Illustration coverage

Every original chapter illustration slot remains represented:
00: 3 (including the HTML Tokyo map); 01: 4; 02: 10; 03: 2; 04: 3; 05: 6.
The 25 Git-specific chapter images were recreated with built-in image_gen using
their corresponding originals as references/edit targets, saved under i/ and
visually inspected. Git logo and Ground Up navigation tile also recreated.
Unchanged contextual art (Subversion diagram, Tokyo map, folder copies, neutral
navigation/decorative backgrounds) is retained. IMAGE-PROMPTS.md records the
later exact prompt set; earlier generation specifications are summarized below.

Earlier prompts preserved original sketch/card/folder/silhouette composition,
white background, hash identities and branch positions; removed Mercurial-only
revision numbers and tag/backout commits. Editor prompts preserved Notepad2
chrome with COMMIT_EDITMSG, staged-file summaries and Git # comments. KDiff3
prompts preserved four-pane Windows layout, BASE/LOCAL/REMOTE, mango/banana
sides and the combined result. No generated asset is referenced outside the repo.

## Verification

- `ruby tests/countdown_workflow.rb`: real Git checks for chapter 01 staging,
  status columns/order, removal, restore, historical show/diff and detached switch.
- `ruby tests/recipe_workflow.rb`: real Git sequence for chapters 02–05, including
  clean/conflicted merges, rejected push, fetch isolation, undo, experimental push,
  indirect sharing, old revert, fixed tags and stable/dev replay.
- Transcript review corrected old-first log order and the top-three example;
  retained illustrative hashes and explicitly abbreviated output.
- Jekyll 3.10 build passes with kramdown-parser-gfm. Temporary build environment
  /tmp/gitinit-jekyll-gems; no system Ruby packages were installed.
- Browser audit /tmp/gitinit-browser-audit.cjs uses isolated Chrome/puppeteer:
  index and all chapters at 1280px and 390px; no missing images or page overflow.
  Screenshots reviewed for homepage, chapter starts, command panels and footer.
  Corrected nav wrapping, clipped logo, invalid tip markup, tip padding and
  command-panel backgrounds.
- Rendered HTML check: 89 local href/src targets resolve; no duplicate IDs.
- CSS asset paths resolve; YAML/HTML block balance and git diff --check pass.

Tests check the underlying Git behavior, not an actual Windows Notepad2/KDiff3
installation. Screenshots are explicitly illustrative recreations, not captures
of a live historical environment. Original external resources are credited.

## Publication

Final local rerun passed both workflow suites, Jekyll build and all 14 browser
page/viewport checks. Publication target is master at
https://jimmitt.github.io/gitinit/; GitHub Pages builds from the repository root.
The associated commit and Pages build provide the publication record.
