# Eli's BASH Colors

A BASH library for working with ANSI formatting codes.

## Source it into your script:

`source /path/to/eli-bash-colors.sh`
## Usage

There are two functions defined in `eli-bash-colors.sh`:

### ebcolor_clf

* **Usage:** `ebcolor_clf`, `ebcolor_clf -p`
* **Description:** prints out the ANSI Escape sequence to clear formatting (`\033[0m`)
* **Arguments:**
   * `-p`: print the code out, without actually running it
* **Return Codes:**
   * **0** - ran without issue
   * **1** - recieved an argument other than `-p`, or received multiple arguments

### ebcolor_esc

* **Usage:** `ebcolor_esc [ARGS]`
* **Description:** generates an ANSI escape sequence from the parameters.
* **Arguments:**
   * `-p`: print the code out, without actually running it
   * `-f color`, `--foreground color`: set the foreground color
   * `-b color`, `--background color`: set the background color
   * `-F color`, `--intense-foreground color`: set the foreground color to the intense/bright version of `color` (non-standard)
   * `-B color`, `--intense-background color`: set the background color to the intense/bright version of `color` (non-standard)
   * `-P`, `--plain`,`-0`: plain text
   * `-e`, `--bold`,`-1`: bold text
   * `-d`, `--dim`,`-2`: dim text (not widely supported)
   * `-i`, `--italic`, `-3`: italic text  (not widely supported)
   * `-u`, `--underline`, `-4`: underlined text
   * `-t`, `--blink`, `-5`: flashing text (ignored on most terminal emulators)
   * `-T`, `--fast-blink`, `-6`: fast blink (not widely supported)
   * `-R`, `--reverse`, `-7`: switch foreground and background
   * `-I`, `--hidden`, `-8`: make text invisible (not widely supported)
   * `-s`, `--strike`, `-9`: strike through text (not widely supported)
   * `-n int`, `--code int`: manually specify a code to use
* **Color Codes:**
   * `0`, `black`, `dark-gray`, `dark-grey`, `bk`, `dg`
   * `1`, `red`, `r`
   * `2`, `green`,`g`
   * `3`, `yellow`, `orange`, `brown`, `y`, `o`, `br`
   * `4`, `blue`, `bl`
   * `5`, `magenta`, `purple`, `m`, `p`
   * `6`, `cyan`, `c`
   * `7`, `white`, `light-gray`, `light-grey`, `w`, `lg`
   * `8 int`, `8-bit int`, `256-color int` - specify an [8-bit color id](https://robotmoon.com/256-colors/)
   * `9 int int int`, `24 int int int`, `24-bit int int int`, `rgb int int int`: specify RGB color values
* **Return Codes:**
   * **1** - unrecognized flag
   * **2** - unrecognized option for flag

## Why don't you just use tput?

`tput` is much more efficient and widely supported than this little script, which I made for fun over the course of a few days.

That said, I'd argue that there are two advantages over `tput`.

* I find that this is easier to use than `tput`, but that could be because I made it myself, so it's more familiar to me.

* This supports full 24-bit color
