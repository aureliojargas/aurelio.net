# Sources for Aurelio.net website

The full sources for my personal website https://aurelio.net, online since 1999, now with 4500+ files.

At the beginning it was only HTML files, then I started to use my own software [txt2tags](http://txt2tags.org) to generate the pages, then I moved the blog part to WordPress and now it is back as a static site, powered by [Jekyll](http://jekyllrb.com/) and Markdown.

All these changes were slow and partial, I never moved the full site to the new tool. So at the end the tree became a complete mess with Markdown, HTML and txt2tags files living together. My goal ([issue #1](https://github.com/aureliojargas/aurelio.net/issues/1)) is to make it simpler.

It took me more than a decade to finally put my local `/a/www` folder into version control. This repo initial commit is aa6ea5939daac0c46b90986314e5278388e0c778 from Nov 2013.

## Build & Deploy

Every commit to the `master` branch triggers a complete site build and deploy in Netlify.

The deploy logs are in https://app.netlify.com/sites/aurelio/deploys.

If you want to test locally the Netlify build, use their [Docker image](https://github.com/netlify/build-image).

## Cloud development

GitHub Codespaces is fully configured for this project.

The Docker container contains everything needed to build the site.

See [.devcontainer/](.devcontainer/).

## Setup local development

Those are the initial steps for all the platforms:

```bash
# First enter this repo directory
cd aurelio.net

# Install Ruby and gem (use the following OR rbenv)
sudo apt install ruby ruby-dev

# Install bundler
gem install bundler

# Set up bundler (check the exact path for **/bin under .gem)
echo 'export BUNDLE_PATH="$HOME/.gem"' >> ~/.bashrc
echo 'export PATH="$BUNDLE_PATH/ruby/2.5.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install the Jekyll required gems
bundle install

# Install http://www.html-tidy.org

# Setup easier access to the repo scripts
export PATH="$PWD/_scripts:$PATH"
```

Extra setup for **Codeanywhere**:

```bash
# Fix locale
export LANG="C.UTF-8"

# Install rbenv and a recent ruby 2.x
# https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-debian-8
```

Extra setup for **Android Termux**:

```bash
# Install the required packages
pkg install ruby ruby-dev clang make libffi-dev file

# Fix scripts' shebang
termux-fix-shebang _scripts/*

# Fix for Jekyll 3.8.5
# https://github.com/jekyll/jekyll/pull/7267

# html-tidy
git clone https://github.com/htacg/tidy-html5.git
cd tidy-html5
git checkout master
cd build/cmake
pkg install cmake
cmake ../.. -DCMAKE_BUILD_TYPE=Release
make
# error: unknown type name 'ulong'
# see https://github.com/htacg/tidy-html5/issues/773
vi src/config.h include/tidy.h
make
cp tidy ~/bin
```

Extra setup for **Chrome OS Linux**:

```bash
# Install the required packages
sudo apt install ruby ruby-dev python tidy file
```

## Local Jekyll build

```bash
# Building the site
bundle exec jekyll build

# Viewing at local Linux or macOS
bundle exec jekyll serve --watch --limit_posts 10 --incremental

# Viewing at Chrome OS Linux or Android Termux
# To get the instance IP address:
#   - Chrome OS: hostname -I
#   - Android: ifconfig | grep inet
bundle exec jekyll serve --watch --limit_posts 10 --incremental --host 0.0.0.0

# Viewing at Cloud9 or Codeanywhere, port must be 8080
bundle exec jekyll serve --watch --limit_posts 10 --incremental --host 0.0.0.0 --port 8080
```

## Images with captions

The only special markup I use in my articles is the centered image with caption at bottom.

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

<!-- Linked image: -->

<p class="figure">
  <a href="foo.html">
    <img src="image.jpg">
  </a>
  <span>Image caption</span>
</p>

<!-- No caption: -->

<p class="figure">
  <img src="image.jpg">
</p>
```

## Hide optional page elements

You can hide page elements, such as the ads or the comments section, using special flags in front matter:

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

## Custom page configuration

The site template ([\_layouts/2014.html](https://github.com/aureliojargas/aurelio.net/blob/master/_layouts/2014.html)) supports some special configuration, to the used in page front matter:

- `article_footer_after: include-file.html` — To insert a special footer at the end of the article.

- `css_extra: foo.css` — To load an extra CSS file for this page.

- `title_prefix: "Foo: "` — To add a prefix to the page `<title>` tag. (See [\_includes/head-base.html](https://github.com/aureliojargas/aurelio.net/blob/master/_includes/head-base.html))

- `title_suffix: " | Foo"` — To add a suffix to the page `<title>` tag. (See [\_includes/head-base.html](https://github.com/aureliojargas/aurelio.net/blob/master/_includes/head-base.html))

## The minimal theme

If the main theme is not suitable, there's the minimal theme. No layout, no CSS. Only the bare minimal skeleton with mobile support (sets `viewport`) and some Jekyll include magic:

- `page.after_content` - Include file to insert before the page contents.
- `page.before_content` - Include file to insert after the page contents.
- `page.css` - CSS file to use (use root-relative path).
- `page.title_as_h1` - Insert an H1 tag at the top of the page, showing `page.title`.

Since this theme uses [\_includes/head-base.html](https://github.com/aureliojargas/aurelio.net/blob/master/_includes/head-base.html), you can also use `page.title_prefix` and `page.title_suffix`.

## Pagination

Avoid using paginated content. That sucks.

But when needed, set `page.prev` and `page.next` with the desired URLs and use the `*-prev-next.html` includes.

For now those are the only paginated areas on the site:

- /regex/guia
- /rac/info/tutorial/

## How to make batch changes

Since most of the site is made of plain HTML files, it's common to have to apply the same edits in multiple files.

Fear not, use the [replace script](https://github.com/aureliojargas/replace) and be happy. Better yet, also use the [git\_replace function](https://github.com/aureliojargas/dotfiles/blob/master/.gitbash).

## License

Jekyll-related and Liquid codes are Public Domain.

Site contents (my texts, images and videos) are [CC BY-NC 3.0](http://creativecommons.org/licenses/by-nc/3.0/).
