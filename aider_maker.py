#!/usr/bin/env python3

import os
from colorama import Fore, Style

def create_file(filepath, content, overwrite=False):
    """Creates a file with the given content.  Prompts for confirmation if file exists and overwrite is False."""
    if os.path.exists(filepath) and not overwrite:
        response = input(f"File '{filepath}' already exists. Overwrite? (y/n): ")
        if response.lower() != 'y':
            return False
    try:
        with open(filepath, 'w') as f:
            f.write(content)
        return True
    except OSError as e:
        print(f"Error creating file '{filepath}': {e}")
        return False

def create_directory(dirpath):
    """Creates a directory if it doesn't exist."""
    try:
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)
        return True
    except OSError as e:
        print(f"Error creating directory '{dirpath}': {e}")
        return False

def main():
    """Main function to create files and directory."""
    prompt_content = """Your name is Aider, you are the world's best pair coder.
You are currently working on a project with your partner, who is a beginner
coder. You are working on a project that requires you to write a program that
complies with the following requirements:


You need to follow these steps before generating any code, make sure that you follow them:
- Think Step By Step and do Proper Reasoning and Planning before implementation
- You can ask the user for something if you don't have anything. Don't make vague assumptions.
- Never overwrite code without requesting permission from the user.
- Always make sure that you have a backup of the code before making any changes."""

    rules_content = """- prefer httpsx over requests for making http requests-
   - requests is a great library for making http requests, but it is not as
      secure as httpsx. httpsx is a drop-in replacement for requests, so you can
      easily switch to it.-
- use types everywhere possible

- use type hints for function arguments and return values"""

    aider_conf_content = """
##########################################################
# Sample .aider.conf.yml produced by Aider-Maker
# This file lists *all* possible valid configuration entries
# Uncomment the ones you need and fill in the values
# place in your home dir, or at the root of your repo, as .aider.conf.yml
##########################################################

# Note: You can only put OpenAI and Anthropic API keys in the yaml
# config file. Keys for all APIs can be stored in a .env file
# https://aider.chat/docs/config/dotenv.html
# place GEMINI_API_KEY & CODESTRAL_API_KEY inside your .bashrc or .zshrc

#model: codestral/codestral-latest
#editor-model: codestral/codestral-latest

#############
# Main model:

## Specify the model to use for the main chat
#model: xxx

## Use claude-3-opus-20240229 model for the main chat
#opus: false

## Use claude-3-5-sonnet-20241022 model for the main chat
#sonnet: false

## Use claude-3-5-haiku-20241022 model for the main chat
#haiku: false

## Use gpt-4-0613 model for the main chat
#4: false

## Use gpt-4o model for the main chat
#4o: false

## Use gpt-4o-mini model for the main chat
#mini: false

## Use gpt-4-1106-preview model for the main chat
#4-turbo: false

## Use gpt-3.5-turbo model for the main chat
#35turbo: false

## Use deepseek/deepseek-chat model for the main chat
#deepseek: false

## Use o1-mini model for the main chat
#o1-mini: false

## Use o1-preview model for the main chat
#o1-preview: false


#model: gemini/gemini-1.5-pro-latest
#editor-model: gemini/gemini-1.5-flash-latest

#architect: true


#################
# Cache settings:

## Enable caching of prompts (default: False)
#cache-prompts: false

## Number of times to ping at 5min intervals to keep prompt cache warm (default: 0)
#cache-keepalive-pings: false

###################
# Repomap settings:

## Suggested number of tokens to use for repo map, use 0 to disable
#map-tokens: xxx

## Control how often the repo map is refreshed. Options: auto, always, files, manual (default: auto)
#map-refresh: auto

## Multiplier for map tokens when no files are specified (default: 2)
#map-multiplier-no-files: true

################
# History Files:

## Specify the chat input history file (default: .aider.input.history)
#input-history-file: .aider.input.history

## Specify the chat history file (default: .aider.chat.history.md)
#chat-history-file: .aider.chat.history.md

## Restore the previous chat history messages (default: False)
#restore-chat-history: false

## Log the conversation with the LLM to this file (for example, .aider.llm.history)
#llm-history-file: xxx

##################
# Output settings:

## Use colors suitable for a dark terminal background (default: False)
#dark-mode: false

## Use colors suitable for a light terminal background (default: False)
#light-mode: false

## Enable/disable pretty, colorized output (default: True)
#pretty: true

## Enable/disable streaming responses (default: True)
#stream: true

## Set the color for user input (default: #00cc00)
#user-input-color: #00cc00

## Set the color for tool output (default: None)
#tool-output-color: xxx

## Set the color for tool error messages (default: #FF2222)
#tool-error-color: #FF2222

## Set the color for tool warning messages (default: #FFA500)
#tool-warning-color: #FFA500

## Set the color for assistant output (default: #0088ff)
#assistant-output-color: #0088ff

## Set the color for the completion menu (default: terminal's default text color)
#completion-menu-color: xxx

## Set the background color for the completion menu (default: terminal's default background color)
#completion-menu-bg-color: xxx

## Set the color for the current item in the completion menu (default: terminal's default background color)
#completion-menu-current-color: xxx

## Set the background color for the current item in the completion menu (default: terminal's default text color)
#completion-menu-current-bg-color: xxx

## Set the markdown code theme (default: default, other options include monokai, solarized-dark, solarized-light, or a Pygments builtin style, see https://pygments.org/styles for available themes)
#code-theme: default

## Show diffs when committing changes (default: False)
#show-diffs: false

###############
# Git settings:

## Enable/disable looking for a git repo (default: True)
#git: true

## Enable/disable adding .aider* to .gitignore (default: True)
#gitignore: true

## Specify the aider ignore file (default: .aiderignore in git root)
#aiderignore: .aiderignore

## Only consider files in the current subtree of the git repository
#subtree-only: false

## Enable/disable auto commit of LLM changes (default: True)
#auto-commits: true

## Enable/disable commits when repo is found dirty (default: True)
#dirty-commits: true

## Attribute aider code changes in the git author name (default: True)
#attribute-author: true

## Attribute aider commits in the git committer name (default: True)
#attribute-committer: true

## Prefix commit messages with 'aider: ' if aider authored the changes (default: False)
#attribute-commit-message-author: false

## Prefix all commit messages with 'aider: ' (default: False)
#attribute-commit-message-committer: false

## Commit all pending changes with a suitable commit message, then exit
#commit: false

## Specify a custom prompt for generating commit messages
#commit-prompt: xxx

## Perform a dry run without modifying files (default: False)
#dry-run: false

## Skip the sanity check for the git repository (default: False)
#skip-sanity-check-repo: false

## Enable/disable watching files for ai coding comments (default: False)
#watch-files: false

########################
# Fixing and committing:

## Lint and fix provided files, or dirty files if none provided
#lint: false

## Specify lint commands to run for different languages, eg: "python: flake8 --select=..." (can be used multiple times)
#lint-cmd: xxx
## Specify multiple values like this:
#lint-cmd:
#  - xxx
#  - yyy
#  - zzz

## Enable/disable automatic linting after changes (default: True)
#auto-lint: true

## Specify command to run tests
#test-cmd: xxx

## Enable/disable automatic testing after changes (default: False)
#auto-test: false

## Run tests, fix problems found and then exit
#test: false

############
# Analytics:

## Enable/disable analytics for current session (default: random)
#analytics: xxx

## Specify a file to log analytics events
#analytics-log: xxx

## Permanently disable analytics
#analytics-disable: false

############
# Upgrading:

## Check for updates and return status in the exit code
#just-check-update: false

## Check for new aider versions on launch
#check-update: true

## Show release notes on first run of new version (default: None, ask user)
#show-release-notes: xxx

## Install the latest version from the main branch
#install-main-branch: false

## Upgrade aider to the latest version from PyPI
#upgrade: false

## Show the version number and exit
#version: xxx

########
# Modes:

## Specify a single message to send the LLM, process reply then exit (disables chat mode)
#message: xxx

## Specify a file containing the message to send the LLM, process reply, then exit (disables chat mode)
#message-file: xxx

## Run aider in your browser (default: False)
#gui: false

## Enable automatic copy/paste of chat between aider and web UI (default: False)
#copy-paste: false

## Apply the changes from the given file instead of running the chat (debug)
#apply: xxx

## Apply clipboard contents as edits using the main model's editor format
#apply-clipboard-edits: false

## Do all startup activities then exit before accepting user input (debug)
#exit: false

## Print the repo map and exit (debug)
#show-repo-map: false

## Print the system prompts and exit (debug)
#show-prompts: false

#################
# Voice settings:

## Audio format for voice recording (default: wav). webm and mp3 require ffmpeg
#voice-format: wav

## Specify the language for voice using ISO 639-1 code (default: auto)
#voice-language: en

## Specify the input device name for voice recording
#voice-input-device: xxx

#################
# Other settings:

## specify a file to edit (can be used multiple times)
#file: xxx
## Specify multiple values like this:
#file:
#  - xxx
#  - yyy
#  - zzz

## specify a read-only file (can be used multiple times)
#read: xxx
## Specify multiple values like this:
#read:
#  - xxx
#  - yyy
#  - zzz

#read-only:
#  -- do_not_touch.py

## Use VI editing mode in the terminal (default: False)
#vim: false

## Specify the language to use in the chat (default: None, uses system settings)
#chat-language: xxx

## Always say yes to every confirmation
#yes-always: false

## Enable verbose output
#verbose: false

## Load and execute /commands from a file on launch
#load: xxx

## Specify the encoding for input and output (default: utf-8)
#encoding: utf-8

## Line endings to use when writing files (default: platform)
#line-endings: platform

## Specify the config file (default: search for .aider.conf.yml in git root, cwd or home directory)
#config: xxx

## Specify the .env file to load (default: .env in git root)
#env-file: .env

## Enable/disable suggesting shell commands (default: True)
#suggest-shell-commands: true

## Enable/disable fancy input with history and completion (default: True)
#fancy-input: true

## Enable/disable multi-line input mode with Meta-Enter to submit (default: False)
#multiline: false

## Enable/disable detection and offering to add URLs to chat (default: True)
#detect-urls: true

## Specify which editor to use for the /editor command
#editor: xxx

"""

    success = True
    success &= create_file("prompt.md", prompt_content)
    print(Fore.BLUE + "creating prompt.md" + Style.RESET_ALL)
    success &= create_file("rules.md", rules_content)
    print(Fore.MAGENTA + "creating rules.md" + Style.RESET_ALL)
    success &= create_file("aider.conf.yml", aider_conf_content)
    print(Fore.CYAN + "creating aider.conf.yml." + Style.RESET_ALL)
    print(Fore.MAGENTA + "Please copy aider.conf.yml to .aider.conf.yml and edit to your preference" + Style.RESET_ALL)
    success &= create_directory("src")
    print(Fore.YELLOW + "creating src directory for your project files" + Style.RESET_ALL)

    if success:
        print(Fore.GREEN + "Files and directory created successfully. Remember to copy and edit .aider.conf.yml" + Style.RESET_ALL)
    else:
        print(Fore.RED + "Some errors occurred during file/directory creation." + Style.RESET_ALL)


if __name__ == "__main__":
    main()
