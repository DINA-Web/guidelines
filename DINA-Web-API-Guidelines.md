DINA API Guidelines
===================

Provides binding guidelines for the design of DINA Web APIs. 

For more information about the DINA Project, please visit the [DINA wiki](http://www.dina-project.net/wiki/DINA_Technical_Committee).

Authors
-------

DINA International consortium - Technical Committee

DINA REST API standard - Background, resources, conventions
===========================================================

Context & Objectives
--------------------

The DINA REST API standard provides guidelines for the implementation of
DINA-compliant RESTful APIs for modules and systems developed by DINA
partners or any contributor of modules and systems that are intended for
integration into DINA system assemblies. Specifically, this API standard
is developed with the intent to:

-   provide a realiable contract between DINA modules
-   enable a simple assembly of modules and systems developed by
    partners in the DINA consortium
-   enable the integration of external modules and systems into DINA
    assemblies

Furthermore, this standard should be seen as an invitation to all
interested parties to contribute to the DINA tool set and help grow the
DINA ecosystem and community.

The guidelines in this document provide a set of constraints that have
to be observed in order for a contribution to be considered
DINA-compliant. In the definition of these constraints the authors were
guided by the following principles:

-   The DINA consortium wants to encourage a fast-growing and diverse
    ecosystem of DINA-compliant contributions, thus the standard should
    ensure a reliable contract for integration of a broad range of
    modules, but should not be overly restrictive.
-   While examples or recommendations for tools, frameworks or
    technologies may be given in the standard, it must not impose any
    implementation technologies on contributors.
-   If open normative standards exist that cover specific requirements
    of the DINA REST API standard, it should build on and incorporate
    these standards instead of defining custom solutions.

Document conventions
--------------------

This document outlines requirements and recommendations for web APIs
exposed by modules and services in the DINA project. The following
conventions are applied to distinguish between mandatory and optional
features of DINA-compliant web APIs:

-   **MUST** - the usage of this term indicates features of the standard
    that any implementation is required to fullfill in order to be
    considered DINA-compliant.
-   **SHOULD** - indicates optional features that are highly recommended
    for implementation, but are not required; if these features are
    implemented they **MUST** follow the recommendations outlined in the
    standard.
-   **COULD** - indicates optional features that are considered
    beneficial for the service, but are not required; if these features
    are implemented they **MUST** follow the recommendations outlined in
    the standard.

DINA-compliant web APIs may of course provide features that are outside
the contract covered by this standard, but they **MUST** not break any
of the recommendations covered by mandatory or optional features defined
by this standard.

**NB:** Non DINA implemented module ( i.e Keycloak, SOLR ) do not have to comply with this specification.
However, in some circumstances web api wrappers may be used where appropriate.

DINA REST API standard - Specification
======================================

API Isolation
-----
An API **SHOULD** only serve what its responsible for and avoid calling another API to supplement data. The caller of the API is responsible for aggregating the data from different API responses. The goal is to keep the system simple and flexible by avoiding a cascade of calls from a single API call by the client. This is also valid for data mutations since distributed transaction are not supported.

Inter-module reference
-----
Inter-module references are not enforced at insert/update/delete time. A module pointing to a record in another module **SHOULD** only keep the type and the identifier. Identifiers usage and potential broken references **SHOULD** be collected asynchronously and aggregated in a report.
 
Adheres to the JSON API specification
------

The DINA REST API Standard adheres to the [JSON API - specification version (v1.0)](http://jsonapi.org/format/).
If the DINA REST API deviates from the JSON API-Specifiaction that is noted in this document.  <p>
	
For binary files, non-JSON and therefore non-JSON-API can also be used (e.g. uploading/downloading raw images).

Basics
------
All DINA-compliant APIs follow basic RESTful practices with regard to
the 

- Use of HTTP as a protocol
- Conventions of mapping HTTP methods to
CRUD operations
- Structuring URIs to address API endpoints
- Using JSON as requests and response format

Endpoint definitions
--------------------

### HTTP methods ###

DINA-compliant APIs **MUST** follow a common usage of HTTP methods. An
agreed mapping of HTTP methods to common CRUD operations ensures a
transparent behaviour. The DINA API standard assumes the mappings listed
in the following sections. To illustrate these mappings the table refers
partly to the ongoing specification of the collections module and partly
to the DINA-compliant 'media server' module, indicated by the reserved word
(URI path component) ***"media"*** and a data object ('media type' / 'entity' [^8])
handled by the web service indicated by ***"image"***.

If not noted otherwise it is expected that an endpoint's ***HTTP HEAD*** calls are returning just the HTTP meta-data section of the corresponding ***HTTP GET*** call.


#### Basic CRUD operations ####

http://jsonapi.org/format/#crud

#### Filtering, sorting, pagination ####

* http://jsonapi.org/format/#fetching-filtering
  * http://jsonapi.org/recommendations/#filtering
* http://jsonapi.org/format/#fetching-pagination
  * Pagination **MUST** be implemented using the offset-based strategy, using the URI paramaters `page[offset]` and `page[limit]`
* http://jsonapi.org/format/#fetching-sorting

#### Relationships ####

**[under-discussion]**: This part could be clarified further.

1. see : http://jsonapi.org/format/#document-links
2. see : http://jsonapi.org/format/#fetching-relationships

**'links'** would give you the number of how many relationships there are. Then you would make another API call ('Fetching Relationships') to get the relationships data. The following links-object includes a URL as well as meta-information about a related resource collection:

```
"links": {
  "related": {
    "href": "http://example.com/articles/1/comments",
    "meta": {
      "count": 10
    }
  }
}
```

#### External Relationhips ####

A relationship **COULD** point to a record in another module. The relationship is represented as a regular relationship except that it can not be expended, only the `type` and the `id` can be returned:
```
"relationships": {
    "dcCreator": {
      "data": { "type": "person", "id": "bc33af02-db10-4b6d-8c32-c6027733e05c" }
    }
  }
```

When an external relationship is included, the top-level `meta` section **MUST** include the mapping between the external `type` and where it resolves to:
```
"meta": {
  "external": [
    {"type":"person" 
     "href":"dinaapi.org/agent/person"}
   ]
}
```

### HTTP header use

DINA-compliant web APIs **MUST** support at least the variables
indicating supported media types. For HTTP requests this
is ***Accept:*** (e.g. *Accept: application/json*) and for HTTP response
this is ***Content-Type:*** (e.g. *Content-Type: application/json*). The
Accept: header is described by [W3C RFC2616 Section 14.1](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.hml\#sec14.1)[^3]

The supported and indicated media types must be recognized *Multipurpose
Internet Mail Extensions (MIME) types* registered with the Internet
Assigned Numbers Authority (IANA)'s media type catalogue. For most
standard file types [IANA's media type catalogue](http://www.iana.org/assignments/media-types/media-types.xhtml)[^4]
will provide the appropriate type definition.

### URI structure

#### Basics

DINA-compliant APIs **SHOULD** indicate base URLs for API endpoints with
an "api" subdomain, thus *```http://api.dinamodule.net/```* would be
considered preferable over *```http://www.dinamodule.net/api/```* under this
scheme.

DINA-compliant APIs **MUST** include a version indicator that is
appended directly to the endpoint base URI,see  the [Versioning](#Versioning) section of this document.

Multiple URL schemes **COULD** be supported by using
rewrite/redirect/proxy directives.<p>
Example scenarios: 
(1) Each module is
hosted at a unique domain, e.g. ```http://api.dinamodule.net/version/```
and (2) Modules are consolidated and provided via a single domain, e.g.
```http://api.host/module/version```.<p> Both of these scenarios can be
accomplished using rewrite/redirect/proxy directives from an original
URL of ```http://localhost:port/module/version```.

All date time formats **MUST** conform to the subset of ISO 8601 defined in
<http://www.w3.org/TR/NOTE-datetime> and <http://schema.org/DateTime>.

#### Passing parameters

DINA-compliant APIs **MUST** accept parameters as key-value pairs
following standard URI patterns, e.g.
*```<path>/xxx?id=1234```*.

This is extended for jsonapi filtering http://jsonapi.org/recommendations/#filtering where the pattern is:
*```<path>/xxx?filter[id]=1234```*.
This is consistent with the reserved URI characters described in RFC 3986 Uniform Resource Identifier (URI): Generic Syntax https://tools.ietf.org/html/rfc3986#section-2.2

#### Reserved words

-   Reserved words indicating a module/service endpoint:
    -   "collections" and/or "collection"
    -   "dna"
    -   "taxonomy"
    -   "media"
    -   "report"
    -   "printing"
    -   "references" and/or "literature"
    -   "geography"
    -   "preparation" and/or "storage"
    -   "determination"
    -   "transaction"
    -   "account" and/or "user"
    -   ...

-   Reserved words indicating data concepts:
    -   "specimen" and/or "object"
    -   "taxon" and "taxa"
    -   "organisation" and/or "institution" and/or "project"
    -   "event"
    -   "locality"
    -   "method" and/or "measurement"
    -   "agent"
    -   "person"
    -   "user"
    -   "annotation"
    -   "account"
    -   ...

-   URI
    - Parameters reserved by JSON-API: "page" and "filter"

In general, both singular and plural versions of those terms **SHOULD** be considered as reserved words, and terms should always be used in lowercase.


### HTTP response

HTTP responses returned by DINA-compliant API endpoints **MUST** be
returned as valid JSON jsonapi documents ( source : http://jsonapi.org/format/#document-meta ) and follow a standard response structure. 
The basic structure of a DINA API compliant JSON reponse is listed below:

Response for a single record:
<pre>
{
 "jsonapi": {
    "version": "1.0"
  }
  "meta": {
    "copyright": "Copyright 2015 Example Corp.",
    "authors": [
      "Yehuda Katz",
      "Steve Klabnik",
      "Dan Gebhardt",
      "Tyler Kellen"
    ]
  },
  "data": [{
    "type": "articles",
    "id": "1",
    "attributes": {
      "title": "JSON API paints my bikeshed!"
    },
    "links": {
      "self": "http://example.com/articles/1"
    },
    "relationships": {
      "author": {
        "links": {
          "self": "http://example.com/articles/1/relationships/author",
          "related": "http://example.com/articles/1/author"
        },
        "data": { "type": "people", "id": "9" }
      },
      "comments": {
        "links": {
          "self": "http://example.com/articles/1/relationships/comments",
          "related": "http://example.com/articles/1/comments"
        },
        "data": [
          { "type": "comments", "id": "5" },
          { "type": "comments", "id": "12" }
        ]
      }
    }
  }],
  }
}
</pre>


First response for a filter request returning multiple records spanning multiple responses (from jsonapi examples):
(Note offset/limit based pagination)
<pre>
{
  "meta": {
    "results": 13
  },
  "data": [
    {
      "type": "articles",
      "id": "3",
      "attributes": {
        "title": "JSON API paints my bikeshed!",
        "body": "The shortest article. Ever.",
        "created": "2015-05-22T14:56:29.000Z",
        "updated": "2015-05-22T14:56:28.000Z"
      }
    }
  ],
  "links": {
    "self": "http://example.com/articles?page[offset]=3&page[limit]=1",
    "first": "http://example.com/articles?page[offset]=1&page[limit]=1",
    "prev": "http://example.com/articles?page[offset]=2&page[limit]=1",
    "next": "http://example.com/articles?page[offset]=4&page[limit]=1",
    "last": "http://example.com/articles?page[offset]=13&page[limit]=1"
  }
}

</pre>
links and relationships -keys are not mandatory.

The object's actual data is stored in the the `attributes` key http://jsonapi.org/format/#document-resource-object-attributes This can contain json of any form.

This json **MUST** not use json keys as values.For example, the following is an example of not acceptable json:
<pre>
...
  "data": [
    {
      "type": "species",
      "id": "3",
      "attributes": {
      		    "460932": "Aspergillus ochraceus"
		    }
      },
    {
      "type": "species",
      "id": "3",
      "attributes": {
      		    "5464387": "Apergillus niger"
		    }
      }]
...
</pre>

Here is the equivalent acceptable json:
<pre>
...
  "data": [
    {
      "type": "species",
      "id": "3",
      "attributes": {
      		    "external_id": "460932"
      		    "name":"Aspergillus ochraceus"
		    }
      },
    {
      "type": "species",
      "id": "3",
      "attributes": {
      		    "external_id":"5464387"
		    "name":"Apergillus niger"
		    }
      }]
...
</pre>

API response - Top Level
-----------------------

According to the JSON API specification "A document MUST contain at least one of the following top-level members: <p>

* data: the document’s “primary data”
* errors: an array of error objects
* meta: a meta object that contains non-standard meta-information.

The members data and errors MUST NOT coexist in the same document."<p> [^9]


API response "meta"
-----------------------

A DINA-compliant endpoint **MUST** return the following properties in
the response meta section:

|Property | Datatype | Description |
|----|----|----|
| limit          |      int  |      The value of the limit (pagination) parameter provided by the caller of the endpoint.|
| offset        |       long  |      The value of the offset (pagination) parameter provided by the caller of the endpoint.|
| callDate      |       string  |      Datetime at which the call to the endpoint was received. http://schema.org/DateTime. Format as per http://www.w3.org/TR/NOTE-datetime|
| response_time     |      long  |     Time to handle response, in milliseconds
| apiVersion     |      string  |      Version identifier of the endpoint API.|
| results    |      long  |      Count of the result objects returned by the call to this endpoint, unless the particular endpoint **ALWAYS** returns one object||
| sort     |      array of string  |      Result object properties  on which the returned result set is sorted. Example: `sort=age,height`. AS PER jsonapi http://jsonapi.org/format/#fetching-sorting. "The sort order for each sort field MUST be ascending unless it is prefixed with a minus (U+002D HYPHEN-MINUS, “-“), in which case it MUST be descending."|
| resultLanguage|      string  |      Language of the result content - if applicable.|
| message            |  string  |      General message explaining the response - if any.|
| maintenanceContact |  string  |      Links to services and contacts that provide information and support in case of service disruptions.|
| moduleVersion |  string  |      Version of the underlying module's codebase.|
| ...                |  ...  |      ...|


A compliant sample response in JSON format:

<pre>
    {
       "meta": {
          "results": 34543
	  "offset": 200
          "limit": 50,
	  "callDate": "2015-11-05T08:15:30-05:00",
          "apiVersion: "1.0",
	  "responseTime": 23
          "orderBy": [
	  	     "-ID",
		     "InventoryDate"
          ],
          "resultLanguage": "SE_sv"
          "message": "",
          "maintenanceContact": "admin@dina-system.org"
          ...
       }

       "data": ...
    }
</pre>

API response "data"
-----------------------

A DINA-compliant endpoint **MUST** return a `data` section according to JSON API [Resource Objects](https://jsonapi.org/format/#document-resource-objects).

Additionally, the `data` section **SHOULD** return standard administrative metadata:

* `createdBy`: username used to create the record (not an agent)
* `createdOn` : date/time (ISO 8601) of when the record was created
* `group`: the name of the group that owns the record (optional)

API response "errors"
-----------------------

source : http://jsonapi.org/format/#errors <p>
A DINA-compliant endpoint **MAY** return the following properties in
the response errors section:

**start [under-discussion]** Should we have some members as MUST such as 
* code
* source 
* title
* detail
* meta -> Should we add languages here ?

see -> http://jsonapi.org/examples/#error-objects-error-codes
**End [under-discussion]** 

Generic operations
------------------

### Pagination

All DINA-compliant APIs **MUST** support pagination of large result
sets, accepting the following parameters:

|URI term   | Parameter  | Default   |  Description |
|:----------|:-----------|:----------|:-------------------|
|**[ANY]**  |limit       |100        | The maximum number of items in the returned result set.|
|**[ANY]**  | offset     | -         |  Determines the offset of items in a result set and thus provides an implicit pagination mechanism.|

### Count

All API calls that result in a list of records (paged of course) **MUST**
also support a "**'/count**' endpoint, that returns the number of results if the
API had been called. Note that this is also applied to URLs with passed
parameters, i.e.

* Retrieves paged list of matching records. ->  `/media?filter[taxon]=Thaumotopea`
* Retrieves the number of results if the search was directly called.->  `/media/count?filter[taxon]=Thaumotopea`
* Retrieves paged list of all media objects. -> `/media`
* Retrieves the total number of media objects. -> `/media/count`
 
**[under-discussion]** Is this a MUST?

### Delete

In order to reduce inter-module reference issues while maintaining the system simplicity, resources **SHOULD** be deleted in a "soft-delete" manner.

It implies that resources should not be completely deleted and still be resolvable after deletion. Such resources **SHOULD** return a `410 Gone` instead of a `404 Not Found`, with a body indicating how to access the deleted entity (e.g. sample/cf71a71e-2176-4d6f-9f17-a4c4f3dd104e?deleted=true). Deleted resources should not appear in a list operation.

Hard-delete **MUST** be available for administrator to completely remove a resource if required (e.g. sensitive information).

### Supported languages

All DINA-compliant APIs **SHOULD** provide a generic operation to
request languages supported by the service. Support for this request
**MUST** be implemented with a non-parameterised GET request using the
reserved word **languages** as the last element of the endpoint URI.

|URI term |  Parameter  | Description |
|:--------|:-----------|:-----------|
|**GET/languages** |-       |Requests a list of all languages supported by the service, returned as a meta-data object in the standard response format. By default supported languages should be included in the meta-data section of API responses. This call should support retrieval of supported languages **only**.|

Sample response:
<pre>
    {
       "meta": {
          "callDate": "2014-10-08T08:08:18+01:00",
          "apiVersion: "1.0",
          "results": 0,
          "supportedLanguages": [
              "sv",
              "en",
              "et"          
          ]
          ...
       }
      "links": {
      	       "self": "http://api.refimplementation.net/v1/media/languages"
	       }
    }
</pre>

#### URI parameters for language
To request results in a supported language, the parameter `language` is used. For example, `/media?filter[taxon]=Thaumotopea&language=sv`

Use lowercase two-letter ISO-639-1 codes for languages.


**RAW Objects**
Some objects, such as those that are embeddable natively in HTML, like images, audio, video, etc. need to be accessible directly, not wrapped in a JSON envelope.
Therefore, on accessing such object the `Content-Type` should be set to the expected value including a filename with the proper extension.

APIs supporting raw objects upload should accept `multipart/form-data` request. 

Documentation
-------------

-   Each DINA compliant Web REST API **MUST** have an agreed OpenAPI Specification Version 3 for their API under source control in https://github.com/DINA-Web.
-   Specification repositories should be able to automaticaly generate API documentation from the OpenAPI Specification file.

References:  
- https://www.openapis.org/
- http://spec.openapis.org/oas/v3.0.3 
- https://openapi.tools/

<a name="Versioning">Versioning</a>
----------

DINA compliant APIs **MUST** follow a versioning scheme to provide a
transparent contract for users of the service.

API versions **MUST** be indicated in the URI of an endpoint. In the
context of this standard an endpoint is assumed to be the endpoint for a
specific DINA module, clearly indicated by a reserved word in the
endpoint URI and the structure of the endpoint URI **MUST** follow the
pattern **[URI\_BASE]/[MODULE\_NAME]/[VERSION\_IDENTIFIER]**, where:

-   **[URI\_BASE]** is the partner specific base URI such as
    **<http://api.dinapartner.net>**,
-   **[MODULE\_NAME]** is a reserved word (see section appropriate
    section) that clearly indicates the module such as **media** for the
    media server module,
-   **[VERSION\_IDENTIFIER]** is an abbreviated version indicator such
    as **v1**.

The URI **<http://api.dinapartner.net/media/v1>** would thus be a
standards-compliant versioned endpoint URI.

Versioning of the API **SHOULD** be driven by significant changes in the
endpoint logic, i.e. changes in the request or response structure.

The API **SHOULD** use version numbers that are easy to read and
maintain, i.e. v1, v2, v3 for major versions and v1\_1, v1\_2\_3 for
minor versions.

It seems good practice to maintain at least two versions for a suitable
transition period.


Authentication
--------------

If the API is read-only and open to the world, no mechanism for
authentication (proving identify) and authorization (assign a role to
the identiy that carries permissions to do things) would be required.

However, other non-read-only parts of the API functionality SHOULD
provide ways for external applications to authenticate before they are
authorized to make calls. The API **SHOULD** support use of OAuth 2.0 ( https://tools.ietf.org/html/rfc6749 )
athentication.

HTTPS
-----
All APIs must not provide HTTP public facing. HTTPS **MUST ONLY** be used in public facing APIs.
This can be implemented directly by the APIs or provided with a reverse proxy.

Resources & References
======================

Referenced resources
--------------------

### Normative

<references group="Standards"/>
### Tools and information items

<references group="Tools"/>
Consulted resources
-------------------

-   <https://biodiversitycatalogue.org/>
-   <http://blog.2partsmagic.com/restful-uri-design/>
-   <http://blogs.plexibus.com/2009/01/15/rest-esting-with-curl/>
-   <http://gbif.org/developer/summary>
-   <https://github.com/wet-boew/wet-boew-api-standards/blob/master/README.md>
-   <http://looah.com/source/view/2284>
-   <http://oracle.com/technetwork/articles/javase/index-137171.html>
-   <http://software.ac.uk/blog/2013-12-04-top-tips-creating-web-services>
-   <http://stackoverflow.com/a/5394127/459050>
-   <http://stackoverflow.com/questions/1443158/binary-data-in-json-string-something-better-than-base64>
-   <https://stackoverflow.com/questions/6324547/how-to-handle-many-to-many-relationships-in-a-restful-api>
-   <http://techblog.appnexus.com/2012/on-restful-api-standards-just-be-cool-11-rules-for-practical-api-development-part-1-of-2/>

[^1]: <https://github.com/wet-boew/wet-boew-api-standards>

[^2]: <http://www.oracle.com/technetwork/articles/javase/index-137171.html>

[^3]: W3C RFC2616 Section 14.1
    (http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.hml\#sec14.1)

[^4]: IANA's media type catalogue
    (http://www.iana.org/assignments/media-types/media-types.xhtml)

[^5]: [schema.org](http://schema.org)

[^6]: [Django REST framework](http://www.django-rest-framework.org)

[^7]: [Apiary](http://apiary.io)

[^8]: 2016-06-27 : supported media-types are  [image/images,video/videos,sound/sounds,attachment/attachments]
[^9]: 2017-06-14 : http://jsonapi.org/format/#document-top-level

[//]: # ( ref not shown)
[JSON Style Guide]: <https://google.github.io/styleguide/jsoncstyleguide.xml> 
