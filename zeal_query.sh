docset=$1
query=$2
sqlite3 -separator ';' $HOME/.local/share/Zeal/Zeal/docsets/$docset.docset/Contents/Resources/docSet.dsidx "SELECT name, path FROM searchIndex WHERE name LIKE '%$2%';"
