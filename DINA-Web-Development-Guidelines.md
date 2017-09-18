# Development guidelines

This is RECOMMENDATION for day-to-day software development practices, aiming to: 
- Set common practices so that modules would be built in fairly consistent manner
- Describe practices to avoid dependencies on any single developer's expertise
- Act as a reminder checklist for developers 

## What to include in these guidelines?

There is no need to describe every practice here in complete detail, instead link to widely used public manuals elsewhere.

If there are many common ways to do something, but only one particular practice is preferred here, it should be included in these guidelines.

## Terms

* Module = this often refers to a lower level component such as a library, ie a unit which adresses a specific functional task, for example a module could contain a tool to load Collections data into an API while the data model itself can be another separate module
* Service = this is more of a medium level self-contained networked system-level unit with clearly delineated boundaries and dependencies on other higher level system level components - such as a Web API for delivering data (an example of a service which may depend on a database), a web-based User Interface component (an example of a service which may depend on an API for data services), a separate database component etc.
* System = highest level building block - a portable and independent composition of various services running together capable of addressing a wide set of functionality, including import and export of data from standard formats. Sometimes but not always a system may be considered to include even various human processes such as support and other operational aspects involved in running the system.

# Summary checklist

- Prefer common tools and processes. Document deviations clearly.
- Add a `README.md` file and keep it up-to-date
- Describe features in new versions of the component in `CHANGES.md` in a way that can be understood by an external party
- Add other relevant files, such as source code etc.
- Document any API's in Blueprint-API format by providing an `.apib` file
- Include a `Makefile` to automate usage, especially reproducible local building and running
   - Create secrets (credentials etc) automatically using environment variables and 'dotfiles' to store system configuration settings whenever possible.
- Use common Docker practices to support building and running, including a definition of the system composition using a `docker-compose.yml` file referring to versioned images
   - Reference any secrets kept in environment variables in the `docker-compose.yml` using 'dotfiles'

# Further details and explanations

Use Git, GitHub and Docker Hub for version control, issues and releases.

Double-check that no passwords or other **secrets** are committed (use `.gitignore`). See more details on secrets below.

Before releasing, make sure that these files are present in the repo, if applicable for the module:

File | Purpose
--- | ---
LICENSE | Open source license
README.md | Explain usage, see below
CHANGES.md | Overview of changes (details are in commit messages)
docker-compose.yml | Settings for running the module with docker-compose
Dockerfile | Build settings of portable images for services
Makefile | Automation of build/run processes, see below
.travis.yml | Continuous integration, providing delivery of build artifacts to GitHub Releases and Docker Hub
apiary.apib | API specification if the code implements an API
api-documentation.html | rendered apiary blueprint as HTML documentation

## `README.md` file

Every module and submodule/service must have a `README.md` file, which describes briefly

- What the module is about
- How to do a local build (for testing) - this should include all the steps needed to have the module running.
- Badges, see [Release guidelines](DINA-Web-Release-Guidelines.md).

## License file

Include license text in the `LICENSE` file. 

See [Licensing guidelines](DINA-Web-Licensing-Guidelines.md) for details.

## API documentation

If the module privides an API, document it in API-Blueprint format using an `.apib` file. 

See [Collections API v0 documentation](https://github.com/DINA-Web/collections-api/blob/master/apiary.apib) for an example.

## System composition with `docker-compose.yml`

Use Docker for building and running the module as a set of independent containers.

See the [User management module](https://github.com/DINA-Web/accounts-docker/tree/development) for an example.
 
## Makefiles

Provide `Makefile` for building code locally and launch services. Prefer descriptive commands over short and abstract ones. 

Prefer these standard targets in the Makefiles:

| Target | Purpose |
--- | ---
secrets | generate random credentials (must have if service needs credentials)
dotfiles | generates environment variable files from secret file
build | build from source code
up | starts the system locally using docker-compose
down | stops and removes containers
clean | removes binary build artifacts, so that fresh build can be made
release | releases versioned images to Docker Hub
backup | backups system state into preferably non-proprietary formats
restore | restores from any timestamped backup
init | set environment variables, if not done with docker-compose
dox | if an API component, generates the HTML reference documentation
test | launches tests

The `README.md`file should describe usage and explain the rationale for specific `Makefile` targets. The Makefile should include the `all` target which automates all individual necessary sub-steps for building and launching the system from scratch.

### Secrets

Generate secrets automatically during build process whenever possible using randomly generated credentials (i.e. when services are inside a multi-container application deployed as a single entity.)

Save secrets into so called 'dotfiles' (e.g. .env-servicename). Commit only templates of these file into Git. Read secrets from these files to containers’ environment variables when deploying with `docker-compose` (using settings on `docker-compose.yml`).

# Release

See [Release guidelines](DINA-Web-Release-Guidelines.md)

# Testing

See [QA guidelines](DINA-Web-QA-Guidelines.md).
