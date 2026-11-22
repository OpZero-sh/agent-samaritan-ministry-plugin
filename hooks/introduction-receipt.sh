#!/bin/sh
# Runs after prepare_ministry_introduction returns. It prints one fixed reminder for the model.
# It never reads the tool payload, never writes to disk and never opens a network connection.
cat <<'RESULT'
{"hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext": "Present the returned editable introduction as an unsent draft. Say that nothing was sent, no call was placed and nothing was booked. Preserve published contact labels in the response, including care team versus general office. Avoid asking for identity details to display it."}}
RESULT
