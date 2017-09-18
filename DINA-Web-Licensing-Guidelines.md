DINA-Web licensing guidelines for code and data
===============================================

This is a first draft outline for a document outlining guidelines for recommended licenses to use for source code and content originating from the DINA Consortium.

Summary
-------

For code, choose a well-known and widely used open source license - we suggeset either Affero GPL, MIT or Apache license and then add a LICENSE file to your project’s root directory with the license text.

For data or content, use an appropriate Creative Commons v 4 license or in the case of data in the public domain, use the CC0 license.

Contributions to the project (either code or data) do not require transfer of copyright ownership.

Source code licenses
--------------------

To simplify sharing and collaboration within the DINA consortium we require an OSS license to be applied. Choosing an open source software license does not need to be scary. Here is an excellent resource to guide when choosing what license to use: <http://choosealicense.com/>, use it to choose an open source license, preferably one of the bigger and more well-known and frequently used ones:

-   [Affero GPL license](http://choosealicense.com/licenses/agpl-3.0/) - this is a GNU Public License (the most widely used free software license) v 3 type license, which requires users to become contributors and share their improvements back to the community. It covers also web applications, applications “used over a network”, thus closing the so called “Application Service Provider loophole” of GPL v 2.
-   [MIT license](http://choosealicense.com/licenses/mit/) - simple and permissive, provides attribution and users cannot hold you liable
-   [Apache license](http://choosealicense.com/licenses/apache-2.0/) - permissive, similar to MIT but contributors expressly provide users with patent right grants

Using the license in a project
------------------------------

Copy the license text into a file LICENSE and place it in the root directory of your software project. This is the minimum requirement. This LICENSE file should contain the full license text. That way someone with a copy of the project doesn’t need to go online to get all the details.

In many open source software projects there is a tendency to “overcomply” and adding license text more or less everywhere in all files. Is this necessary or adviseable?

> Do have to inject license text in every file of the project?

According to [a source called toxalot in a Stack Overflow post](https://stackoverflow.com/questions/845895/putting-license-in-each-code-file) it is not strictly required to “inject” the license text into all files of a project. The argument being made against “overcomplying” is that such practice disturbs readability (because it requires that you always scroll down paste 2 pages of license text until you can find the actual code) and adds unnecessary bulk and size to the codebase, along with maintainability problems should you need to change the license later.

If you still want to make sure that the license information does not get separated from the files, a slightly less annoying but still fully compliant way is to add a short section at the top of the file containing a copyright statement and a link to the full license, like so:

    // Copyright (c) 2015 Author/Creator Here 
    // License: GNU Affero General Public License version 3
    // Full text in LICENSE (https://www.gnu.org/licenses/agpl.txt)

Even if that source file gets separated it is still very clear about what license was used.

Attribution
-----------

Add a text file AUTHORS with details about creators.

Licenses for Content and Data
-----------------------------

Creative Commons does not recommend the use of Creative Commons licenses for software. 

For content, such as images or databases, the recommendation is to use Creative Commons v. 4 licenses.

If the content or data is in the public domain, use CC0 otherwise choose the appropriate Creative Commons license combo [from here](https://creativecommons.org/licenses/)

Using the licenses

To display what license applies to the content or data, the recommendation is to use icons from <https://cc-icons.github.io>
