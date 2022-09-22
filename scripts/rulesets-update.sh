#!/bin/bash 

## http://www.metagenomics.wiki/tools/ubuntu-linux/shell-loop

for filename in "$GITHUB_WORKSPACE"/*.json; do
	[ -e "$filename" ] || continue
	echo "sending... $(basename "${filename%.*}")"

	curl -XPUT \
	-H 'Authorization: Token '"${ZTL_API_TOKEN}"'' \
	-H 'Content-Type: application/x-osquery-conf' \
	-d @"$GITHUB_WORKSPACE"/"${filename##*/}" \
	https://"${ZTL_FQDN}"/api/osquery/packs/"$(basename "${filename%.*}")"/ \
	| python -m json.tool
done