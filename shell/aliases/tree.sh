tree() { find $1 | sed -e 's;[^/]*/;|__;g;s;__|;  |;g'; }
