help:
	@echo "Make targets:"
	@echo "\tnew    - create a new post"
	@echo "\tserve  - start hugo watcher and webserver"
	@echo "\tbuild  - build hugo source"
	@echo "\tdeploy - send built files to webserver"

new:
	@test -n "$(title)" || read -p "Enter a title for your post: " title; \
	export title_slug=`echo $${title:-Untitled} | sed -E -e 's/[^[:alnum:]]/-/g' -e 's/^-+|-+$$//g' | tr -s '-' | tr A-Z a-z`; \
	export post_path=content/post/$$title_slug.md; \
	echo "Creating $$post_path"; \
	echo "---"                                                  >  $$post_path; \
	echo "date: `date +"%Y-%m-%d %H:%M:%S %z"`"                 >> $$post_path; \
	echo "title: \"$$title\""                                   >> $$post_path; \
	echo "url: \"/$$title_slug\""                               >> $$post_path; \
	echo "tags: "                                               >> $$post_path; \
	echo "---"                                                  >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo " "                                                    >> $$post_path; \
	echo "<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->" >> $$post_path; \
	vim $$post_path

serve:
	hugo server

build:
	hugo --gc --minify

deploy: build
	rsync -rvhe ssh --progress --delete ./public/ labs.tomasino.org:/var/www/labs.tomasino.org/

.PHONY: new serve build deploy help
