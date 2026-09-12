# Contributing

GitInit is a Jekyll site published with GitHub Pages.

For a small correction, use GitHub's web editor or open a focused pull request.
For local work, install Jekyll using the instructions for your operating system
at <https://jekyllrb.com/docs/installation/>. Then run:

```console
$ jekyll serve --watch --incremental
```

Open <http://localhost:4000/gitinit/>. Check that every chapter renders, code
examples remain readable at narrow widths, internal links work, and the site
contains no accidental credentials or generated files before committing.

## Workflow verification

Run `ruby tests/recipe_workflow.rb` to exercise the recipe sequence in chapters
02–05 with real Git repositories. It checks sharing, clean and conflicted merges,
restoring and unstaging edits, mixed reset, experimental branches, an old revert,
and both release workflows. The test uses local identity settings and disables
global Git configuration; it never pushes to GitHub. Temporary repositories are
left under the printed `/tmp/gitinit-recipe-*` path for inspection.

Run `ruby tests/countdown_workflow.rb` for chapter 01's staging, status, deletion,
restore, historical file inspection and detached-switch examples. This uses a
small CountDown fixture with the tutorial's changing text and icon file.

These checks do not replace a comparison with the original tutorial or visual
checks of the rendered site. Interactive editor and KDiff3 UI steps require
separate inspection; the tests exercise the underlying Git operations.
