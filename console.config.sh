#!/usr/bin/env bash
## Console config

# Helpers
msg() { gum style --foreground '#fda' "$@";}
err() { gum style --foreground '#f00' --bold "$@";}
## verification failed
ver() { gum style --foreground '#fe0' --bold "$@";}
wrn() { gum style --foreground '#fa0' "$@";}

run_w_retry() {
    while true; do
        # "$@" evaluates all arguments passed to the function as a command
        if "$@"; then
            return 0
        else
            msg "Error executing: $*" >&2

            if gum confirm --default=true "Do you want to retry?"; then
                msg "Retrying..." >&2
                continue
            else
                return 1
            fi
        fi
    done
}


# Load variables from .env
# Since the .env is generated from the user or generated with (WIP) script
# there's no need to parse
if [ -f  ./.env ]; then
    msg '.env has been found'
    set -a
    if source ./.env; then
        msg '.env loaded successfully'
    else
        err 'Failed to load .env'
    fi
    set +a
fi
