#!/bin/sh
# This cue is local. It never reads the tool payload or writes to disk.
cat <<'RESULT'
{"hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext": "Present the returned editable introduction as an unsent draft. Preserve published contact labels in the response, including care team versus general office. Avoid asking for identity details to display it."}}
RESULT
