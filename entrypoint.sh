#!/bin/sh

set -e

if [ -z "$AUTHCODE" ]; then
  AUTHCODE="$(jq -r '$ENV[.activation_bytes]' /config/audible.json)"
  if [ -z "$AUTHCODE" ]; then
    echo "ERROR: Missing authcode / activation_bytes from audible json. Check README"
    exit 1
  fi
fi

if [ -z "$BOOK_TITLES" ]; then
  echo "Fetching everything from library since BOOK_TITLES was unspecified.."
  yes | audible download --all --aax --cover --cover-size 1215 --chapter --output-dir /data --ignore-errors
else
  echo "Fetching only books matching: ${BOOK_TITLES}"
  yes | audible download -t "${BOOK_TITLES}" --aax --cover --cover-size 1215 --chapter --output-dir /data --ignore-errors
fi

AAX_FILES=(/data/*.aax)
if [[ "$AAX_FILES" == "/data/*.aax" ]]; then
  echo "ERROR: No AAX files found, exiting."
  exit 1
else
  echo "Converting AAX to M4B.."
  AAXtoMP3 --use-audible-cli-data -A ${AUTHCODE} -e:m4b -C /backup -t /storage ${AAX_FILES[*]}
fi