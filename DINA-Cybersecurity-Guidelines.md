This document
=============

DRAFT


Background
=============
This document sets out a set of policies with respect to IT security and DINA software.

The DINA TC views secure software as fundamental to the integrity of DINA-produced software, also supporting the confidence of partners adopting DINA software.

Security: availability, integrity and confidentiality


#Summary
* All network connections are encrypted
* Applications and web services pass OWASP10
* Non-DINA components hardened as-per component best-practices
* docker hardening
* other?

###Network Connections Encryption
All network connections including those between internal and external services, must be encrypted if encryption is available.

####http/https
All applications and web services are to run only `https`.

#####http Redirects
* For applications, http is redirected to https, but all parameters on the URL are scrubbed (assumed to be compromised) and the redirect is to the entry / default page for the application
* For web services, http is redirected to a `[403](https://en.wikipedia.org/wiki/HTTP_403)` error

###Database and other external dependency connections
If available, encrypted connections must be used.
Examples:
* [PostgreSql SSL](https://www.postgresql.org/docs/current/static/libpq-ssl.html)
* [MySql TLS](http://dev.mysql.com/doc/refman/5.7/en/secure-connections.html)
* [Solr SSL](https://cwiki.apache.org/confluence/display/solr/Enabling+SSL)
* [nginx SSL](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04)

This hardening can be centralized through `docker`ization.

##Web application and Web Services Security
[OWASP10](https://www.owasp.org/index.php/Main_Page) is a list of the 10 top web vulnerabilities, with associated [explanations and mitigation documentation](https://www.owasp.org/index.php/Top_10_2013-Top_10).

Web applications (including web services like a RESTful web service) must pass tests of the Open Source tool, [OWASP ZED](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project).
*Pass* means no vulnerabilities are detected by this tool.

* OWASP10 (and any other reports) MUST not be checked in to github, or attached to issues (we need to agree/figure out how we talk about these reports)


TODO: agree on how to use this tool

Tools
----------------------
* [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/Zapper+Plugin)
* [OWASP Dependency-Check](OWASP Dependency-CheckOWASP Dependency-Check) -- [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/OWASP+Dependency-Check+Plugin)
* [OWASP Lapse Project](https://www.owasp.org/index.php/OWASP_LAPSE_Project)
* [Big list of OWASP10 tools (some for single OWASP vulnerabilities)](https://www.owasp.org/index.php/Appendix_A:_Testing_Tools)

TODO: which to use / how to use


##Dependent Component Security

Applications/services depend on non-DINA applications/services for operation.

Examples: MySql, PostgreSQL, Solr, etc.

In addition to encrypting network connections, application/service dependencies/components should adhere to any other security best practices for that component.
For example, MySql can be secured or *hardened* using guidelines such as [MySQL Database Security Best Practices](http://www.greensql.com/content/mysql-security-best-practices-hardening-mysql-tips).

This hardening can be centralized through `docker`ization.

TODO: Agree on same best practices *per component*



###List of components (not complete) and best practices documents (draft)
* MySql [MySQL Database Security Best Practices](http://www.greensql.com/content/mysql-security-best-practices-hardening-mysql-tips) ?
* PostgreSQL
  * [pupppet-postgres-hardening](https://github.com/dev-sec/puppet-postgres-hardening)


##docker hardening
As docker is a fundamental technology for this project, making it secure is a priority.
* [docker hardening - 1.6](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.6_Benchmark_v1.0.0.pdf)
* Install [fail2ban](http://www.fail2ban.org/)
* [SANS Linux Security checklist](https://www.sans.org/media/score/checklists/linuxchecklist.pdf)

These same hardening best-practices should also be applied to the host OS (not all of them are possible at the container level).
The host OS is not in the control of the DINA team, so install instructions should strongly suggest these and maybe other hardening best-practices.



TODO
* Which docker hardening to use (big list)











