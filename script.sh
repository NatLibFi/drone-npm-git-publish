#!/bin/sh
set -e

echo 'Updating dependencies...'

npm install --package-lock-only

PACKAGE_LOCK_CHANGED=`git diff --name-only HEAD | grep package-lock.json`

if test -n "$PACKAGE_LOCK_CHANGED";then
  echo "Package lock has changed. Saving changes"

  echo $PLUGIN_GIT_SSH_KEY > ssh_key
  chmod 0600 ssh_key

  echo $DRONE_GIT_SSH_URL > foo
  cat foo

  git remote add remote $DRONE_GIT_SSH_URL

  git config core.sshCommand 'ssh -i ssh_key -o StrictHostKeyChecking=no'
  git config user.name $PLUGIN_GIT_USER_NAME
  git config user.email $PLUGIN_GIT_USER_EMAIL

  git commit -a -m 'Update dependencies'

  npm version patch

  git push -v --follow-tags remote $DRONE_COMMIT_BRANCH
else
  echo "No changes"
fi