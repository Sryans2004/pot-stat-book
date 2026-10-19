#!/bin/sh
# Usage: ./update.sh /workspace/Official-Stat-Book-vX.Y.html  — rebuilds index.html (adds manifest/icon tags), commits, pushes
set -e; cd "$(dirname "$0")"
python3 - "$1" <<'PY'
import sys;H=open(sys.argv[1],encoding='utf-8').read()
tag='<link rel="manifest" href="manifest.webmanifest"><link rel="apple-touch-icon" href="apple-touch-icon.png"><link rel="icon" type="image/png" sizes="192x192" href="icon-192.png"><meta name="theme-color" content="#0d0f11">'
i=H.index('</head>');open('index.html','w',encoding='utf-8').write(H[:i]+tag+H[i:])
PY
git add -A && git commit -m "Update stat book: $(basename "$1")" && git push origin main
