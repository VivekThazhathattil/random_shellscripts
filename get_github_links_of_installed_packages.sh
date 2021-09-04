# retrieves the github links of all installed packages in my arch linux

#!/bin/bash
pacman -Qeti | grep --only-matching -i "https*://w*\.*github[^ ]*" | uniq -
