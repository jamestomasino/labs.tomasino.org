INDEX_FILES != find public/ -name 'index.html'
SIG_FILES := $(INDEX_FILES:%.html=%.html.asc)
GPG_FINGERPRINT="4E0FEB0E09DDD7DF"

help:
	@echo "targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/  \1|\3/p' \
	| column -t  -s '|'

new: ## create new post
	@test -n "$(title)" || read -p "Enter a title for your post: " title; \
	export title_slug=`echo $${title:-Untitled} | sed -E -e 's/[^[:alnum:]]/-/g' -e 's/^-+|-+$$//g' | tr -s '-' | tr A-Z a-z`; \
	export post_path=content/post/$$title_slug.md; \
	echo "Creating $$post_path"; \
	echo "---"                                                  >  $$post_path; \
	echo "date: `date +"%Y-%m-%d %H:%M:%S %z"`"                 >> $$post_path; \
	echo "title: \"$$title\""                                   >> $$post_path; \
	echo "url: \"/$$title_slug\""                               >> $$post_path; \
	echo "tags: "                                               >> $$post_path; \
	echo "  - meta "                                            >> $$post_path; \
	echo "---"                                                  >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo "<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->" >> $$post_path; \
	vim $$post_path

serve: ## start hugo watcher and webserver
	hugo server -D

build: ## build hugo source
	hugo --gc --minify

sign: $(SIG_FILES) ## gpg sign blog content

public/%.html.asc: public/%.html
	gpg --batch --yes --local-user $(GPG_FINGERPRINT) --armor --detach-sign $<

deploy: $(SIG_FILES) ## send built files to webserver
	rsync -rvhe ssh --progress --delete ./public/ labs.tomasino.org:/var/www/labs.tomasino.org/

.PHONY: new serve build deploy help sign
