#!/bin/bash
echo "The script creates a production build of the site."

# Set the production environment switch
export JEKYLL_ENV=production
echo $JEKYLL_ENV

# Do the build
bundle exec jekyll build

# Set the development environment switch
export JEKYLL_ENV=development
echo $JEKYLL_ENV