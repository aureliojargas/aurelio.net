# Sources for Aurelio.net website

> This is a work in progress.

I've converted the WordPress part of my site to [Jekyll](http://jekyllrb.com/):

- [The blog](http://aurelio.net/blog/)
- The RSS feed
- The pages groups
  - [/artigos](http://aurelio.net/artigos/)
  - [/viagem](http://aurelio.net/viagem/)
  - [/wordpress](http://aurelio.net/wordpress/)
- Some other small pages

This git repository holds these contents.

But the majority of the site (1000+ files) still remains as [txt2tags](http://txt2tags.org) text files. I'll try to integrate Jekyll with txt2tags, and them I'll add those files here.


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

## License

Jekyll-related and Liquid codes are Public Domain.

Site contents (my texts, images and videos) are [CC BY-NC 3.0](http://creativecommons.org/licenses/by-nc/3.0/).
