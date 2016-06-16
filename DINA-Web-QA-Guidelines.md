The following are RECOMMENDED guidelines for QA (quality assurance) of DINA-Web modules.

# Quality Assurance guidelines

Manual checks:

- Check that sources are available openly under acceptable license - take a note of GitHub (or equiv.) URL
- Check that repo shows Green badge for building with Travis CI
- Check that semantic versioning used - take a note of the version nr
- Check that Tests are OK
- Check that Vignette / Turorial / README.md - documentation is provided that explains the module and its usage - take a note of the URL
- Check that API documentation exists if the module exposes an API - take a note of the URL

Checks using tools:
  
- Determine Accessibility Guidelines compliance by running tools and looking at results
- Determine Security OWASP compliance by running tools and looking at results
- Determine performance/scalability compliance by running load testing tools

# Pass or Fail actions
  
- If checks fail, provide results to the module maintainer and kindly ask for specific issues to be fixed. Register issues on relevant repo along with discovered details.
- If checks pass then Announce the release passing QA checks to the mailing list and bundle it into integration projects.

# Tools

These tools have been recommended by collaborators:

- W3C HTML/CSS unified validator https://validator.w3.org/unicorn/
- Jenkins Unicorn validator https://wiki.jenkins-ci.org/display/JENKINS/Unicorn+Validation+Plugin
- https://validator.w3.org/docs/api.html

## Tools for checking Web Accessibility compliance

- TODO: get updated recommendation

## Tools for checking security compliance

- TODO: get updated recommendation

## Tools for testing performance / load

### FOSS Tools

  - jmeter
  - selenium - http://docs.seleniumhq.org/ with the IDE plugin for browsers: http://docs.seleniumhq.org/projects/ide/ which allows recording a session and then https://cran.r-project.org/web/packages/RSelenium/RSelenium.pdf which allows running such a session repeatedly
  - ab - the apache webserver benchmarking tool - sudo apt-get install apache2-utils - example usage at http://www.cyberciti.biz/tips/howto-performance-benchmarks-a-web-server.html
  - httping - simple and nice way to ping an http endpoint, see also http://linux.die.net/man/1/httping and https://github.com/sckott/httping
  - siege - http regression testing and benchmarking utility, can do multiple concurrent users, puts your app "under siege"
  - pylot - alternative JMeter but implemented in Python... CLI tool with GUI, also whole framework available: https://github.com/cgoldberg/multi-mechanize
  - httpperf - linux CLI-tool to measure performance under load, docs, manual at http://www.labs.hpe.com/research/linux/httperf/wisp98/httperf.pdf
  
### Online services

  - loader.io
  - pingdom.com
  
