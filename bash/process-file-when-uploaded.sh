#!/bin/sh

# Watching dir and executing a command when a file is uploaded to it.
# For making this proccess active when a user is logged in, place it in /etc/profile for system-wide or .bash_profile
# For running it after boot, it depends on your flavour of Unix/Linux; /etc/rc.local,/etc/rc.d/ or /etc/init.d/

input_dir=/path/to/A/
output_dir=/path/to/B/

while inotifywait -qqre close_write "$input_dir"; do
    cp $input_dir/* $output_dir/
done
