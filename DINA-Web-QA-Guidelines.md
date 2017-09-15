
# Quality Assurance and testing guidelines

The following are RECOMMENDED guidelines for QA (quality assurance) of DINA-Web modules.

# QA for new features

**TBD** We may want to move these to internal development documentation. In that case, correct links on Development documentation.

## Before development

When selecting an issue (especially a new feature) to work on, include **acceptance criteria**: Requirements that are specific to that issue, describing in detail how the feature should work. These must be met for the issue be accepted.

For example:
- Validations needed
- Special cases that must be handled

## Testing 

When an issue is resolved for testing (or even before), following things should be done:

**TBD** Common definition of done?

### Manual testing (definition of done):

Most important test cases are marked with *. Others can be skipped is necessary. **TBD**

Check that

- Acceptance criteria for the issue are met **\***
- Documentation is updated, if applicable **\***
   - Manual updated
   - Technical manual updated
   - Data handbook updated, if feature adds new data fields or chnages their meaning
- Usability testing
   - UI guidelines are met. See **UI guidelines**
   - Content (text) should be relevant to the operation, easy to understand and grammatically correct (in all applicable languages)
   - Incorrect input is handled correctly
   - Links lead to correct locations
   - Delete operations require confirmation
   - Forms can be used with keyboard only, including submit buttons
   - Form fields can be tabbed through in logical order
   - Error messages clearly point to the error
   - Public pages have proper titles
   - No content is truncated (e.g. in dropdown lists)
- Functional testing
   - Handling negative numbers & zeroes
   - Handling overly long content
   - Handling special characters (test string: ÅÄÖåäö ÁáÐðÞþ русский алфавит)
   - Sorting
   - Button functionality
   - Email functionality (emails arriving properly)
   - User clearing cookies
   - User working (editing, loggin in/out) on several tabs / browsers simultaneously
   - Several users working on same data simultaneously
- Compatibility testing
   - Works with recent versions of Firefox, Chrome and Safari **TBD**
   - Responds well to different screen sizes, down to 1024 x 800px **TBD**
   - No JavaScript errors (in the console)
- Database testing
   - Verify that CRUD operations work correctly
   - Verify that data is saved to and retrieved from the database correctly, and that no data is lost
   - Test that stored procedures, triggers etc. work correctly
- Security testing
   - SSL is used everywhere
   - No certification warnings or errors
   - All user input is filtered correctly (e.g. SQL injection attacs)
   - Users can only access features they are allowed to
   - Users can only see sensitive information they are allowed to
   - Improtant operations are logged
- Performance testing
   - **TODO later**


### Automated testing

Check that

- Unit tests are passing, see badge on Github (for the newest version/branch)
- **TODO**: Add more?
- Integration testing? **TBD**

Write result of testing to issue comments: what is working and what isn't, new ideas for further development etc.

If testing is passed, move issue to **resolved**. If problems are found, put the issue back **in progress**.

## Review

During review, check that:

- Acceptance criteria are met (i.e. feature works as expected)
- Proper testing done and passed

# QA for new releases

Released modules will run through a more thorough QA check before being packaged upstream into higher level packages which integrate several different modules into a coherent system. 

## Manual checks

- Check that **Security guidelines** are met
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
  
