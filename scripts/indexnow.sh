#!/bin/sh
# Tell Bing (and every IndexNow partner) which pages changed. Run after pushing; the key file must be live first.
# Usage: scripts/indexnow.sh https://centralnjurogynecology.com/reviews.html [more urls...]   (no args = every URL in sitemap.xml)
cd "$(dirname "$0")/.."
if [ $# -eq 0 ]; then set -- $(grep -o '<loc>[^<]*</loc>' sitemap.xml | sed 's/<[^>]*>//g'); fi
list=$(printf '"%s",' "$@"); list=${list%,}
curl -s -o /dev/null -w "IndexNow response: %{http_code} (200 or 202 means accepted)\n" -X POST https://api.indexnow.org/indexnow \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"centralnjurogynecology.com\",\"key\":\"56123fbea40a2180c8399faadb4c401d\",\"keyLocation\":\"https://centralnjurogynecology.com/56123fbea40a2180c8399faadb4c401d.txt\",\"urlList\":[$list]}"
