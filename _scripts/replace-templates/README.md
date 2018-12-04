# Replace templates

These files are meant to the used as arguments to the options `--from-file` and `--to-file` of the [replace script](https://github.com/aureliojargas/replace).

All of them require regular expression matching, so also use the `--regex` option.

Example:

```bash
replace.py -i --regex \
    --from-file toc-short-from.html \
    --to-file   toc-short-to.html \
    my-file.html
```
