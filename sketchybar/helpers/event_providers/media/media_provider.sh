#!/bin/bash

EVENT_NAME="$1"

# Add the custom event to sketchybar
sketchybar --add event "$EVENT_NAME"

# Map bundle identifiers to app names
bundle_to_app() {
  case "$1" in
  com.apple.Music) echo "Music" ;;
  com.spotify.client) echo "Spotify" ;;
  com.plexamp.Plexamp) echo "Plexamp" ;;
  org.mozilla.firefox) echo "Firefox" ;;
  com.google.Chrome) echo "Google Chrome" ;;
  com.apple.Safari) echo "Safari" ;;
  org.mozilla.librewolf) echo "LibreWolf" ;;
  *) echo "$1" ;;
  esac
}

media-control stream --no-diff --debounce=200 2>/dev/null | while IFS= read -r line; do
  # Skip empty payloads
  payload=$(echo "$line" | jq -r '.payload // empty')
  [ -z "$payload" ] || [ "$payload" = "{}" ] && continue

  bundle=$(echo "$line" | jq -r '.payload.bundleIdentifier // ""')
  playing=$(echo "$line" | jq -r '.payload.playing // false')
  title=$(echo "$line" | jq -r '.payload.title // ""')
  artist=$(echo "$line" | jq -r '.payload.artist // ""')

  app=$(bundle_to_app "$bundle")

  if [ "$playing" = "true" ]; then
    state="playing"
  else
    state="paused"
  fi

  sketchybar --trigger "$EVENT_NAME" \
    app="$app" \
    state="$state" \
    title="$title" \
    artist="$artist"
done
