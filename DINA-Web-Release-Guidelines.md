**This needs thorough review from developers!!**

**TODO:** Review this when we are closer to releasing a beta or production version.

# Release guidelines

The following are RECOMMENDED guidelines to follow when making releases of modules that are used within the DINA-Web system.

See **Development guidelines** for day-to-day development practices and instructions for making modules build and run with Docker.

# Checklist for release

**TBD** How to have simple enough tagging/versioning process? What changes are needed for beta releases, what for production releases?

- Create the module so that can be built and run with Docker. See **Development guidelines** for details.
- Use semantic versioning and tag your releases.
  - Tag Docker images created for individual services
  - Provide a `docker-compose.yml` file referencing those tagged Docker images where applicable.
  - Merge changes to master, if you arer using separate development branch.
  - Tag the release
- Provide a CHANGES.md to describe major changes in end user -friendly manner. Link to more detailed feature descriptions in the manual as necessary, (Commit messages describe technical details for developers.)
- For non-local build, use Travis CI and deploy released binary artifacts to GitHub Releases and/or DockerHub **TODO: Describe Travis' role better**
- Notify DINA Technical committee (mailing list) if your stable release is ready to go upstream **TODO**: Clarify

Separate **QA guidelines** are used for a more thorough QA check before being packaged upstream into higher level packages which integrate several different modules into a coherent system. 

# Further details and rationale

Here follow detailed instructions and explanations of the release guidelines summarized just above. 

## Tagging

Use semantic versioning (see below) and tag your releases like this:

    git tag -a v0.0.1 -m "description"
   
You can use `git config --global push.followTags true` and your 'git push' will take the tag along, if not you have to do a separate 'git push origin <tag>` before pushing

## Use semantic versioning

Use semantic versioning used like this in your releases:

  * Increment patch, e.g. 0.8.2 for a patch: you’ve fixed bugs without adding any significant new features. Most releases will have a patch number of 0.

  * Increment minor, e.g. 0.9.0, for a minor release. A minor release can include bug fixes, new features and changes in backward compatibility. This is the most common type of release. 
  
  * Increment major, e.g. 1.0.0, for a major release. This is best reserved for changes that are not backward compatible and that are likely to affect many users. Going from 0.b.c to 1.0.0 typically indicates that your module is feature complete with a stable API.

## Use Travis CI

**TBD** Review, if this still up-to-date, is this the way we want to do this?

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

Set up deploy to GitHub Releases to happen when you push versioned tags. You can find deployment procedures documented here: 

  - [GitHub Releases Guide](https://docs.travis-ci.com/user/deployment/releases)

For higher level packaging which integrate released modules into systems, primarily `docker` should be used. Binary images should be provided from Docker Hub preferably through Automated Builds: https://docs.docker.com/docker-hub/builds/#understand-the-build-process

Use `docker` images for delivering higher level systems and support `docker-compose` for system compositions. When docker images of systems are being built and need to reference external binary build artifacts, these could include a specific version of a stable module taken from "GitHub Releases".

# Regarding versioning and backward compatibility

The big difference between major and minor versions is whether or not the code is backward compatible. This difference is often academic. In practice, backward compatibility is not an all-or-nothing threshold. 

For example, if you make an API-incompatible change to a rarely-used part of your code, it may not deserve a major number change. But if you fix a bug that many people depend on, it will feel like an API breaking change. Use your best judgement.

The importance of backward compatibility is directly proportional to the number of people using your package: you are trading your time for your users time. The harder you strive to maintain backward compatibility, the harder it is to develop new features or fix old mistakes. 
Backward compatible code also tends to be harder to read because of the need to maintain multiple paths to support functionality from previous versions. Be concerned about backward compatibility, but don’t let it paralyse you.

There are good reasons to make backward incompatible changes - if you made a design mistake that makes your package harder to use it is better to fix it sooner rather than later. If you do need to make a backward incompatible change, it’s best to do it gradually.
