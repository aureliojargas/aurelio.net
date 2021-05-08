default:
	@echo 'There is no default make target. Please inform one.'

check:
	_scripts/list-non-utf8-files
	_scripts/check-site

build:
	# Remove first, to avoid cache gotchas
	rm -rf _site
	bundle exec jekyll build

serve: url-chromeos
	bundle exec jekyll serve --watch --limit_posts 10 --incremental --host 0.0.0.0

url-chromeos:
	@if test "$$(uname -n)" = penguin; then echo "http://$$(hostname -I | tr -dc 0-9.):4000"; fi
