# Sources for Aurelio.net website

The full sources for my personal website http://aurelio.net, online since 1999, now with 4500+ files.

At the beginning it was only HTML files, then I started to use my own software [txt2tags](http://txt2tags.org) to generate the pages, then I moved the blog part to WordPress and now it is back as a static site, powered by [Jekyll](http://jekyllrb.com/).

All these changes were slow and partial, I never moved the full site to the new tool. So now the tree is a complete mess with Markdown, HTML and txt2tags files living together. My goal ([issue #1](https://github.com/aureliojargas/aurelio.net/issues/1)) is to make it simpler.

## Local build

```bash
# Initial setup
gem install bundler
bundle install

# Building the site
bundle exec jekyll build

# Viewing
bundle exec jekyll serve --watch --limit_posts 10

# Viewing at Cloud9
bundle exec jekyll serve --watch --limit_posts 10 --port 8080 --host 0.0.0.0
```

## Building txt2tags files

Now there are two kinds of txt2tags files in my site:

- Old legacy `.t2t` files that were added together with their relative `.html` file, with no front matter. They are not processed by Jekyll and **must be converted "by hand"** using txt2tags itself.

- Pages that I have added to Jekyll as `.t2t` files and **are converted automatically** by the [txt2tags_converter.rb plugin](https://github.com/aureliojargas/aurelio.net/blob/master/_plugins/txt2tags_converter.rb) when doing `jekyll build`.

My long term goal is to convert both to Markdown or HTML and remove the txt2tags dependency. See [issue #5](https://github.com/aureliojargas/aurelio.net/issues/5). 

## Images with captions

The only special markup I use in my articles is the centered image with caption at bottom.

In txt2tags files, use borderless centered tables:

```
  | [image.jpg]
  | Image caption
```  

In Markdown files, use the image tag solo in a paragraph of its own, and provide the caption. My [custom imgcaption.rb plugin](https://github.com/aureliojargas/aurelio.net/blob/master/_plugins/imgcaption.rb) will generate the HTML markup at build:

```md
![Image caption](image.jpg)
```

In HTML files, use the following structure:

```html
<p class="figure">
  <img src="image.jpg">
  <span>Image caption</span>
</p>
```

## Hide optional page elements

You can hide page elements, such as the ads or the comments section, using special flags in front matter:

- `hide_title_suffix: true`
- `hide_heading: true`
- `hide_prev_next: true`
- `hide_byline: true`
- `hide_author: true`
- `hide_date: true`
- `hide_ads: true`
- `hide_ad_top: true`
- `hide_tags: true`
- `hide_read_more: true`
- `hide_share: true`
- `hide_comments: true`

## License

Jekyll-related and Liquid codes are Public Domain.

Site contents (my texts, images and videos) are [CC BY-NC 3.0](http://creativecommons.org/licenses/by-nc/3.0/).
