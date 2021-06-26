#!/bin/bash

set -o errexit -o nounset

echo ::set-output name=should_release::"true"

# fetch tags
git fetch --tags

# get latest tag that looks like a semver (with or without v)
tag=$(git for-each-ref --sort=-v:refname --count=1 --format '%(refname)' refs/tags/[0-9]*.[0-9]*.[0-9]* refs/tags/v[0-9]*.[0-9]*.[0-9]* | cut -d / -f 3-)

# if there are none, start tags at 0.0.0
if [ -z "$tag" ]
then
    log=$(git log --pretty=oneline)
    tag=0.0.0
else
    log=$(git log $tag..HEAD --pretty=oneline)
    tag_commit=$(git rev-list -n 1 $tag)

    # get current commit hafor tag
    commit=$(git rev-parse HEAD)

    if [ "$tag_commit" == "$commit" ]; then
        echo "No new commits since previous tag. Skipping the tag creation..."
        echo ::set-output name=last_tag::$tag
        exit 0
    fi
fi

last_major=$(bash ./semver.sh get major $tag)              
last_minor=$(bash ./semver.sh get minor $tag)
last_patch=$(bash ./semver.sh get patch $tag)

echo ::set-output name=last_major::$last_major
echo ::set-output name=last_minor::$last_minor
echo ::set-output name=last_patch::$last_patch

# get commit logs and determine home to bump the version
# supports #major, #minor, #patch
case "$log" in
    *#major* ) 
        new=$(bash ./semver.sh bump major $tag)
        bump_ver="major"
        ;;
    *#minor* ) 
        new=$(bash ./semver.sh bump minor $tag)
        bump_ver="minor"
        ;;
    *#patch* ) 
        new=$(bash ./semver.sh bump patch $tag)
        bump_ver="patch"
        ;;
    * )
        echo "This commit message doesn't include #major, #minor or #patch. Skipping the tag creation..."
        echo ::set-output name=should_release::"false"
        exit 0
        ;;
esac

echo "new tag $new"
echo "bump_ver $bump_ver"

major=$(bash ./semver.sh get major $new)
minor=$(bash ./semver.sh get minor $new)
patch=$(bash ./semver.sh get patch $new)

# set outputs 
echo ::set-output name=new_tag::$new
echo ::set-output name=bump_ver::$bump_ver