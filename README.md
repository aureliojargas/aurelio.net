# Sources for Aurelio.net website

The full sources for my personal website https://aurelio.net, online since 1999, now with 4500+ files.

At the beginning it was only HTML files, then I started to use my own software [txt2tags](http://txt2tags.org) to generate the pages, then I moved the blog part to WordPress and now it is back as a static site, powered by [Jekyll](http://jekyllrb.com/).

All these changes were slow and partial, I never moved the full site to the new tool. So now the tree is a complete mess with Markdown, HTML and txt2tags files living together. My goal ([issue #1](https://github.com/aureliojargas/aurelio.net/issues/1)) is to make it simpler.

It took me more than a decade to finally put my local `/a/www` folder into version control. This repo initial commit is aa6ea5939daac0c46b90986314e5278388e0c778 from Nov 2013.

## Build & Deploy

Every commit to the `master` branch triggers a complete site build and deploy in Netlify.

The deploy logs are in https://app.netlify.com/sites/aurelio/deploys.

If you want to test locally the Netlify build, use their [Docker image](https://github.com/netlify/build-image).

## Setup local development

Those are the initial steps for all the platforms:

```bash
# First enter this repo directory
cd aurelio.net

# Install Ruby and gem (use the following OR rbenv)
sudo apt install ruby ruby-dev
echo 'export GEM_HOME="$HOME/.gem/ruby/2.3.0"' >> ~/.bashrc  # check your ruby version
echo 'export BUNDLE_PATH="$GEM_HOME"' >> ~/.bashrc
echo 'export PATH="$GEM_HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install bundler and Jekyll required gems
gem install bundler
bundle install

# Make sure you have Python 2 (for txt2tags)

# Install http://www.html-tidy.org

# Setup easier access to the repo scripts
export PATH="$PWD/_scripts:$PATH"
```

Extra setup for **Codeanywhere**:

```bash
# Fix locale
export LANG="C.UTF-8"

# Python2 for txt2tags
sudo apt-get install python

# Install rbenv and a recent ruby 2.x
# https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-debian-8
```

Extra setup for **Android Termux**:

```bash
# Install the required packages
pkg install ruby ruby-dev clang make libffi-dev file

# Python2 for txt2tags
pkg install python2
sed '1 s/python/python2/' -i _scripts/txt2tags-2.6.1102

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

## Building txt2tags files

All the `.t2t` files on this repository are not processed by Jekyll. They have no front matter and must be converted by hand using the txt2tags script (Python 2) stored in the `_scripts` folder. The resultant HTML files must also be added to the repository.

My long term goal is to convert all those files to Markdown or HTML and remove the txt2tags dependency. See [issue #11]( https://github.com/aureliojargas/aurelio.net/issues/11).

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

The site template ([_layouts/2014.html](https://github.com/aureliojargas/aurelio.net/blob/master/_layouts/2014.html)) supports some special configuration, to the used in page front matter:

- `article_footer_after: include-file.html` — To insert a special footer at the end of the article.

- `css_extra: foo.css` — To load an extra CSS file for this page.

- `title_prefix: "Foo: "` — To add a prefix to the page `<title>` tag. (See [_includes/head-base.html](https://github.com/aureliojargas/aurelio.net/blob/master/_includes/head-base.html))

- `title_suffix: " | Foo"` — To add a suffix to the page `<title>` tag. (See [_includes/head-base.html](https://github.com/aureliojargas/aurelio.net/blob/master/_includes/head-base.html))

## License

Jekyll-related and Liquid codes are Public Domain.

Site contents (my texts, images and videos) are [CC BY-NC 3.0](http://creativecommons.org/licenses/by-nc/3.0/).
