---
url: "/command-line-fitness-tracker"
comments: true
date: 2016-09-11T22:23:25Z
excerpt: Who needs fancy fitness trackers when you can do everything in the command
  line with Bash, like a crazy person?
title: Command Line Fitness Tracker
tags:
  - cli
---

I've been trying to get back on the fitness and healthy eating wagon lately after my last attempt fell apart because of [delicious pizza][]. I keep track of my dietary macros in MyFitnessPal, mainly because of the ease in looking up food. Beyond that one feature I really can't stand the experience in either the app or the website.

When I'm tracking my measurements (weight, waist, hips, arms, neck, thigh, chest) it feels like an afterthought. There's so much of that app catered to food tracking and the other elements are buried in a completely different area. Trying to find historical numbers on the website is near impossible.

With all the data science work I've been doing, the possibility of using my own biometrics for something is becoming more appealing, so having all that data stuck in a sub-par system I can't query just won't cut it.

That's why I decided to make my own extremely basic fitness tracker. All I really want is a place where I can enter data easily, query it easily, and keep it sorted and safe. I've coded this little tool in Bash for the ultimate portability. Here's the requirements:

1) A command line.

That's it!

You can set an environment variable `TRACK_DIR` to point to where you'd like to store your tracked data. I'm putting mine in Dropbox. If you don't set that variable, the function defaults to the current directory. That's the only possible configuration option.

To use it, you can start by running the help, by typing either:

    track -h
	track --help

Which will show you:

    track - track a thing

    usage: track                     # list things tracked
    usage: track (-h or --help)      # show this help
    usage: track [thing]             # show most recent value of thing
    usage: track [thing] [value]     # track new value of thing for today
    usage: track [thing] [options]
        options:
        -a, --all                    # show all values of thing
        -n, --number                 # show (number) values of thing
        -d, --delete                 # delete thing tracking

This tracker doesn't care what you want to track. The `thing` can be whatever you want. In my examples below, I'll use `weight`, but it could be any string you'd like. When you type `track weight` the default output will be the most recent entry in the tracker. The entries are stored once per day. If you enter a new value multiple times in a day, it only stores the last one. `track weight 185` will set today's weight to 185. To see the complete history, you could type `track weight -a`. To see the last five entries: `track weight -n 5`. Accidentally start tracking something you didn't mean to? `track unhatchedchickens -d`

All the data is stored in csv files. The `value` data doesn't have to be numeric, either. You could use this to track your mood each day, for instance. I have a tiny helper to make sure you don't accidentally drop a comma into the CSV where it shouldn't be, but otherwise it just stores what you enter.

All the output is pretty and colorized. If that part breaks on your system (Kali doesn't care for that syntax, I know) just strip it out or replace with `tput` at your leisure.

Future iterations plan to have multiple output format options. Since the data is already in CSV there's not a whole lot needed for piping to other programs, but I may play around with stylistic stuff.

Ready for the code?

``` bash
function _track() {
  TRACK_DIR=${TRACK_DIR:-.}
  local lis
  lis=$(find "$TRACK_DIR"/*.csv -maxdepth 1 2>/dev/null | sed -e 's/.*\///' | sed -e 's/\..*$//')
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$lis" -- "$cur") )
}
function track() {
  TRACK_DIR=${TRACK_DIR:-.}
  if [ $# -eq 0 ]; then
    find "$TRACK_DIR"/*.csv -maxdepth 1 2>/dev/null | sed -e 's/.*\///' | sed -e 's/\..*$//'
  else
    case "$1" in
      -h|--help)
        echo "track - track a thing"
        echo " "
        echo "usage: track                     # list things tracked"
        echo "usage: track (-h or --help)      # show this help"
        echo "usage: track [thing]             # show most recent value of thing"
        echo "usage: track [thing] [value]     # track new value of thing for today"
        echo "usage: track [thing] [options]"
        echo "    options:"
        echo "    -a, --all                    # show all values of thing"
        echo "    -n, --number                 # show (number) values of thing"
        echo "    -d, --delete                 # delete thing tracking"
        ;;
      *)
        local f
        local fn
        f="$TRACK_DIR"/"$1".csv
        fn="$1"
        shift
        if [ $# -eq 0 ]; then
          if [ ! -f "$f" ]; then
            echo "track: '$fn' not found"
          else
            tail -n 1 "$f" | column -s, -t | awk '{printf "\033[38;05;226m%s-\033[38;05;226m%s-\033[38;05;226m%s\t\033[38;05;46m%s\t\n", $1, $2, $3, $4;}'
          fi
        else
          if [ ! -f "$f" ]; then
            echo "year,month,day,$fn" > "$f"
          fi
          case "$1" in
            -a|--all)
              column -s, -t "$f" | awk '{printf "\033[38;05;226m%s-\033[38;05;226m%s-\033[38;05;226m%s\t\033[38;05;46m%s\t\n", $1, $2, $3, $4;}'
              ;;
            -n|--number)
              tail -n "$2" "$f" | column -s, -t | awk '{printf "\033[38;05;226m%s-\033[38;05;226m%s-\033[38;05;226m%s\t\033[38;05;46m%s\t\n", $1, $2, $3, $4;}'
              ;;
            -d|--delete)
              rm "$f"
              ;;
            *)
              local d
              d=$(date '+%Y,%m,%d')
              local l
              l=$(sed -n "/$d/{=;}" "$f")
              local c
              c="${*//,/-}"
              if [ -z "$l" ]; then
                echo "$d,$c" >> "$f"
              else
                sed -i "$l c $d,$c" "$f"
              fi
              ;;
          esac
        fi
        ;;
    esac
  fi
}
complete -F _track track
```

In addition to fitness tracking, I'm actively trying to rewrite my poor eating and exercise habits using what I've learned from [The Power of Habit][] by Charles Duhigg. I've established a keystone habit in my morning walk that is already doing wonders. That one little change, and the little wins that come with it, are empowering a much bigger shift in my behavior. I can't recommend this book enough.

<div class="center">
<iframe
	height="240"
	width="120"
	sandbox="allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"
	frameborder="0"
	scrolling="no"
	src="https://ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=tomablog-20&marketplace=amazon&region=US&placement=081298160X&asins=081298160X&linkId=6fad0faf787146f77e6ead9d5f87b2e4&show_border=true&link_opens_in_new_window=true">
</iframe>
</div>

  [delicious pizza]: http://www.delorenzospizza.com/
    "DeLorenzo's Pizza"
  [The Power of Habit]: http://amzn.to/2cPdomG
    "The Power of Habit | Amazon.com"
