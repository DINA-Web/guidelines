This document
=============

DRAFT


Background
=============
This document sets out a set of policies with respect to IT security and DINA software.

The DINA TC views secure software as fundamental to the integrity of DINA-produced software, also supporting the confidence of partners adopting DINA software.

Security: availability, integrity and confidentiality


#Summary
* 'https' everywhere
* Applications and web services pass OWASP10
* Non-DINA components hardened as-per component best-practices
* docker hardening
* other?

##http/https
All applications and web services are to run only `https`.

###http Redirects
* For applications, http is redirected to https, but all parameters on the URL are scrubbed (assumed to be compromised) and the redirect is to the entry / default page for the application
* For web services, http is redirected to a `403` error

##Web application and Web Services Security
[OWASP10](https://www.owasp.org/index.php/Main_Page) is a list of the 10 top web vulnerabilities, with associated [https://www.owasp.org/index.php/Top_10_2013-Top_10](explanations and mitigation documentation)xo.

Web applications (including web services like a RESTful web service) must test the application or service with the Open Source tool, [OWASP ZED](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project).

* OWASP10 (and any other reports) MUST not be checked in to github, or attached to issues (we need to agree/figure out how we talk about these reports)


TODO: agree on how to use this tool

Tools
----------------------
* [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/Zapper+Plugin)
* [OWASP Dependency-Check](OWASP Dependency-CheckOWASP Dependency-Check) -- [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/OWASP+Dependency-Check+Plugin)
* [OWASP Lapse Project](https://www.owasp.org/index.php/OWASP_LAPSE_Project)
* [Big list of OWASP10 tools (some for single OWASP vulnerabilities)](https://www.owasp.org/index.php/Appendix_A:_Testing_Tools)

TODO: which to use / how to use

Dependent Component Security
=============
Applications/services depend on non-DINA applications/services for operation.

Examples: MySql, PostgreSQL, Solr, etc.

Application/service dependencies/components should adhere to the security best practices for that component.
For example, MySql can be secured or *hardened* using guidelines such as [MySQL Database Security Best Practices](http://www.greensql.com/content/mysql-security-best-practices-hardening-mysql-tips).

TODO: Agree on same best practices *per component*


docker hardening
================
As docker is a fundamental technology for this project, making it secure is a priority.
* [docker hardening - 1.6](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.6_Benchmark_v1.0.0.pdf)
* Install [fail2ban](http://www.fail2ban.org/)

TODO
* Which docker hardening to use (big list)











