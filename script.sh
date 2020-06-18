#!/bin/sh
set -e

echo 'Updating dependencies...'

npm install --package-lock-only

PACKAGE_LOCK_CHANGED=`git diff --name-only HEAD | grep package-lock.json`

if test -n "$PACKAGE_LOCK_CHANGED";then
  echo "Package lock has changed. Saving changes"

  echo "$GIT_SSH_KEY" > ssh_key
  chmod 0600 ssh_key
  du -b ssh_key

  #git remote add origin $DRONE_GIT_SSH_URL

  git config core.sshCommand 'ssh -i ssh_key -o StrictHostKeyChecking=no'
  echo 'set ssh command'
  git config user.name $GIT_USER_NAME
  echo 'set user name'
  git config user.email $GIT_USER_EMAIL
  echo 'set user email'

  git commit -a -m 'Update dependencies'

  npm version patch

  git push --follow-tags origin $DRONE_COMMIT_BRANCH
else
  echo "No changes"
fi