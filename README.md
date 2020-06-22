# Docker image for Drone to publish NPM dependency updates to Git

Installs dependency updates to package-lock.json. If the dependencies have changed commits changes and makes a patch level change to version number. Pushes commits to the same branch that triggered the change.

## Usage
```yml
  - name: publish
    image: quay.io/natlibfi/drone-npm-git-publish
    settings:
      git_user_name: foobar
      git_user_email: foo@foo.bar
      git_ssh_key:
        from_secret: ssh_key
```        

## Settings
- **git_user_name**: Git user name
- **git_user_email**: Git user email
- **git_ssh_key**: Git SSH key used to authenticate & authorized with. Must be Base64 encoded.
- **git_gpg_key**: Optional GPG key. Signs the commits with the key. Must be Base64 encoded.

## License and copyright

Copyright (c) 2020 **University Of Helsinki (The National Library Of Finland)**

This project's source code is licensed under the terms of **GNU Affero General Public License Version 3** or any later version.