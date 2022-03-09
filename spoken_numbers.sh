# Simple spoken numbers generator

echo $(shuf -i 0-9 -r -n 80) | espeak -s 175 -g 100
