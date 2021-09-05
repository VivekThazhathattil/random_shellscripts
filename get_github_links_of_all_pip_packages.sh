#!/bin/bash
pip list | grep --only-matching "^\S\+" | tail -n +3 | xargs pip show | grep --only-matching -i "https*://w*\.*github[^ ]*" | uniq -
