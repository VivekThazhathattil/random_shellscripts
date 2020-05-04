#!/bin/bash
convert response.png -crop 794x990 +repage page%03d.png
convert -density 144 page*png result.pdf
