Some simple scripts for managing manga downloaded via tachiyomi.

Step one you need bluestacks for tachiyomi on windows. Afaik there's really nothing else as slick to go grab anything you want. Set the downloads folder in tachiyomi to windows documents or pictures. 

Then you need ubuntu sub system for windows

Install your dependencies:
```
sudo apt install -y imagemagick img2pdf
```

Now cd over to the folder that has your downloads (windows drives under /mnt) and place these files in the base dir that you download your manga to

Managadex has about the worst naming scheme. chaptersort.sh will rename all your folders to a reasonable `ch.[0-9]*`. There's an artifact that happens sometimes that will put a folder, in a folder maybe. The downloads might be screwed up from mangadex. In any case, it wont hurt anything. 

From here pdfify.sh will turn all the directorys into pdfs which you can put on a kindle etc. 