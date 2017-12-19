#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR=$(cd $(dirname $0); pwd)

readonly TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" 0

readonly URL="http://www.geocities.co.jp/Playtown-Bingo/8587/download/050330wa.zip"
readonly FILENAME="050330wa"
readonly WORK_DIR="${TEMP_DIR}/${FILENAME}"

wget -q -O "${WORK_DIR}.zip" "${URL}"
unzip -q -U "${WORK_DIR}.zip" -d "${WORK_DIR}"

readonly INODE=$(ls -i "${WORK_DIR}" | awk '{print $1}')
readonly PROGRAM_DIR=$(find "${WORK_DIR}" -maxdepth 1 -type d -inum ${INODE})

rsync -a -v --include="*.gif" \
            --include="*.jpg" \
            --include="*.png" \
            --include="*.mid" \
            --include="*/" \
            --exclude="*" \
            --exclude=".*" \
            "${PROGRAM_DIR}/watlas/" "${SCRIPT_DIR}/watlas"

echo "Merge complete!"
