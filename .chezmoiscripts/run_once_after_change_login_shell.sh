#!/usr/bin/env bash
TARGET_SHELL_PATH="/bin/zsh"

# 1. Check if the target shell is already the current user's shell.
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)

if [ "$CURRENT_SHELL" = "$TARGET_SHELL_PATH" ]; then
  echo "Your shell is already set to $TARGET_SHELL_PATH. No action needed."
  exit 0
fi

echo "Your current shell is '$CURRENT_SHELL'. Attempting to change to '$TARGET_SHELL_PATH'."

# 2. Check if the target shell is listed in /etc/shells.
if ! grep -q "^${TARGET_SHELL_PATH}$" /etc/shells; then
  echo "Error: Target shell '$TARGET_SHELL_PATH' is not listed in /etc/shells."
  echo "Please install zsh and/or add its path to /etc/shells to proceed."
  exit 1
fi

echo "Target shell '$TARGET_SHELL_PATH' is a valid login shell."

# 3. Change the user's shell using usermod.
echo "Changing shell for user '$USER' to '$TARGET_SHELL_PATH'..."
sudo usermod --shell "$TARGET_SHELL_PATH" "$USER"

# 4. Verify the change and provide feedback.
if [ $? -eq 0 ]; then
  echo "Success! Shell for user '$USER' has been changed to '$TARGET_SHELL_PATH'."
  echo "Please log out and log back in for the change to take effect."
else
  echo "Error: Failed to change the shell. 'usermod' command failed."
  exit 1
fi

exit 0
