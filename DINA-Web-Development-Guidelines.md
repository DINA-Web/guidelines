**This needs thorough review from developers!!**

# Development guidelines

This is RECOMMENDATION for day-to-day development practices used in the DINA project. It aims to  
- Set common practices so that modules would be built in fairly consistent manner
- Describe practices to avoid dependencies on any single developer's expertise
- Act as a reminder checklist for developers 

The guidelines can be deviated from for justifiable reasons. Comment and/or document any deviations clearly.

## What to include in these guidelines?

If there are many common ways to do something, but only one of those is preferred on DINA, include that in these guidelines. 

No need to describe everything here in detail, instead link to public manuals elsewhere. (And possibly add a backup copy of them in this repository, if they are important and their license allows it.)

## Terms

* Module = Siungle DINA module, in one or several repositories
* Service = Subpart of a module, e.g. frontend UI, backend API or database

# Summary checklist

- Prefer common tools and processes. Document deviations clearly.
- Add a readme.md file and keep it up-to-date
- Add other relevant files
- Document API's in Blueprint-API format
- Build & run with Docker
   - Use common Docker practices
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
| --- | --- | --- |
| LICENSE | Open source license |
| README.md | Explain usage, see below |
| CHANGES.md | Overview of changes (details are in commit messages) |
| docker-compose.yml | Settings for running the module with docker-compose |
| Dockerfile | Build settings of portable images for services |
| Makefile | Automation of build/run processes, see below |
| .travis.yml | Continuous integration, providing delivery of build artifacts to GitHub Releases and Docker Hub **TODO: clarify** |
| apiary.apib | API specification if the code implements an API |
| api-documentation.html | rendered apiary blueprint as HTML documentation |

# Readme file

Every module and submodule/service must have a readme.md file, which describes briefly

- What the module is about
- What is the state of the module (active development or not, abandoned...)
- What are the different branches for
- Important releases/tags, if there are such
- Deviations from DINA guidelines
- How to do a local build (for testing) - this should include all the steps needed to have the module running.
- Badges, see **Release guidelines**.

# License file

Include license text in the `LICENSE` file. See **Licencing guideline** for details.

# API documentation

If the module privides an API, document it in API-Blueprint format using an .apib file.

**TODO:** Add example.

# Using Docker for building and running

Use Docker for building and running the module as a set of independent containers, connected by a reverse proxy service.

For an overview of how a can be set up, see the [User management module](https://github.com/DINA-Web/accounts-docker/tree/development), which acts as a reference implementation. **TBD** 

**TODO: Decide and add details**
- How standardized should the build-run process be?
- How to exactly set secrets/environment variables 
- Structure, what would be simplest to set up and debug? See some notes at https://github.com/DINA-Web/documentation/wiki/Docker-Practices 
   1) Whole module dockerized in one repository
   1) Each service in separate repo, one repo for dockerizing everything?
   1) Each service in separate repo dockerized, one repo for docker-compose?
   1) Something else?
   1) Development environment can be set locally, only releases dockerized?
   1) All are fine?
- Using proxy-docker launched separately vs. include it in docker-compose vs. using third-party proxy image? 
- Using letsencrypt vs. self-signed certs vs. star-cert (for local builds)?

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

See **QA guidelines**.

# Release

See **Release guidelines**