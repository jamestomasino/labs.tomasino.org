---
url: "/time-tracker-in-bash"
comments: true
date: 2016-09-18T11:01:18Z
excerpt: I built a simple time tracker in Bash as a way to hone my command line skills.
tags:
  - bash
  - timetracker
  - functions
title: Time tracker in Bash
---

<img width="703" height="430" layout="responsive" src="https://labs.tomasino.org/assets/images/ti-example.gif" alt="ti Example"></img>

Yesterday I put together an extremely basic time tracker on the command line to compliment my [other command line function][]. There's not much to it, really. The basics can be found in the help:

    ti - time tracker

    Tracks activity time with a simple start/stop syntax. Logs to CSV. Tmux session aware.
    Allows one activity active at a time, per session.

    usage: ti                                       # show this help
    usage: ti (--help or -h)                        # show this help
    usage: ti (--start or -s) [activity name]       # start a new activity
    usage: ti (--done or -d or --finish or -f)      # stop and log activity
    usage: ti (--abort or -a)                       # stop activity, no log
    usage: ti --clear-log                           # delete log of previous activities
    usage: ti --activity-name                       # show activity for current session
    usage: ti --shortlist                           # quick list of commands without context
    usage: ti [activity name]                       # toggles start/stop
    usage: ti (--list -l) [options]                 # show log of previous activities
        option: t                                   # summarize time by activity
        option: s                                   # show only current session

In short, you can start an activity with `ti --start [activity name]`, and then finish it with `ti --finish`. If you're lazy like me, just omit the switches. The activity name itself will just act like a toggle. The activities are logged to a file as a CSV. There's some very basic options on the log viewer as well. I'll likely be adding more for weekly summaries at some point.

The use case is minimal and aimed at myself, like all awesome programs. I'll be keeping track of my day-to-day work activities so I can have an easier time entry.

It's written as a bash function rather than a stand-alone executable. I like the function model since I can build-in autocompletion without an install script or other such nonsense. Here's the code:

``` bash
#!/usr/bin/env bash

function _ti() {
    # Setup paths
    TIME_LOG="${TIME_LOG:-$HOME/.timelog}"

    # Get basic autocomplete commands from the function itself
    local helplist
    helplist=$(ti --shortlist)

    # Get activity name from function itself
    local activity
    activity=$(ti --activity-name)

    # Get the list of previously logged activities
    local loglist
    if [ -r "$TIME_LOG" ]; then
        loglist=$(awk -F ", " '{printf "%s\n", $2;}' "$TIME_LOG")
    fi

    # Combine all the lists for autocomplete
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W "$activity $loglist $helplist" -- "$cur" ) )
}

function ti() {
    # Setup paths
    TIME_LOG="${TIME_LOG:-$HOME/.timelog}"
    timerfile="${TIMERFILE:-$HOME/.timerfile}"

    # Session detection
    local session
    session="personal"
    if echo "$TERM" | grep -Fq screen && test "$TMUX" ; then
        session=$(tmux display -p '#S')
    fi

    # Create the timerfile to avoid throwing errors
    if ! [ -r "$timerfile" ]; then
        touch "$timerfile"
    fi

    # Do we have an activity active for this session?
    local match
    match=$(sed -n "/$session/{=;}" "$timerfile")

    # Get activity name, start time (and throw away session name)
    local activity
    local activity_start
    local sess
    if ! [ -z ${match:x} ]; then
        read sess activity_start activity <<< $(sed -n "${match}p" < "$timerfile")
    fi

    if [ $# -eq 0 ]; then

        # No parameters = show help
        ti -h

    else

        case "$1" in

            --activity-name)
                # Shows the current activity name if there is one for this session
                if ! [ -z "$activity" ]; then
                    echo "$activity"
                fi
                ;;

            --shortlist)
                # Shows a short list of commands without context
                echo "--help --start --done --finish --abort --list --clear-log --activity-name --shortlist";
                ;;

            -h|--help)
                # Help
                echo "ti - time tracker"
                echo " "
                echo "Tracks activity time with a simple start/stop syntax. Logs to CSV. Tmux session aware."
                echo "Allows one activity active at a time, per session."
                echo " "
                echo "usage: ti                                       # show this help"
                echo "usage: ti (--help or -h)                        # show this help"
                echo "usage: ti (--start or -s) [activity name]       # start a new activity"
                echo "usage: ti (--done or -d or --finish or -f)      # stop and log activity"
                echo "usage: ti (--abort or -a)                       # stop activity, no log"
                echo "usage: ti --clear-log                           # delete log of previous activities"
                echo "usage: ti --activity-name                       # show activity for current session"
                echo "usage: ti --shortlist                           # quick list of commands without context"
                echo "usage: ti [activity name]                       # toggles start/stop"
                echo "usage: ti (--list -l) [options]                 # show log of previous activities"
                echo "    option: t                                   # summarize time by activity"
                echo "    option: s                                   # show only current session"
                ;;

            -d|--done|-f|--finish)
                # Only finish an activity if there is an active one
                if ! [ -z "$match" ]; then
                    # Remove the activity from the timerfile
                    sed -i "$match d" "$timerfile"

                    # Activity finish timestamp and pretty version
                    local activity_finish
                    activity_finish=$(timestamp)
                    local pretty_finish
                    pretty_finish=$(date -r "$activity_finish" '+%Y-%m-%d %H:%M:%S')

                    # Activity duration calculation
                    activity_duration=$((activity_finish-activity_start))

                    # Activity start pretty version
                    local pretty_start
                    pretty_start=$(date -r "$activity_start" '+%Y-%m-%d %H:%M:%S')

                    # Output to console and log file
                    echo "$activity finished in ${activity_duration} seconds"
                    echo "$session, $activity, $pretty_start, $pretty_finish, $activity_duration" >> "$TIME_LOG"
                fi
                ;;

            -a|--abort)
                # Remove activity from timerfile without logging
                if ! [ -z "$match" ]; then
                    sed -i "$match d" "$timerfile"
                fi
                ;;

            -l|--log)
                # Show log file if it exists
                if ! [ -r "$TIME_LOG" ]; then
                    # If the file doesn't exist, create it to avoid errors
                    touch "$TIME_LOG"
                fi

                # Check for flags
                if ! [ -z "$2" ]; then
                    local flags
                    flags=$2
                    bytes="${#flags}"
                    local sessiononly
                    local timesummary
                    sessiononly=0
                    timesummary=0
                    for ((i=0;i<bytes;i++)); do

                        case "${flags:i:1}" in
                            "s")
                                sessiononly=1
                                ;;
                            "t")
                                timesummary=1
                                ;;
                        esac
                    done
                    if [ "$sessiononly" == 1 ]; then
                        if [ "$timesummary" == 1 ]; then
                            sed -n "/^$session/p" "$TIME_LOG" | awk -F ", " '{printf "%s, %s\n", $2, $5}' | awk '{a[$1]+=$2}END{for(i in a) print i, a[i]}'
                        else
                            sed -n "/^$session/p" "$TIME_LOG"
                        fi
                    else
                        if [ "$timesummary" == 1 ]; then
                            awk -F ", " '{printf "%s, %s\n", $2, $5}' "$TIME_LOG" | awk '{a[$1]+=$2}END{for(i in a) print i, a[i]}'
                        else
                            cat "$TIME_LOG"
                        fi
                    fi
                else
                    # No flags, show the whole log
                    cat "$TIME_LOG"
                fi
                ;;

            --clear-log)
                # Empty contents of log
                > "$TIME_LOG"
                ;;

            *|-s|--start)
                if [ "$*" == "$activity" ]; then
                    # we repeated the active activity name, that means finish
                    ti -f
                    return 0
                elif [ "$1" == "-s" ] || [ "$1" == "--start" ]; then
                    # shift only if we used the switch. Otherwise continue.
                    shift
                fi

                # Use the full remaining param list as the new name
                if [ -z "$match" ]; then
                    # No current activity? Just create one.
                    echo "$session $(timestamp) $*" >> "$timerfile"
                else
                    # Already a current activity? Ask to abandon first
                    confirm "You have an activity started ($activity). Abandon it? [y/N] " && sed -i "$match c $session $(timestamp) $*" "$timerfile"
                fi
                ;;

        esac

    fi

}

complete -F _ti ti
```

There's some awk work in there that I'm especially proud of!

  [other command line function]: https://labs.tomasino.org/command-line-fitness-tracker/
    "Command Line Fitness Tracker"
