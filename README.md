# _site

In this orphan branch I save the result from the `jekyll build` command, which is my full generated website.

The idea here is always having a copy from the most recent working version of the generated site, so I can compare when trying to update the tools (Markdown generator, Jekyll version, ruby version).

Sometimes there are (breaking) changes to the HTML code. Read [8cb5d7b](https://github.com/aureliojargas/aurelio.net/commit/8cb5d7b) and https://github.com/aureliojargas/aurelio.net/issues/71.

## The procedure

```bash
git checkout main
jekyll build
mv _site ..
git checkout _site
rm -rf _site
mv ../site .
git diff
```

There shouldn't be any differences in the last command, regarding the HTML format and attributes.
