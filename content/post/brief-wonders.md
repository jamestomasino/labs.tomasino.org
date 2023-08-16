---
date: 2023-08-16 21:44:04 +0000
title: "Brief Wonders"
url: "/brief-wonders"
og_image: "/assets/images/brief-wonders.jpg"
tags:
  - music
  - data science
  - r
---

Last night while lying in bed I started wondering how many songs had reached the
hot 100 charts for only a single week, and never again. I call them "Brief
Wonders". You know, not quite one-hit wonders, but sorta close.

Well, Tonight I decided to look into it!

A brief search found a lot of people who have been gathering Hot 100 data over
the years. A few clicks led me to [HipsterVizNinja's Github Repo](https://github.com/HipsterVizNinja/random-data/tree/main/Music/hot-100).
They did a wonderful job grabbing data all the way back to 1958 and as recent as
May 2023 (as of this blog post). With that data I was all set.

Hereabouts I started developing this grand vision of collating these songs into
lists by year and making little playlists. If I had enough maybe it would make
another neat show for [streaming on Tilderadio](https://labs.tomasino.org/sci-fi-radio/).

If nothing else I could generate some cool Spotify playlists or something,
right? Time to dive in.

The first step was a bit of R code. Actually, it's pretty short so let me just
include the full script here!

```r
# Load my helper libs
library(tidyverse)
library(lubridate)
# Grab the 53MB csv file
datafile <- "https://raw.githubusercontent.com/HipsterVizNinja/random-data/main/Music/hot-100/Hot%20100.csv"
raw_100 <- read.csv(datafile, header=TRUE, stringsAsFactors=FALSE)

# Run the date column through lubridate so it's easy to work with
hot_100 <- raw_100 %>%
  mutate(chart_date = ymd(chart_date))

# Cleanup
remove(raw_100)

# Find songs that appeared only once and sort by date
brief_100 <- hot_100 %>%
  group_by(song_id) %>%
  filter(n() == 1) %>%
  filter(is.na(consecutive_weeks)) %>%
  select(chart_position, chart_date, song, performer, song_id) %>%
  arrange(chart_date)

# Break the song lists down by decade
brief_1960s <- brief_100 %>%
  filter(between(chart_date, as.Date('1960-01-01'), as.Date('1969-12-31')))

brief_1970s <- brief_100 %>%
  filter(between(chart_date, as.Date('1970-01-01'), as.Date('1979-12-31')))

brief_1980s <- brief_100 %>%
  filter(between(chart_date, as.Date('1980-01-01'), as.Date('1989-12-31')))

brief_1990s <- brief_100 %>%
  filter(between(chart_date, as.Date('1990-01-01'), as.Date('1999-12-31')))

brief_2000s <- brief_100 %>%
  filter(between(chart_date, as.Date('2000-01-01'), as.Date('2009-12-31')))

brief_2010s <- brief_100 %>%
  filter(between(chart_date, as.Date('2010-01-01'), as.Date('2019-12-31')))

brief_2020s <- brief_100 %>%
  filter(between(chart_date, as.Date('2020-01-01'), as.Date('2029-12-31')))

# Write CSVs for each decade
write.csv(brief_1960s, "./brief-1960s.csv", row.names=FALSE)
write.csv(brief_1970s, "./brief-1970s.csv", row.names=FALSE)
write.csv(brief_1980s, "./brief-1980s.csv", row.names=FALSE)
write.csv(brief_1990s, "./brief-1990s.csv", row.names=FALSE)
write.csv(brief_2000s, "./brief-2000s.csv", row.names=FALSE)
write.csv(brief_2010s, "./brief-2010s.csv", row.names=FALSE)
write.csv(brief_2020s, "./brief-2020s.csv", row.names=FALSE)
```

The output is 7 CSV files. Want to download them? Here you go:

* [Brief 1960s](/assets/brief-wonders/brief-1960s.csv)
* [Brief 1970s](/assets/brief-wonders/brief-1970s.csv)
* [Brief 1980s](/assets/brief-wonders/brief-1980s.csv)
* [Brief 1990s](/assets/brief-wonders/brief-1990s.csv)
* [Brief 2000s](/assets/brief-wonders/brief-2000s.csv)
* [Brief 2010s](/assets/brief-wonders/brief-2010s.csv)
* [Brief 2020s](/assets/brief-wonders/brief-2020s.csv)

It was at this time I realized something really weird. There were only 9 songs
in the 1980s that charted for a single week. And what's that? The 2010s had 1245
songs‽

My expectations of relatively normal distributions across time were obviously
wrong. I had to look deeper. Just exactly what does this behavior look like over
the last 70 years?

{{< figure src="https://labs.tomasino.org/assets/images/brief-wonders.jpg" >}}

Utterly fascinating! I have some guesses that the result is based on how the
charts were calculated over time, but I'm not sure that tells the complete
story. I recall hearing something from a podcast about how the charts started
using actual real-time sales data sometime in the early 90s, but we don't see
a major shift in numbers then. I would further guess that the move from albums
to individual song sales and streaming culture changed the game a bit, which
might be what we're seeing in the early 2000s spike.

Hopefully one of you will be inspired by the questions it raises and do a bit
more research on your own. If you learn anything, please let me know. I'm so
curious.

Oh, and for script completion sake, here's the bit that generated that graph:

```r library(ggplot2) library(plotly)
yearly_stats <- brief_100 %>%
  mutate(year = year(chart_date)) %>%
  group_by(year) %>%
  summarize(songs = n(), last_date = max(chart_date))

yearly_plot <- ggplot(yearly_stats, aes(x = factor(year), y = songs, text = as.character(last_date))) +
  geom_col(fill = "pink", color = "black") +
  labs(x = "Date", y = "Nº Songs") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  scale_x_discrete(label = function(x) paste("Year", x))

ggplotly(yearly_plot)
```

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
