This is RECOMMENDATION for common development practices in the DINA project. It can be deviated for justifiable reasons. Comment and/or document any deviations clearly.

**This needs thorough review from developers!!**

## What to include in these guidelines?

If there are many common ways to do something, but only one of those is preferred on DINA, include that in these guidelines. 

No need to describe everything here in detail, instead link to public manuals elsewhere. (And possibly add a backup copy of them in this repository, if they are important and their license allows it.)

## Terms

* Module = Siungle DINA module, in one or several repositories
* Service = Subpart of a module, e.g. frontend UI, backend API or database

# Summary checklist

- Document deviations clearly
- Use common tools
- Add a readme.md file
- Add other relevant files
- Use semantic versioning
- Build & run with Docker
   - User Docker best practices
   - Use Makefile with standard target names.
   - Create secrets automatically to dotfiles whenever possible.
   - Put secrets into environment variables with docker-compose.yml.


# Tools

## Redmine for development tasks

Add new feature ideas, bugs and tasks to Redmine, according to development practices (on Redmine wiki). 

The tasks can be split into smaller issues on Github, if necessary.

## Git and Github for version control

Use Git and Github for version control.

Double-check that no passwords or other **secrets** are committed into Git. See more on secrets below.

If using differenct **branches**, describe on the readme file what they are for.

# Files

Before releasing, make sure that these files are present in the repo, is applicable for the module:

| File | Purpose |
--- | --- | ---
LICENSE | Open source license
README.md | Explain usage, see below
CHANGES.md | Overview of changes (details are in commit messages)
docker-compose.yml | Settings for running the module with docker-compose 
Dockerfile | Build settings of portable images for services
Makefile | Automation of build/run processes, see below
.travis.yml | Continuous integration, providing delivery of build artifacts to GitHub Releases and Docker Hub **TODO: clarify**
apiary.apib | API specification if the code implements an API
api-documentation.html | rendered apiary blueprint as HTML documentation

# Readme file

Every module and submodule/service must have a readme.md file, which describes briefly

- What the module is about
- What is the state of the module (active development or not, abandoned...)
- What are the different branches for
- Important releases/tags, if there are such
- Deviations from DINA guidelines
- How to do a local build (for testing) - this should include all the steps needed to have the module running.
- Travis build badge
- Code coverage badge **TBD**

# License file

Include license text in the `LICENSE` file.

Appropriate license for DINA are:

* AGPL or GPLv3, MIT or Apache for code
* Creative Commons for content (Not noncommercial)

See License guidelines **TBD: Is link needed here?**

# API documentation

If the module privides an API, document it in API-Blueprint format using an .apib file.

**TODO** Badge


# Using Docker for building and running

Use Docker for building and running the module as a set of independent containers, connected by a reverse proxy service.

For an overview of how a can be set up, see the [User management module](https://github.com/DINA-Web/accounts-docker/tree/development), which acts as a reference implementation. **TBD** 

**TODO: Add details**
- How standardizzed should the build-run process be?
- How to exactly set secrets/environment variables 
- One repository per module, or one repository per service? Or both are fine?
- Using proxy-docker launched separately or include proxy in docker-compose? 
- Using letsencrypt or self-signed certs (for local builds)? 

## Makefiles

Provide `Makefile` for building code locally and launch services.

Comment each step in the Makefile at least in the reference implementation (user management module), and if something deviates from common practice. 

Prefer descriptive commands over short and abstract ones.

Prefer these standard targets in the Makefiles:

### Must-have targets for building and running

| Target | Purpose |
--- | --- | ---
secrets | generate random credentials
dotfiles | generates environment variable files from secret file (**TBD: combine with secrets to simplify?**)
build-images | build docker images from source code
compose-up | starts the system locally using docker-compose
compose-down | stops and removes containers
clean | removes binary build artifacts, so that fresh build can be made

### Could-have targets

| Target | Purpose |
--- | --- | ---
init | set environment variables, if not done with docker-compose
release | push Docker images to Docker Hub
backup | backups system state into preferably non-proprietary formats
restore | restores from any timestamped backup
dox | if an API component, generates the HTML reference documentation
test | launches tests	

Module documentation should refer to separate commands for at least secrets, build-images, init, up-compose. The Makefile can also include make [all], which abstracts all automatic processes under single command (for expert users).

## Secrets

Generate secrets automatically during build process whenever possible (i.e. when services are inside a multi-container application deployed as a single entity.)

Save secrets into “dotfiles” (e.g. .env-servicename). Commit only templates of these file into Git. Read secrets from these files to containers’ environment variables when deploying with docker-compose (using settings on docker-compose.yml).

**TBD** NAMING SCHEME FOR SECRET AND ENVIRONMENT FILES?
include in every .gitignore e.g. `.secret*`

# Testing

**TODO**Code coverage

**TODO** Link to QA Guidelines

Accessibility Guidelines compliance
Security OWASP compliance

# Release

## Versioning and tagging

Use semantic versioning. See release guidlines for more about version numbers anb tagging.

Tag your releases like this:

    git tag -a v0.0.1 -m "description"
   
(You can use `git config --global push.followTags true` and your 'git push' will take the tag along, if not you have to do a separate `git push origin <tag>` before pushing.)

**TODO: link** See Release guidelines

## Travis

**TBD** Building testing and/or releasing?

For non-local build, use Travis CI and deploy released binary artifacts to GitHub Releases and/or DockerHub
