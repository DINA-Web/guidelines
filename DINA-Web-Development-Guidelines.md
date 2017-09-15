This is RECOMMENDATION for common development practices in the DINA project. It can be deviated for justifiable reasons. Comment and/or document any deviations clearly.

## What to include in these guidelines?

If there are many common ways to do something, but only one of those is preferred on DINA, include that in these guidelines. 

No need to describe everything here in detail, instead link to public manuals elsewhere. (And possibly add a backup copy of them in this repository, if they are important and their license allows it.)

# Summary checklist

- Add a readme file
- Create secrets automatically to dotfiles whenever possible.
- Put secrets into environment variables with docker-compose.yml.
- Use Makefile with standard target names.


# Readme

Every module and submodule/service must have a readme.md file, which describes briefly

- What the module is about
- What is the state of the module (active development or not, abandoned...)
- What are the different branches for
- Important releases/tags, if there are such
- Deviations from DINA guidelines

# Using Docker

Docker practices are desribed in more detail on separate Guidelines. **TODO: Link**



# Secrets

Generate secrets automatically during build process whenever possible (i.e. when services are inside a multi-container application deployed as a single entity.)

Save secrets into “dotfiles” (e.g. .env-servicename). Commit only templates of these file into Git. Read secrets from these files to containers’ environment variables when deploying with docker-compose (using settings on docker-compose.yml).

**TBD** NAMING SCHEME FOR SECRET AND ENVIRONMENT FILES?
include in every .gitignore e.g. `.secret*`



# Makefiles

Use Makefiles to store and run complex commands and steps.

Comment each step in the Makefile at least in the reference implementation (user management module), and if something deviates from common practice. 

Prefer descriptive commands over short and abstract ones.

Prefer these standard targets in the Makefiles:

## Must-have targets for building and running

| Target | Purpose |
--- | --- | ---
secrets | create secrets
dotfiles | generates environment variable files
build-images | build docker images from source code
compose-up | starts the system locally using docker-compose
compose-down | stops and removes containers
clean | removes binary build artifacts, so that fresh build can be made

## Could-have targets

| Target | Purpose |
--- | --- | ---
init | set environment variables, if not done with docker-compose
release | push Docker images to Docker Hub
backup | backups system state into preferably non-proprietary formats
restore | restores from any timestamped backup
dox | if an API component, generates the HTML reference documentation
test | launches tests	

Module documentation should refer to separate commands for at least secrets, build-images, init, up-compose. The Makefile can also include make [all], which abstracts all automatic processes under single command (for expert users).
