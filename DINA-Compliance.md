Definition of DINA-Compliant module (DRAFT):

# Document conventions

This document outlines requirements and recommendations for a module to be DINA-Compliant in the context of the DINA project. The following conventions are applied to distinguish between mandatory and optional features of DINA-compliant web APIs:

-   **MUST** -  the usage of this term indicates features of the standard that any implementation is required to fullfill in order to be considered DINA-compliant.
-   **SHOULD** - indicates optional features that are highly recommended for implementation, but are not required; if these features are implemented they MUST follow the recommendations outlined in the standard.
-   **COULD** -  indicates optional features that are considered beneficial for the module, but are not required; if these features are implemented they MUST follow the recommendations outlined in the standard.


* Follows DINA guidelines (to be reviewed)
* The module MUST Contains API contract (as form a [JSON Schema 0.7](https://json-schema.org/))
*	The module MUST Exposes an API following [JSON API Specification](https://jsonapi.org/)
* Themodule MUST contains a README (with rich and relevant content)
* The module SHOULD not be tailored for a specific institution (in the sense it could be reused by another institution)
*	The module SHOULD support authentication through [Keycloak](https://www.keycloak.org/)
*	The module MUST have the approval from at least 1 member of all voting members
*	The module licensing MUST enable complete reuse (MIT strongly suggested)
*	Tracking COULD be done in GitHub issues
    * Submit an issue to suggest a module
    * Discussions
    *	Approve/Reject
