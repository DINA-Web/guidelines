# Security guidelines

DRAFT, **TBD**

## Background

This document sets out a set of guidelines about IT security.

The DINA TC views secure software as fundamental, also supporting the confidence of partners adopting DINA software. Security means availability, integrity and confidentiality

## Summary

* Network connections are encrypted
* Applications and web services pass OWASP10
   * Applications are tested for malicious user input
* Non-DINA components are hardened as-per component best-practices
* Docker is hardened
* other? **TBD**

## Further Details and Explanations

### Network Connections Encryption

All network connections including those between internal and external services, must be encrypted if encryption is available.

All applications and web services are to run only `https`.

For applications, `http` is redirected to `https`, but all parameters on the URL are scrubbed (assumed to be compromised) and the redirect is to the entry or default page for the application

For web services, http is redirected to a `[403](https://en.wikipedia.org/wiki/HTTP_403)` error

Examples:
* [PostgreSql SSL](https://www.postgresql.org/docs/current/static/libpq-ssl.html)
* [MySql TLS](http://dev.mysql.com/doc/refman/5.7/en/secure-connections.html)
* [Solr SSL](https://cwiki.apache.org/confluence/display/solr/Enabling+SSL)
* [nginx SSL](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04)

This hardening can be centralized through `docker`ization.

## Web application and Web Services Security

[OWASP10](https://www.owasp.org/index.php/Main_Page) is a list of the 10 top web vulnerabilities, with associated [explanations and mitigation documentation](https://www.owasp.org/index.php/Top_10_2013-Top_10).

Web applications (including web services like a RESTful web service) must pass tests of the Open Source tool, [OWASP ZED](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project).
*Pass* means no vulnerabilities are detected by this tool.

* OWASP10 (and any other reports) MUST not be checked in to github, or attached to issues (we need to agree/figure out how we talk about these reports) **TBD** Why? How confidential are these?

Tools

**TBD**: which to use / how to use / when to use?

* [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/Zapper+Plugin)
* [OWASP Dependency-Check](OWASP Dependency-CheckOWASP Dependency-Check) -- [Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/OWASP+Dependency-Check+Plugin)
* [OWASP Lapse Project](https://www.owasp.org/index.php/OWASP_LAPSE_Project)
* [Big list of OWASP10 tools (some for single OWASP vulnerabilities)](https://www.owasp.org/index.php/Appendix_A:_Testing_Tools)

## Dependent Component Security

Application/service may depend on non-DINA Application/service for operation. (E.g. MySql, Keycloak, Solr, etc.)

Application/service dependencies/components should adhere to any other security best practices for that component. For example, MySQL can be secured or *hardened* using guidelines such as [MySQL Database Security Best Practices](http://www.greensql.com/content/mysql-security-best-practices-hardening-mysql-tips).

This hardening can be centralized through dockerization. **TBD** How?

**TBD**: Agree on same best practices *per component*

### Example list of components and best practices documents (draft)
* MySql [MySQL Database Security Best Practices](http://www.greensql.com/content/mysql-security-best-practices-hardening-mysql-tips) ?
* PostgreSQL
  * [pupppet-postgres-hardening](https://github.com/dev-sec/puppet-postgres-hardening)

## Docker Security

As docker is a fundamental technology for this project, making it secure is a priority.

**TBD** Check how up-to-date these are? Which Docker hardening to use (big list)

* [docker hardening - 1.6](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.6_Benchmark_v1.0.0.pdf)
* Install [fail2ban](http://www.fail2ban.org/)
* [SANS Linux Security checklist](https://www.sans.org/media/score/checklists/linuxchecklist.pdf)

These same hardening best-practices should also be applied to the host OS (not all of them are possible at the container level).

The host OS is not in the control of the DINA team, so install instructions should strongly suggest these and maybe other hardening best-practices.
