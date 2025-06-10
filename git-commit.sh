#!/usr/bin/env bash

MESSAGE="${1:-config changes $(date)}"

git add .
git commit -m "$MESSAGE"
git push origin main
