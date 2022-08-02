#!/usr/bin/env bash
set -e

if [ -f /ksynth.lock ]; then
    rm -f /ksynth.lock
fi

[ -z "$COMPANY_ID" ] && echo "Company ID not setting" || echo "Company ID ok: $COMPANY_ID"
[ -z "$PROBE_NAME" ] && echo "Probe name not setting" || echo "Probe name ok: $PROBE_NAME"
if [ -z "$KSYNTH_ID" ]; then
    ksynth-agent --company-id "${COMPANY_ID}" --name "${PROBE_NAME}" --browser-path /usr/bin/chromium
    echo "Save KSYNTH_ID: $(cat /ksynth.id)"
    exit 0
else
    echo "KSYNTH_ID ok: $KSYNTH_ID"
    echo "$KSYNTH_ID" > /ksynth.id
fi

ksynth-agent --company-id "${COMPANY_ID}" --name "${PROBE_NAME}" --browser-path /usr/bin/chromium