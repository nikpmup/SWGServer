# Overview
Set of docker images and utilities to launch and run an SWG Emu server.

# Guide
## Source Code
User is responsible for copying a git repository of swgemu to this directory as
core3.

IE:
```
repository-root
  REAMDE.md
  Dockerfile.core3
  Dockerfile.database
  README.md
  conf
  core3 # This should be copied swgemu repository
  docker-compose.yml
  run.sh
  tre
```
## Tre
Insert your tre files into the tre folder.

## Passwords
Please update mysql passwords in docker-compose.yml. You will need to update
conf/config.lua to match the swgemu mysql password.

## Server Config
To ensure we keep a separation of the code repository and server information,
we mount the conf folder separately. Update the files in conf to apply
any server side config changes.

## Galaxy IP
Update sql/02-galaxy.sql with the proper IP address if you want to the server
exposed to LAN or the public.

## Launching
There is a utility script for managing and launching various functions. Run
the command to find what options exist
```
./run.sh help
```

# Credit
This setup was inspired by and using parts of the following:

thmhoag
https://github.com/thmhoag/swgemu-docker
