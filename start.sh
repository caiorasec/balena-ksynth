#!/usr/bin/env bash
set -e

if [ -f /ksynth.lock ]; then
    rm -f /ksynth.lock
fi

[ -z "$COMPANY_ID" ] && echo "Company ID not setting" || echo "Company ID ok: $COMPANY_ID"
[ -z "$PROBE_NAME" ] && echo "Probe name not setting" || echo "Probe name ok: $PROBE_NAME"
if [ -z "$KSYNTH_KEY" ]; then
    ksynth-agent --company-id "${COMPANY_ID}" --name "${PROBE_NAME}" --browser-path /usr/bin/chromium &
    sleep 10
    while :; do
        if [ -f /ksynth.id ]; then
            echo "Save the key in balena's device variable KSYNTH_KEY: $(cat /ksynth.id)"
        fi
        sleep 4
    done
else
    echo "Variable KSYNTH_KEY is OK: $KSYNTH_KEY"
    echo "$KSYNTH_KEY" > /ksynth.id
    ksynth-agent --company-id "${COMPANY_ID}" --name "${PROBE_NAME}" --browser-path /usr/bin/chromium
fi
