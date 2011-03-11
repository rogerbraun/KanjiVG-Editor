# KanjiVG Editor

## About
This is a simple Sinatra app that makes it easy to keep your own git repository of the KanjiVG[^1] data. It will manage git-related tasks like cloning and commiting for you, you just edit the data and hit submit.

## Who needs this?
This was written mainly for Ulrich Apel[^2] so he can have his own git repository of his data without having to learn git.

## How to use
Start the server with "ruby app.rb". This will take a while, especially the first time you start it, as it will clone the KanjiVG data if it does not find it in the local folder. Go to "http://localhost:4567" and click on the character you want to edit. It will show you the SVG and XML representation of the character. Edit what you want, add a commit message and hit submit. That's it!

## How to install
You will need to have Ruby, Sinatra and Git installed on your system. If you want to change the directory your local repo will be living in, adjust it in config.rb. You will probably want to change the author, too.

## Author
This programm is maintained by Roger Braun (http://rbraun.net) and can be found at https://github.com/rogerbraun/KanjiVG-Editor

[^1]: http://gitorious.org/kanjivg
[^2]: The original author of KanjiVG
