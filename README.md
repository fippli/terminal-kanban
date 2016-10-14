# terminal-todo
Kanban board for the terminal.  

The files todo.txt, doing.txt, and done.txt needs to be created in the root folder.

Good luck.  

## Issues
• There are some problems with the formatting of the output. Especially if å, ä or ö is added. Probably for more special characters.

## Installation
I put this script in a file /usr/local/bin/kanban
```
#!/bin/bash

ORIGIN=${PWD}

cd /<path>/<to>/<folder>/

./kanban.sh

cd ${ORIGIN}
```
Now you kan simply run kanban in the terminal.
