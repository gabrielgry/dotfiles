#!/bin/bash
# Execute the fixed command, preserving stdin and stdout
exec /usr/bin/distrobox-host-exec /opt/1Password/op-ssh-sign "$@"
