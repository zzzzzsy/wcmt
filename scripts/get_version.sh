#!/bin/sh
# get version value from VERSION file as the image tag
# if VERSION file not exists or the version value is empty
# return truncated git number

FILE=VERSION
git_version=$(git rev-parse --short HEAD)

if [[ -f "$FILE" ]]; then
    version=$(cat "$FILE" | xargs)
    if [[ -n $version ]]; then
        echo $version
        exit 0
    fi
fi

echo $git_version