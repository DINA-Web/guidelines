This document
=============

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

DINA REST API standard - Specification
======================================

Basics
------

All DINA-compliant APIs follow basic RESTful practices with regard to
the use of HTTP as a protocol, conventions of mapping HTTP methods to
CRUD operations, structuring URIs to address API endpoints and the
supported request and response formats (JSON, XML).

Endpoint definitions
--------------------

### HTTP methods ###

DINA-compliant APIs **MUST** follow a common usage of HTTP methods. An
agreed mapping of HTTP methods to common CRUD operations ensures a
transparent behaviour. The DINA API standard assumes the mappings listed
in the following sections. To illustrate these mappings the table refers
partly to the ongoing specification of the collections module and partly
to a DINA-compliant media server modules, indicated by the reserved word
(URI path component) ***"media"*** and a data object (media type)
handled by the web service indicated by ***"image"***.

If not noted otherwise it is expected that an endpoint's ***HTTP HEAD*** calls are returning just the meta-data section of the corresponding ***HTTP GET*** call.


#### Basic CRUD operations ####

|HTTP method |Endpoint            |Semantics/Behaviour                                                                                              |Success code   |Fail codes                                            |
|:-----------|:-------------------|:----------------------------------------------------------------------------------------------------------------|:--------------|:-----------------------------------------------------|
|GET         |/media/001196a9-abef-419e-a8b7-f0a00157c588  |Retrieve the media object with the uuid '001196a9-abef-419e-a8b7-f0a00157c588'.                                                           |200 OK         |Various possible ("uuid does not exist": 404 Not Found) |
|POST        |/media/001196a9-abef-419e-a8b7-f0a00157c588  |NA                                                                                                               |NA             |405 Method Not Allowed                                |
|PUT         |/media/001196a9-abef-419e-a8b7-f0a00157c588  |Update the media object with uuid '001196a9-abef-419e-a8b7-f0a00157c588'.                 |200 OK         |Various possible ("uuid does not exist": 404 Not Found) |
|DELETE      |/media/001196a9-abef-419e-a8b7-f0a00157c588  |Delete the media object with uuid '001196a9-abef-419e-a8b7-f0a00157c588'.                                                           |204 No Content |Various possible ("uuid does not exist": 404 Not Found) |
|HEAD        |/media/001196a9-abef-419e-a8b7-f0a00157c588  |Retrieve only meta-data section for corresponding GET request.                                                   |200 OK         |Various possible ("uuid does not exist": 404 Not Found) |
|GET         |/media/images       |Retrieve first page of paged list of all images (id´s or url´s) starting at OFFSET=0 and LIMIT=defaultLimitSize. |200 OK         |Various possible                                      |
|POST        |/media/images       |Create one or more new images.                                                                                              |201 Created    |Various possible                                      |
|PUT         |/media/images       |NA                                                                                                               |NA             |405 Method Not Allowed                                |
|DELETE      |/media/images       |NA                                                                                                               |Na             |405 Method Not Allowed                                |
|HEAD        |/media/images       |Retrieve only meta-data section for corresponding GET request.                                                   |200 OK         |Various possible                                      |
|GET         |/media/images/count |Retrieve the total number of images.                                                                             |200 OK         |Various possible                                      |
|POST        |/media/images/count |NA                                                                                                               |NA             |405 Method Not Allowed                                |
|PUT         |/media/images/count |NA                                                                                                               |NA             |405 Method Not Allowed                                |
|DELETE      |/media/images/count |NA                                                                                                               |NA             |405 Method Not Allowed                                |
|HEAD        |/media/images/count |Retrieve only meta-data section for corresponding GET request.                                                   |200 OK         |Various possible                                      |


#### Filtering, ordering, paging ####

|HTTP method |Endpoint                                                                  |Semantics/Behaviour                                                                                                                                       |Success code |Fail codes                                                                                                                                              |
|:-----------|:-------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------|:------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------|
|GET         |/media/images?minid=1000&maxid=2000                                       |Retrieve first page of paged list of all matching data objects of type image, within id range 1000-2000, starting at OFFSET=0 and LIMIT=defaultLimitSize. |200 OK       |Various possible ("images.id has no values in range 1000-2000": 404 Not Found)                                                                          |
|POST        |/media/images?minid=1000&maxid=2000                                       |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|PUT         |/media/images?minid=1000&maxid=2000                                       |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|DELETE      |/media/images?minid=1000&maxid=2000                                       |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|HEAD        |/media/images?minid=1000&maxid=2000                                       |Retrieve only meta-data section for corresponding GET request.                                                                                            |200 OK       |Various possible ("images.id has no values in range 1000-2000": 404 Not Found)                                                                          |
|GET         |/collectionobjects?orderBy=ProjectNumber,InventoryDate&limit=100&offset=0 |Retrieve the first 100 collectionobjects starting a offset 0, ordered by ProjectNumber,InventoryDate.                                                     |200 OK       |Various possible ("ProjectNumber and/or InventoryDate are not valid fields for collectionobjects": 405 Method Not Allowed; "no records": 404 Not Found) |
|POST        |/collectionobjects?orderBy=ProjectNumber,InventoryDate&limit=100&offset=0 |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|PUT         |/collectionobjects?orderBy=ProjectNumber,InventoryDate&limit=100&offset=0 |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|DELETE      |/collectionobjects?orderBy=ProjectNumber,InventoryDate&limit=100&offset=0 |NA                                                                                                                                                        |NA           |405 Method Not Allowed                                                                                                                                  |
|HEAD        |/collectionobjects?orderBy=ProjectNumber,InventoryDate&limit=100&offset=0 |Retrieve only meta-data section for corresponding GET request.                                                                                            |200 OK       |Various possible ("ProjectNumber and/or InventoryDate are not valid fields for collectionobjects": 405 Method Not Allowed; "no records": 404 Not Found) |



#### Dedicated search endpoint for text searches ####
|HTTP method |Endpoint                        |Semantics/Behaviour                                                                                                                             |Success code |Fail codes                                                                                                      |
|:-----------|:-------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|:------------|:---------------------------------------------------------------------------------------------------------------|
|GET         |/media/images?taxon=Thaumotopea |Retrieve first page of paged list of all matching records, where taxon contains "Thaumotopea", starting at OFFSET=0 and LIMIT=defaultLimitSize. |200 OK       |Various possible ("taxon is not a valid field for images": 405 Method Not Allowed; "no records": 404 Not Found) |
|POST        |/media/images?taxon=Thaumotopea |NA                                                                                                                                              |NA           |405 Method Not Allowed                                                                                          |
|PUT         |/media/images?taxon=Thaumotopea |NA                                                                                                                                              |NA           |405 Method Not Allowed                                                                                          |
|DELETE      |/media/images?taxon=Thaumotopea |NA                                                                                                                                              |NA           |405 Method Not Allowed                                                                                          |
|HEAD        |/media/images?taxon=Thaumotopea |Retrieve only meta-data section for corresponding GET request.                                                                                  |200 OK       |Various possible ("taxon is not a valid field for images": 405 Method Not Allowed; "no records": 404 Not Found) |




#### Relations / one-to-many ####
Reference for relational RESTful services:
<https://stackoverflow.com/questions/6324547/how-to-handle-many-to-many-relationships-in-a-restful-api>

|HTTP method |Endpoint                                   |Semantics/Behaviour                                                                                                                                                                                                                                                                                          |Success code   |Fail codes                                                                                                                                                                                     |
|:-----------|:------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|GET         |/collectionobjects/:id/determinations/     |Retrieve first page of paged list of all determinations associated with the given collectionobject id, starting at OFFSET=0 and LIMIT=defaultLimitSize                                                                                                                                                       |200 OK         |Various possible ("id does not exist": 404 Not Found)                                                                                                                                          |
|POST        |/collectionobjects/:id/determinations/     |Associating a determination with a collectionobjects should be done during the creation of the determination, i.e. POST /determinations, with the foreign key of the collectionobjects contained in the POST json OR if the entity already exists, with the below /collectionobjects/:id/determinations/:id2 |NA             |405 Method Not Allowed                                                                                                                                                                         |
|PUT         |/collectionobjects/:id/determinations/     |NA                                                                                                                                                                                                                                                                                                           |NA             |405 Method Not Allowed                                                                                                                                                                         |
|DELETE      |/collectionobjects/:id/determinations/     |NA                                                                                                                                                                                                                                                                                                           |NA             |405 Method Not Allowed                                                                                                                                                                         |
|HEAD        |/collectionobjects/:id/determinations/     |Retrieve only meta-data section for corresponding GET request.                                                                                                                                                                                                                                               |200 OK         |Various possible ("id does not exist": 404 Not Found)                                                                                                                                          |
|GET         |/collectionobjects/:id/determinations/:id2 |Retrieve determination with id=id2 that is also a member of collectionobjects=id                                                                                                                                                                                                                             |200 OK         |Various possible ("id/id2 does not exist", "id2 is not member of collection id": 404 Not Found)                                                                                                |
|POST        |/collectionobjects/:id/determinations/:id2 |Create a new association between the determination=id2 and the given collectionobject=id                                                                                                                                                                                                                     |201 Created    |Various possible ("id/id2 does not exist", "id2 is not member of collection id": 404 Not Found; "determination does not have 1:n relationship with collection object": 405 Method Not Allowed) |
|PUT         |/collectionobjects/:id/determinations/:id2 |Update association.                                                                                                                                                                                                                                                                                          |201 Created    |Various possible ("id/id2 does not exist", "id2 is not member of collection id": 404 Not Found; "determination does not have 1:n relationship with collection object": 405 Method Not Allowed) |
|DELETE      |/collectionobjects/:id/determinations/:id2 |Delete association.                                                                                                                                                                                                                                                                                          |204 No Content |Various possible ("id/id2 does not exist", "id2 is not member of collection id": 404 Not Found; "determination does not have 1:n relationship with collection object": 405 Method Not Allowed) |
|HEAD        |/collectionobjects/:id/determinations/:id2 |Retrieve only meta-data section for corresponding GET request.                                                                                                                                                                                                                                               |200 OK         |Various possible ("id/id2 does not exist", "id2 is not member of collection id": 404 Not Found)                                                                                                |



#### Relations / many-to-many ####

|HTTP method |Endpoint                             |Semantics/Behaviour                                                                                                                              |Success code   |Fail codes                                                                                                                                          |
|:-----------|:------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------|:--------------|:---------------------------------------------------------------------------------------------------------------------------------------------------|
|GET         |/projects/:id/collectionobjects/     |Retrieve first page of paged list of all collectionobjects associated with the given project id, starting at OFFSET=0 and LIMIT=defaultLimitSize |200 OK         |Various possible ("id does not exist": 404 Not Found; "collectionobject does not have n:n relationship with project": 405 Method Not Allowed)       |
|POST        |/projects/:id/collectionobjects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|PUT         |/projects/:id/collectionobjects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|DELETE      |/projects/:id/collectionobjects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|HEAD        |/projects/:id/collectionobjects/     |Retrieve only meta-data section for corresponding GET request.                                                                                   |200 OK         |Various possible ("id does not exist": 404 Not Found; "collectionobject does not have n:n relationship with project": 405 Method Not Allowed)       |
|GET         |/collectionobjects/:id/projects/     |Retrieve first page of paged list of all projects associated with the given collectionobject id starting at OFFSET=0 and LIMIT=defaultLimitSize  |200 OK         |Various possible ("id does not exist": 404 Not Found; "projects does not have n:n relationship with collectionobject": 405 Method Not Allowed)      |
|POST        |/collectionobjects/:id/projects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|PUT         |/collectionobjects/:id/projects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|DELETE      |/collectionobjects/:id/projects/     |NA                                                                                                                                               |NA             |405 Method Not Allowed                                                                                                                              |
|HEAD        |/collectionobjects/:id/projects/     |Retrieve only meta-data section for corresponding GET request.                                                                                   |200 OK         |Various possible ("id does not exist": 404 Not Found; "projects does not have n:n relationship with collectionobject": 405 Method Not Allowed)      |
|GET         |/projects/:id/collectionobjects/:id2 |Retrieve collectionobject with id2 which is a member of project with id.                                                                         |200 OK         |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|POST        |/projects/:id/collectionobjects/:id2 |Create a relation between the given project id and a collectionobject id2.                                                                       |201 Created    |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|PUT         |/projects/:id/collectionobjects/:id2 |Replace the association between the project and the collectionobject.                                                                            |200 OK         |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|DELETE      |/projects/:id/collectionobjects/:id2 |Delete the association between the project and the collectionobject.                                                                             |204 No Content |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|HEAD        |/projects/:id/collectionobjects/:id2 |Retrieve only meta-data section for corresponding GET request.                                                                                   |200 OK         |Various possible ("id does not exist": 404 Not Found; "projects does not have n:n relationship with collectionobject": 405 Method Not Allowed)      |
|GET         |/collectionobjects/:id/projects/:id2 |Retrieve project with id2 which is a member of collectionobjects with id.                                                                        |200 OK         |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|POST        |/collectionobjects/:id/projects/:id2 |Create a relation between the given collectionsobject id and a projects id2.                                                                     |201 Created    |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|PUT         |/collectionobjects/:id/projects/:id2 |Replace the association between the project and the collectionobject.                                                                            |200 OK         |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|DELETE      |/collectionobjects/:id/projects/:id2 |Delete the association between the project and the collectionobject.                                                                             |204 No Content |Various possible ("id/id2 does not exist": 404 Not Found; "collectionobjects does not have n:n relationship with projects": 405 Method Not Allowed) |
|HEAD        |/collectionobjects/:id/projects/:id2 |Retrieve only meta-data section for corresponding GET request.                                                                                   |200 OK         |Various possible ("id does not exist": 404 Not Found; "projects does not have n:n relationship with collectionobject": 405 Method Not Allowed)      |


Similar examples can be found in
<https://github.com/wet-boew/wet-boew-api-standards>[^1] or
<http://www.oracle.com/technetwork/articles/javase/index-137171.html>[^2].

### HTTP header use

DINA-compliant web APIs **MUST** support at least the variables
indicating the requested an support media types. For HTTP requests this
is ***Accept:*** (e.g. *Accept: application/json*) and for HTTP response
this is ***Content-Type:*** (e.g. *Content-Type: application/json*). The
Accept: header is described by W3C RFC2616 Section 14.1
(<http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.hml\#sec14.1>[^3]).

The supported and indicated media types must be recognized *Multipurpose
Internet Mail Extensions (MIME) types* registered with the Internet
Assigned Numbers Authority (IANA)'s media type catalogue. For most
standard file types IANA's media type catalogue
(<http://www.iana.org/assignments/media-types/media-types.xhtml>[^4])
will provide the appropriate type definition.

### URI structure

#### Basics

DINA-compliant APIs **SHOULD** indicate base URLs for API endpoints with
an "api" subdomain, thus *<http://api.dinamodule.net/>* would be
considered preferable over *<http://www.dinamodule.net/api/>* under this
scheme.

DINA-compliant APIs **MUST** include a version indicator that is
appended directly to the endpoint base URI, e.g.
*<http://api.dinamodule.net/v1>* (see also the section on versioning
schemes).

Multiple URL schemes **COULD** be supported by using
rewrite/redirect/proxy directives. Example scenarios: 1) Each module is
hosted at a unique domain, e.g. "<http://api.dinamodule.net/version/>"
and 2) Modules are consolidated and provided via a single domain, e.g.
"<http://api.host/module/version>". Both of these scenarios can be
accomplished using rewrite/redirect/proxy directives from an original
URL of
"[http://localhost:port/module/version](http://localhost:port/module/version)".

All date time formats **MUST** conform to the subset of ISO 8601 defined in
<http://www.w3.org/TR/NOTE-datetime> and <http://schema.org/DateTime>.

#### Passing parameters

DINA-compliant APIs **MUST** accept parameters as key-value pairs
following standard URI patterns, e.g.
*<http://api.dinamodule.net/v1/media/image/search?id=1234>*.

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
    -   ...

-   Reserved words indicating data concepts:
    -   "specimen" and/or "object"
    -   "taxon"
    -   "organisation" and/or "institution"
    -   "event"
    -   "locality"
    -   "method" and/or "measurement"
    -   "agent"
    -   "person"
    -   "user"
    -   "annotation"
    -   ...

In general, both singular and plural versions of those terms should be considered as reserved words, and terms should always be used in lowercase.


### HTTP response

HTTP responses returned by DINA-compliant API endpoints **MUST** be
returned as valid JSON documents and follow a standard response
structure. In addition, DINA-compliant API endpoints SHOULD
alternatively return responses as valid XML documents. The basic
structure of a DINA API compliant JSON reponse is listed below:

<pre>
    {
       "meta": {
          "callEndpoint": "http://api.refimplementation.net/v1/media/...",
          "callDate": "2014-10-08T08:08:18+01:00",
          "apiVersion: "1.0",
          ...
       }

       "results": [
          ... module-specific data ...
       ] 
    }
</pre>

HTTP responses in JSON format **MUST** satisfy the property name
guidelines from the Google [JSON Style Guide]: ,
to ensure for example that JSON results do not have unique ids as
property names of the marshalled object. Similarly, these principles
**SHOULD** apply to XML reponses. Examples for valid and invalid
responses under this scheme are given in the following table.


<table border="5">
<tr>
<th>VALID</th>
<th>INVALID</th>
</tr>

<tr>
<td>
<pre>
{"taxa":
     {"taxid":460932,
      "taxon":"Aspergillus ochraceus"}
}
</pre>

</td>
<td>
<pre>
{"460932":
     {"taxid":460932,
      "taxon":"Aspergillus ochraceus"}
}
</pre>
</td>
</tr>

<tr>
<td>
<pre>
&lt;resultset&gt;
    &lt;row id="1"&gt; ... &lt;/row&gt;
    &lt;row id="2"&gt; ... &lt;/row&gt;
    &lt;row id="3"&gt; ... &lt;/row&gt;
&lt;/resultset>
</pre> 
</td>

<td>
<pre>
&lt;resultset>
    &lt;row_1&gt; ... &lt;/row_1&gt;
    &lt;row_2&gt; ... &lt;/row_2&gt;
    &lt;row_3&gt; ... &lt;/row_3&gt;
&lt;/resultset>
</pre>
</td>
</tr>

</table>  



API response "metadata"
-----------------------

A DINA-compliant endpoint **MUST** return the following properties in
the response meta section:

|Property | Datatype | Description |
|----|----|----|
| callEndpoint    |     URL |       The complete URL of the endpoint that issued this reponse.|
| next    |     URL |       The complete URL of the endpoint for the next page of content. Only for paging.|
| previous    |     URL |       The complete URL of the endpoint for the previous page of content. Only for paging.|
| limit          |      int  |      The value of the limit (paging) parameter provided by the caller of the endpoint.|
| offset        |       long  |      The value of the offset (paging) parameter provided by the caller of the endpoint.|
| callDate      |       string  |      Datetime at which the call to the endpoint was received. http://schema.org/DateTime. Format as per http://www.w3.org/TR/NOTE-datetime|
| statusCode     |      int  |      HTTP response code issued by the endpoint.|
| apiVersion     |      string  |      Version identifier of the endpoint API.|
| resultCount    |      long  |      Count of the result objects returned by the call to this endpoint.|
| orderBy     |      array of string  |      Result object properties  on which the returned result set is sorted.|
| sortOrder      |      string  |      Sort order of the result set. "asc" or "desc".|
| resultLanguages|      array of string  |      Languages of the result content - if applicable.|
| supportedLanguages |  array of string  |      Supported content languages of the endpoint - if applicable.|
| contentLicenses    |  array of string  |      Licenses applying to the results returned by the endpoint - - if applicable.|
| message            |  string  |      General message explaining the response - if any.|
| maintenanceContact |  string  |      Links to services and contacts that provide information and support in case of service |disruptions.
| ...                |  ...  |      ...|


A compliant sample response in JSON format:

<pre>
    {
       "meta": {
          "callEndpoint": "http://api.refimplementation.net/v1/media/...",
          "next": "http://api.refimplementation.net/v1/media/...?offset=150&limit=50",
          "previous": "http://api.refimplementation.net/v1/media/...?offset=50&limit=50",
          "limit": 50,
	        "callDate": "2015-11-05T08:15:30-05:00",
          "offset": 100,
          "apiVersion: "1.0",
          "statusCode": 200,
          "results": 18,
          "orderBy": [
	  	     "ID",
		     "InventoryDate"
          ],
          "sortOrder": "asc",
          "resultLanguages": [
              "SE_sv",
              "GB_en"
          ],
          "supportedLanguages": [
              "SE_sv",
              "GB_en",
              "EE_et"          
          ]
          "contentLicenses": [
          ],
          "message": "",
          "maintenanceContact": "admin@dina-system.org"
          ...
       }

       ... "data" ...
    }
</pre>

Generic operations
------------------

### Paging

All DINA-compliant APIs **MUST** provide support paging for large result
sets, accepting the following parameters:

|URI term   | Parameter  | Default   |  Description |
|:----------|:-----------|:----------|:-------------------|
|**[ANY]**  |limit       |100        | The maximum number of items in the returned result set.|
|**[ANY]**  | offset     | -         |  Determines the offset of items in a result set and thus provides an implicit paging mechanism.|

### Count

All API calls that result in a list of records (paged of course) must
also support a "**'/count**' that returns the number of results if the
API had been called. Note that this is also applied to URLs with passed
parameters, i.e.

    /media/images?taxon=Thaumotopea

Retrieves paged list of matching records.

    /media/images/count?taxon=Thaumotopea

Retrieves the number of results if the search was directly called.

    /media/images

Retrieves paged list of all images.

    /media/images/count

Retrieves the total number of images.

### Supported languages

All DINA-compliant APIs **SHOULD** provide a generic operation to
request languages supported by the service. Support for this request
**MUST** be implemented with a non-parameterised GET request using the
reserved word **languages** as the last element of the endpoint URI.

|URI term |  Parameter  | Description |
|:--------|:-----------|:-----------|:---------------|
|**GET/languages** |-       |Requests a list of all languages supported by the service, returned as a meta-data object in the standard response format. By default supported languages should be included in the meta-data section of API responses. This call should support retrieval of supported languages **only**.|

Sample reponse:
<pre>
    {
       "meta": {
          "callEndpoint": "http://api.refimplementation.net/v1/media/languages",
          "callDate": "2014-10-08T08:08:18+01:00",
          "apiVersion: "1.0",
          "results": 0,
          "supportedLanguages": [
              "SE_sv",
              "GB_en",
              "EE_et"          
          ]
          ...
       }
    }
</pre>


Documentation
-------------

-   Each DINA compliant Web REST API **MUST** provide complete English
    documentation of the supported methods. For each method the
    documentation **MUST** provide curl examples to document the usage.
    For example (illustrative):



```bash
curl --request POST  \\
  --header "Accept: application/json" \\
  --header "Content-Type: application/json; charset=UTF-8" \\
  -data '{"meta": {"owner":"Laxness", "access":"public", \\
  "licenseType":"CC BY", "legend":"en skata", \\
  "legendLanguage":"sv_SE", "tags":"view:left"}, \\
  "data":{"fileName": "pica-pica-flying.jpg", \\
  "fileContentTransferEncoding": "base64_RFC4648", \\
  "image":"Tm8gRGlzY291cnNlIHdoYXRzb2V2ZXIsIGNhbiBFbmQgaW4gYWJzb2x1dGUgS25vd2xlZGdlIG9mIEZhY3QuCg=="}}' \\
  http://refimplementation.mediaserver.net/v1/media/create
```

Here is the above JSON in the POST body formatted a little better (this is just an example of what we might want in the REQUEST JSON):

```bash
{  
   "meta":{  
      "owner":"Laxness",
      "access":"public",
      "licenseType":"CC BY",
      "legend":"en skata",
      "legendLanguage":"sv_SE",
      "tags":"view:left"
   },
   "data":{  
      "fileName":"pica-pica-flying.jpg",
      "fileContentTransferEncoding":"base64_RFC4648",
      "image":"Tm8gRGlzY291cnNlIHdoYXRzb2V2ZXIsIGNhbiBFbmQgaW4gYWJzb2x1dGUgS25vd2xlZGdlIG9mIEZhY3QuCg=="
   }
}

```

References:  
- http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#json-requests  
- http://stackoverflow.com/questions/4083702/posting-a-file-and-data-to-restful-webservice-as-json  
- https://developer.atlassian.com/display/CROWDDEV/JSON+Requests+and+Responses  

Response if HTTP '200 OK': provides identifier <UUID> for instance, in this case 6853e82-6cad-430b-b582-90e85203dce8, so retrieval can be tested with:
 
```bash
# use pattern: curl http://refimplementation.mediaserver.net/v1/media/metadata/<UUID>
curl http://refimplementation.mediaserver.net/v1/media/metadata/46853e82-6cad-430b-b582-90e85203dce8
```

-   In addition to the required basic API documentation, DINA compliant
    REST API **SHOULD** provide self-documentation capabilities for each
    endpoint similar to the example provided by e.g. the [Django REST
    framework](http://www.django-rest-framework.org)[^6] or
    [Apiary](http://apiary.io)[^7]
    
-   The documentation for the API **COULD** refer to an online reference
    implementation in the curl examples (rather than to localhost)

Versioning
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
authorized to make calls. The API SHOULD support use of OAuth
athentication.

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

[//]: # ( ref not shown)
[JSON Style Guide]: <https://google.github.io/styleguide/jsoncstyleguide.xml> 
