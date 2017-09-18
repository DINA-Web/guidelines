# Release guidelines

The following are RECOMMENDED guidelines to follow when making releases of modules that are used within the DINA-Web system.

Tagging and versioning (using "semver") should happen for all builds intended for use by others. A particular version may be chosen to be used as either an "alfa", "beta" or a production release if it is stable enough, based on findings from a Quality Assurance (QA) check.

# Checklist for release

1. Create the module so that it builds and runs locally. See the [Development guidelines](DINA-Web-Development-Guidelines.md) for day-to-day development practices and instructions for making modules build and run.
1. When ready to create a release that others can use or test, increment version numbers using semantic versioning for the images and libraries involved in the project.
	- Provide a `docker-compose.yml` file referencing tagged Docker images where applicable.
	- Provide a `CHANGES.md` to describe major changes in non-technical language - the commit messages already describe the technical details for developers and often need explanation. Link to more detailed feature descriptions in the manual as necessary.
1. Push tags to GitHub and release images to Docker Hub
	- For local manual builds, use "make release"
	- For non-local automated builds, use Travis CI - ie provide a `.travis.yml` file to build and publish versioned build artifacts automatically - so that libraries are released to GitHub Releases and images are available from Docker Hub.
1. Notify your colleagues or the DINA Technical committee (mailing list) that a new version is available and ready for QA testing and to be integrated elsewhere in the DINA-Web system.

Separate [QA guidelines](DINA-Web-QA-Guidelines.md) are available for the QA check. The QA check is required to determine whether at particular released version is stable enough to be deployed widely or packaged into other, higher level packages that integrate several different DINA-Web modules into a coherent system. 

For example: all versions may be deployed nightly into "alfa" UAT environments, some more stable "beta" versions may be deployed at end of sprints and more thoroughly tested and stable versions can be deployed in production environments.

# Further details and rationale

Here follows more details in relation to the matters summarized above, such as explanations of semantic versioning, detailed tagging instructions and various links with concrete examples illustrating the  recommended practices for releasing. 

## Releasing versioned libraries and images

In summary: Use `docker` images for delivering higher level systems and support `docker-compose` for system compositions. When docker images of systems are being built and need to reference external binary build artifacts, these could include a specific version of a stable binary library taken from "GitHub Releases".

### Automated Builds at Docker Hub

For higher level packaging which integrate released modules into systems, binary images should be build using `docker`. These should be released to Docker Hub preferably through Automated Builds: 

- [Docker Hub Automated Builds](https://docs.docker.com/docker-hub/builds/#understand-the-build-process)

### Versioned Releases at GitHub Releases

For lower level components, such as libraries etc, use `.travis.yml` to release versioned builds to GitHub Releases. You can find deployment procedures documented here: 

- [GitHub Releases Guide](https://docs.travis-ci.com/user/deployment/releases)

## Continuous Integration with Travis CI

Use Travis CI for automatically triggering non-local builds and releases. Set up builds for the component(s) by adding a simple text file called  `.travis.yml` file to the root directory of your code repository. Guides are available for your stack here:

  - [Java](https://docs.travis-ci.com/user/languages/java)
  - [Python](https://docs.travis-ci.com/user/languages/python)
  - [R](https://docs.travis-ci.com/user/languages/r)
  - [JS](https://docs.travis-ci.com/user/languages/javascript-with-nodejs)

A couple of repos have already started this practice, so you can inspect how these modules have chosen to do this:

  - [Collections Management User Interface](https://github.com/DINA-Web/collections-ui)
  - [Media Server API](https://github.com/DINA-Web/mediaserver-module)
  - [DINA-Specify REST API v0](https://github.com/idali0226/dina-web)
  - [CLI-ETL-tool for Collections data](https://github.com/jmenglund/CollectionBatchTool)

## Tagging

Use semantic versioning (see below) and tag your releases like this:

    git tag -a v0.0.1 -m "description"
   
You can use `git config --global push.followTags true` and your 'git push' will take the tag along, if not you have to do a separate 'git push origin <tag>` before pushing

## Use semantic versioning

Use semantic versioning used like this in your releases:

  * Increment patch, e.g. 0.8.2 for a patch: you’ve fixed bugs without adding any significant new features. Most releases will have a patch number of 0.

  * Increment minor, e.g. 0.9.0, for a minor release. A minor release can include bug fixes, new features and changes in backward compatibility. This is the most common type of release. 
  
  * Increment major, e.g. 1.0.0, for a major release. This is best reserved for changes that are not backward compatible and that are likely to affect many users. Going from 0.b.c to 1.0.0 typically indicates that your module is feature complete with a stable API.

# Regarding versioning and backward compatibility

The big difference between major and minor versions is whether or not the code is backward compatible. This difference is often academic. In practice, backward compatibility is not an all-or-nothing threshold. 

For example, if you make an API-incompatible change to a rarely-used part of your code, it may not deserve a major number change. But if you fix a bug that many people depend on, it will feel like an API breaking change. Use your best judgement.

The importance of backward compatibility is directly proportional to the number of people using your package: you are trading your time for your users time. The harder you strive to maintain backward compatibility, the harder it is to develop new features or fix old mistakes. 
Backward compatible code also tends to be harder to read because of the need to maintain multiple paths to support functionality from previous versions. Be concerned about backward compatibility, but don’t let it paralyse you.

There are good reasons to make backward incompatible changes - if you made a design mistake that makes your package harder to use it is better to fix it sooner rather than later. If you do need to make a backward incompatible change, it’s best to do it gradually.
