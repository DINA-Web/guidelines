# Release guidelines

The following are RECOMMENDED guidelines to follow when making releases of modules that are used within the DINA-Web system.

- Provide a `Makefile` that builds code locally and launches services. Various Makefile targets should be provided including for example "dotfiles" which generates random credentials where needed, so these can be provided to components at launch time through environment variables
- Provide a `docker-compose.yml` file with the system composition referencing versioned ("semver") docker images where applicable
- Use semantic versioning and tag your releases like this: `git tag -a v0.0.1 -m "description"`, you can use `git config --global push.followTags true` and your 'git push' will take the tag along, if not you have to do a separate 'git push origin <tag>` before pushing
- For non-local build, use Travis CI and deploy released binary artifacts to GitHub Releases and/or DockerHub
- Document usage in README.md and make your README.md contain a "badge" - builds should show green badge :)
- Provide a NEWS.md or CHANGELOG for the releases
- Then notify someone at DINA TC if your stable release is ready to go upstream

## Notify DINA TC of your release

For the module to be included into the bigger DINA-Web system, you need to notify DINA TC people that you have a stable build. The DINA TC people will need the repo name, the version number (semantic versioning) and see a "green badge" that the code builds properly using Travis CI. If the released module checks out, it will be included in the DINA-Web system. 

# Checklist

Before releasing, make sure that these files are present in the repo:

		LICENSE # open source license
		README.md # explain usage
		CHANGES.md # latest changes
		docker-compose.yml # system composition of versioned micro-services 
		Dockerfile # definition of the portable images
		Makefile # automation: various VERBs for building, testing, starting/stopping services etc
		.travis.yml # continuous integration, providing delivery of build artifacts to GitHub Releases and Docker Hub
		apiary.apib # API specification, relevant if the code implements an API
		api-documentation.html # rendered apiary blueprint as HTML documentation 

Then make sure that the `Makefile` have relevant targets, for example:

		build  # builds from source code
		clean  # removes binary build artifacts

		up # starts the system locally using docker-compose.yml
		down # stops and removes containers

		dotfiles  # generates environment variable secrets (using random data for credentials) 

		release  # pushed docker images to Docker Hub

		backup  # backups system state into preferably non-proprietary formats
		restore  # restores from any timestamped backup

		dox  # if an API component, generates the HTML reference documentation

		test  # launches tests		

The DINA TC will run a check for major or stable releases, looking for:

  - Sources are available openly with LICENSE
	- Local builds work and Makefile has relevant targets for building, cleaning etc
  - Green badge for building with Travis CI
  - Semantic versioning used
  - Tests are OK
  - Documentation is provided that explains the module and its usage (README.md etc)
  - API documentation if the module exposes an API

# Further testing

Released modules will run through a more thorough QA check before being packaged upstream into higher level packages which integrate several different modules into a coherent system. 

Separate QA guidelines then apply, including making checks for:

  - Accessibility Guidelines compliance
  - Security OWASP compliance

Here is a link to the (QA guidelines)[DINA-Web-QA-Guidelines.md]

# Further details and rationale

Here follow detailed instructions and explanations of the release guidelines summarized just above. 

## Use semantic versioning

Use semantic versioning used like this in your releases:

  * Increment patch, e.g. 0.8.2 for a patch: you’ve fixed bugs without adding any significant new features. Most releases will have a patch number of 0.

  * Increment minor, e.g. 0.9.0, for a minor release. A minor release can include bug fixes, new features and changes in backward compatibility. This is the most common type of release. 
  
  * Increment major, e.g. 1.0.0, for a major release. This is best reserved for changes that are not backward compatible and that are likely to affect many users. Going from 0.b.c to 1.0.0 typically indicates that your module is feature complete with a stable API.

## Provide README.md and NEWS.md or CHANGELOG.md

Besides a `LICENSE` complying with the DINA-Web Licensing Guidelines (ie AGPL or GPLv3, MIT or Apache for code, Creative Commons for content), please provide a README.md file with a "badge" that indicates that the repo builds successfully. 

Also provide a `NEWS.md` or `CHANGELOG.md` which describes shortly your versioned releases. On GitHub, you can put in your markdown a link that looks like this that allows people to see which changes were made between two releases: `https://github.com/jmenglund/CollectionBatchTool/compare/v0.1.2...v0.1.3`

## Use Travis CI

Use Travis CI both for building and for releasing. A couple of repos have already started this practice, so you can inspect how these modules have chosen to do this:

  - [Collections Management User Interface](https://github.com/DINA-Web/collections-ui)
  - [Media Server API](https://github.com/DINA-Web/mediaserver-module)
  - [DINA-Specify REST API v0](https://github.com/idali0226/dina-web)
  - [CLI-ETL-tool for Collections data](https://github.com/jmenglund/CollectionBatchTool)

### Builds

Use Travis CI to set up builds for the component(s) by adding a simple text file called  `.travis.yml` file to the root directory of your code repository. Guides are available for your stack here:

  - [Java](https://docs.travis-ci.com/user/languages/java)
  - [Python](https://docs.travis-ci.com/user/languages/python)
  - [R](https://docs.travis-ci.com/user/languages/r)
  - [JS](https://docs.travis-ci.com/user/languages/javascript-with-nodejs)

# Releases

Set up deploy to  GitHub Releases to happen when you push versioned tags. You can find deployment procedures documented here: 

  - [GitHub Releases Guide](https://docs.travis-ci.com/user/deployment/releases)

For higher level packaging which integrate released modules into systems, primarily `docker` should be used. Binary images should be provided from Docker Hub preferably through Automated Builds: https://docs.docker.com/docker-hub/builds/#understand-the-build-process

Use `docker` images for delivering higher level systems and support `docker-compose` for system compositions. When docker images of systems are being built and need to reference external binary build artifacts, these could include a specific version of a stable module taken from "GitHub Releases".

# Regarding versioning and backward compatibility

The big difference between major and minor versions is whether or not the code is backward compatible. This difference is often academic. In practice, backward compatibility is not an all-or-nothing threshold. 

For example, if you make an API-incompatible change to a rarely-used part of your code, it may not deserve a major number change. But if you fix a bug that many people depend on, it will feel like an API breaking change. Use your best judgement.

The importance of backward compatibility is directly proportional to the number of people using your package: you are trading your time for your users time. The harder you strive to maintain backward compatibility, the harder it is to develop new features or fix old mistakes. 
Backward compatible code also tends to be harder to read because of the need to maintain multiple paths to support functionality from previous versions. Be concerned about backward compatibility, but don’t let it paralyse you.

There are good reasons to make backward incompatible changes - if you made a design mistake that makes your package harder to use it is better to fix it sooner rather than later. If you do need to make a backward incompatible change, it’s best to do it gradually.
