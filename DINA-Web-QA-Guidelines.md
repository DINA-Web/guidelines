
# Quality Assurance and testing guidelines

The following are RECOMMENDED guidelines for QA (quality assurance) of DINA-Web modules.

# QA for new features

Definition of done / 
Acceptance criteria

# QA for new releases

Released modules will run through a more thorough QA check before being packaged upstream into higher level packages which integrate several different modules into a coherent system. 

## Manual checks

- Check that sources are available openly under acceptable license, in included `LICENSE` file.  - Take a note of GitHub URL
- Check that local builds work and Makefile has relevant targets for building, cleaning etc
- Check that repo shows Green badge for building with Travis CI
- Check that semantic versioning used - take a note of the version nr
- Check that Tests are OK
- Check that `readme.md` - documentation is provided that explains the module and its usage - take a note of the URL
- If the module exposes an API, Check that API documentation exists in API-Blueprint format - take a note of the URL
- Validate the .apib file and API against it

## Checks using tools
  
- Determine Accessibility Guidelines compliance by running tools and looking at results
- Determine Security OWASP compliance by running tools and looking at results
- Determine performance/scalability compliance by running load testing tools

## Pass or Fail actions
  
- If checks fail, provide results to the module maintainer and kindly ask for specific issues to be fixed. Register issues on relevant repository along with discovered details.
- If checks pass then Announce the release passing QA checks to the mailing list and bundle it into integration projects. **TODO: Clarify**

# Tools

These tools have been recommended by collaborators:

- W3C HTML/CSS unified validator https://validator.w3.org/unicorn/
- Jenkins Unicorn validator https://wiki.jenkins-ci.org/display/JENKINS/Unicorn+Validation+Plugin
- ??? https://validator.w3.org/docs/api.html

## Web Accessibility compliance

- TODO: get updated recommendation

## Security compliance

- TODO: get updated recommendation

## Performance / load testing

## FOSS tools

  - jmeter
  - selenium - http://docs.seleniumhq.org/ with the IDE plugin for browsers: http://docs.seleniumhq.org/projects/ide/ which allows recording a session and then https://cran.r-project.org/web/packages/RSelenium/RSelenium.pdf which allows running such a session repeatedly
  - ab - the apache webserver benchmarking tool - sudo apt-get install apache2-utils - example usage at http://www.cyberciti.biz/tips/howto-performance-benchmarks-a-web-server.html
  - httping - simple and nice way to ping an http endpoint, see also http://linux.die.net/man/1/httping and https://github.com/sckott/httping
  - siege - http regression testing and benchmarking utility, can do multiple concurrent users, puts your app "under siege"
  - pylot - alternative JMeter but implemented in Python... CLI tool with GUI, also whole framework available: https://github.com/cgoldberg/multi-mechanize
  - httpperf - linux CLI-tool to measure performance under load, docs, manual at http://www.labs.hpe.com/research/linux/httperf/wisp98/httperf.pdf
  
## Online services

  - loader.io
  - pingdom.com
  
