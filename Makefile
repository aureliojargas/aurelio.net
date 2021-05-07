default:
	@echo 'There is no default make target. Please inform one.'

check:
	_scripts/list-non-utf8-files
	_scripts/check-site
