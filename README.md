# commify
An AppleScript that transforms a column of text items into a comma-separated list of text items

1<br>
2<br>
3<br>
4<br>
=> 1, 2, 3, 4

## Installation
Download the file commify.applescript to your Mac and open it with the application Script Editor, which is preinstalled on all Macs.

Then export the script as an App. This will give you an executable AppleScript. Put it where you can easily access it (e.g. Script menu or the dock).

![](http://www.schoolscout24.de/img/commify/commify_script.png)

## Usage
Copy a column of text items to your clipboard. Then start the commify Applescript and choose your settings.

![](http://www.schoolscout24.de/img/commify/commify_menu.png)

After the script is done with its work it will have replaced the contents of the clipboard with the expected result.

To enhance the user experience commify remembers

* your last choice regarding quotes
* your last custom set of quotes and separators

## Custom quotes and separator
If you want to use your set of quote characters and separator/delimiter, commify also allows for that:

![](http://www.schoolscout24.de/img/commify/commify_custom.png)

![](http://www.schoolscout24.de/img/commify/commify_set.png)


## Video
This is a short screen recording about how to use commify:

[![Screen recording](http://www.schoolscout24.de/img/commify/commify_video_icon.png)](http://www.schoolscout24.de/img/commify/commify_video.mov)

## Why commify was written
As a data analyst I often need to transform columns of text or numbers from an Excel document or a database tool like DBeaver into a list of quoted, comma-separated list of items for Python.

And while working from home with my beloved Mac I remembered my love for helpful AppleScripts and wrote it to automate this tedious task.

