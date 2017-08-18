## Guidelines for a consistent DINA user interface

The goal of these guidelines is to help to create a uniform set of DINA modules, regardless of origin or techniques for implementation.

It can be used in various settings, such as:

*   web applications on both desktop and mobile devices
*   printed publications
*   console applications
*   documentation

## Requirements for visual elements

To work well, some requirements have been identified for the DINA visual style. With those requirements, as suggested below, documents on the web (html etc such as this document), web slides (using ioslides etc) and desktop slides (using ppt, libre office impress etc) as well as other documents (word, libre office etc) can be created in exactly the same style regardless of underlying OS, with no license fees or costs required.

### Accessibility

An important aspect is that the style or “graphical profile” should support good accessibility, in particular for web content, and therefore web content should conform as much as possible with the [W3C guidelines for web content accessibility](http://www.w3.org/TR/WCAG20/).

### Fonts

*   A serif, a sans serif and a fixed width “console font” should be part of the style. Those three types of fonts should harmonize.
*   Web fonts and TTF versions should exist (or be possible to create) for use on Windows, Linux, Mac providing same appearance regardless of OS used
*   For font used a free, libre and open source license is required

An example of a set of fonts that would fullfil these requirements are these fonts selected from the Google Web Fonts:

*   [Source Sans Pro](http://www.google.com/fonts/specimen/Source+Sans+Pro)  

*   [Source Serif Pro](http://www.google.com/fonts/specimen/Source+Serif+Pro)  

*   [Source Code Pro](http://www.google.com/fonts/specimen/Source+Code+Pro)

The license that applies for these fonts: [http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

There is also Google Noto with great support across cultures/languages, probably better than the “Source” fonts, but it is available in sans serif only and therefore not available across the three main font styles: serif/sans-serif/fixed styles. A great candidate for web apps / across digital devices including mobiles but not perhaps equally good transmedially, ie across all media (printed matter, console apps etc).

### Color schemes

It is very easy to get colors wrong. It is perhaps more important to avoid the worst pitfalls than aiming at acheiving perfection.

Very good guidance when choosing colors that can be perceived clearly is provided by tools like [ColorBrewer 2](http://colorbrewer2.org).

*   For colors used, a harmonized and clearly perceivable selection of colors is required
*   No more than 7 steps and never more than 2 hues (if multihued) may be used
*   Aim for colorblind safe choices

With these requirements, the colors used in the DINA style will be guaranteed to be clearly perceived by most audiences across most media.

An example of a color profile that meets the above criteria is the following:

<font color="#ffffcc">█</font> <font color="#d9f0a3">█</font> <font color="#addd8e">█</font> <font color="#78c679">█</font> <font color="#41ab5d">█</font> <font color="#238443">█</font> <font color="#005a32">█</font>

Source: [http://colorbrewer2.org/](http://colorbrewer2.org/) (colorscheme with 7 steps, 2-color multihued yellow-green scale, colorblind safe)

A simple way to check that colors used make sense and can be distinguished is to convert to gray scale and check if different colors still can be discerned. A quick such test can ensure that you are in compliance with this guideline from W3C: [http://www.w3.org/TR/WCAG20/#visual-audio-contrast-without-color](http://www.w3.org/TR/WCAG20/#visual-audio-contrast-without-color)

For a more detailed check, tools like [Vischeck](http://www.vischeck.com/vischeck/) can be used to simulate how various kinds of color-blindness would affect perceptions of colors used in an image.

### Logo

For logo, use the assets at [https://github.com/DINA-Web/dina_logo](https://github.com/DINA-Web/dina_logo).

TODO: add license that applies TODO: add information about font used

### Stylesheets for web applications

For cross-device responsive web user interfaces, a clean, simple responsive stylesheet along the lines of Twitter Boostrap v 3 would be useful to be able to achive the same look and feel on an Android / iPhone / Ubuntu Touch mobile app as on a Linux / Mac / Win web browser.

For example, we could be using `MIT-licensed BootsWatch themes`… - compatible with SASS, LESS, CSS and perhaps initially simply just converging on using the [“Spacelab theme”](http://bootswatch.com/spacelab/) for starters. Note that this particular markdown document uses this “Spacelab” theme, when rendered to HTML.

With some more effort, **a customized “DINA UI Theme” could be created** that complies with `bootswatch` and that use the above color and font requirements.

### CLI tools

We could recommend that VMs or other DINA components available through the CLI signal style though using a a banner like this. For CLI applications that for example migrate data or other tools, it should be perhaps be possible to get rid of the banner with a switch, to silence it. For example:

    # Deps: www.figlet.org / sudo apt-get install figlet / R
    base <- "http://www.figlet.org/fonts/"
    flf <- "small.flf"
    if (!file.exists(flf)) 
      download.file(url = paste0(base, flf), destfile = flf)
    cli_logo <- system("echo 'DINA' | figlet -f small", intern = TRUE)
    banner <- paste0("<pre>CLI banner:\n", paste(collapse = "\n", cli_logo), "</pre>")
    cat(banner)

<pre>CLI banner:
 ___ ___ _  _   _   
|   \_ _| \| | /_\  
| |) | || .` |/ _ \ 
|___/___|_|\_/_/ \_\
                    </pre>


