#=================================================================================
# Authoring
#=================================================================================

new_post:
	@test -n "$(title)" || read -p "Enter a title for your post: " title; \
		export title_slug=`echo $${title:-Untitled} | sed -E -e 's/[^[:alnum:]]/-/g' -e 's/^-+|-+$$//g' | tr -s '-' | tr A-Z a-z`; \
		export post_path=_posts/`date +%Y-%m-%d`-$$title_slug.md; \
		test -f $$post_path && { echo "Error: $$post_path already exists" ; exit 1; }; \
		echo "Creating $$post_path"; \
		echo "---"                                                  >> $$post_path; \
		echo "layout: post"                                         >> $$post_path; \
		echo "title: \"$$title\""                                   >> $$post_path; \
		echo "date: `date +"%Y-%m-%d %H:%M:%S %z"`"                 >> $$post_path; \
		echo "comments: true"                                       >> $$post_path; \
		echo "tags: "                                               >> $$post_path; \
		echo "excerpt: "                                            >> $$post_path; \
		echo "---"                                                  >> $$post_path; \
		echo " "                                                    >> $$post_path; \
		echo " "                                                    >> $$post_path; \
		echo " "                                                    >> $$post_path; \
		echo " "                                                    >> $$post_path; \
        echo "<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->" >> $$post_path; \
		vim $$post_path

#=================================================================================
# Staging
#=================================================================================

serve:
	bundle exec jekyll serve --watch --drafts --trace

build:
	bundle exec jekyll build

#=================================================================================
# Setup
#=================================================================================

install:
	bundle install

update:
	bundle update

clean:
	rm -rf _site
	rm -rf .sass-cache

#=================================================================================
# Deployment
#=================================================================================

deploy:
	$(MAKE) build
	rsync -rvhe ssh --progress --delete ./ labs.tomasino.org:/var/www/labs.tomasino.org/

#  vim: set shiftwidth=4 tabstop=4 noexpandtab:
