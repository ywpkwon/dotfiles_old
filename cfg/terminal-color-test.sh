#!/bin/sh

echo ''
echo '--- 256 color test ---'

curl -s https://gist.githubusercontent.com/lifepillar/d4acaf918ae8d9bb2cab24d62abd768c/raw/a38d1e6a5500708d1f6318660f47b7702f53e009/256-colors.pl | perl
curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
url -s -L https://git.gnome.org/browse/vte/plain/perf/256test.sh?h=vte-0-38 | bash

echo ''
echo '--- True color test ---'

awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'