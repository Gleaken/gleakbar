#!/bin/bash

# Script to list available PulseAudio/PipeWire sinks
# This is a fallback in case Pipewire API doesn't provide full information

if command -v pw-dump &> /dev/null; then
    # Using pw-dump (PipeWire)
    echo "Available sinks from pw-dump:"
    pw-dump | jq -r '.nodes[] | select(.type == "PipeWire:Interface:AudioSink") | .info.props."node.name" + " (" + .info.props."node.description" + ")"'
elif command -v pactl &> /dev/null; then
    # Using pactl (PulseAudio)
    echo "Available sinks from pactl:"
    pactl list sinks short
else
    echo "No audio control tools found"
fi