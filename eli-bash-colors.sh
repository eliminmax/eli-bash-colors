ebcolor_clf () (
    if [ -n "$1" ]; then
        if [ "$1" = "-p" ] && ! [ -n "$2" ]; then
            echo '\033[0m'
            return 0
        else
            return 1
        fi
    else
        echo -e '\033[0m'
        return 0
    fi
)

_ebcolor_isbyte () (
    if [[ $1 =~ ^0*((25[0-5])|(2[0-4][0-9])|([01]?[0-9]{1,2}))$ ]]; then
        return 0
    else
        return 1
    fi
)

ebcolor_esc () (
    print_code=
    ansi_codes=()
    while [ -n "$1" ]; do
        unset n
        case "$1" in
            -[fFbB]|--foreground|--intense-foreground|--background|--intense-background)
                case "$1" in
                    -f|--foreground) n=30 ;;
                    -F|--intense-foreground) n=90 ;;
                    -b|--background) n=40 ;;
                    -B|--intense-background) n=100 ;;
                esac
                case "$2" in
                    0|black|bk|dg|dark-gr[ae]y) ((n+=0)) ;;
                    1|red|r) ((n+=1)) ;;
                    2|green|g) ((n+=2)) ;;
                    3|yellow|y|orange|o) ((n+=3)) ;;
                    4|blue|bl) ((n+=4)) ;;
                    5|purple|magenta|p|m) ((n+=5)) ;;
                    6|cyan|c) ((n+=6)) ;;
                    7|white|w|lg|light-gr[ae]y) ((n+=7)) ;;
                    8|8-bit|256-color)
                        if [ $n -eq 90 ] || [ $n -eq 100 ] ; then
                            ((n-=60))
                        fi
                        ((n+=8))
                        if _ebcolor_isbyte $3; then
                            ansi_codes[${#ansi_codes[@]}]=$n
                            ansi_codes[${#ansi_codes[@]}]=5
                            n=$3
                            shift
                        else
                            return 2
                        fi
                        ;;
                    9|24|24-bit|rgb)
                        if [ $n -eq 90 ] || [ $n -eq 100 ] ; then
                            ((n-=60))
                        fi
                        ((n+=8))
                        if _ebcolor_isbyte $3 && _ebcolor_isbyte $4 && _ebcolor_isbyte $5; then
                            ansi_codes[${#ansi_codes[@]}]=$n
                            ansi_codes[${#ansi_codes[@]}]=2
                            ansi_codes[${#ansi_codes[@]}]=$3
                            ansi_codes[${#ansi_codes[@]}]=$4
                            ansi_codes[${#ansi_codes[@]}]=$5
                            unset n
                            shift
                            shift
                            shift
                        fi
                        ;;
                    *)
                        return 2
                        ;;
                esac
                shift
                ;;
            -n|--number)
                if _ebcolor_isbyte $2; then
                    n=$2
                    shift
                else
                    return 2
                fi ;;
            -P|--plain|-0) n=0 ;;
            -e|--bold|-1) n=1 ;;
            -d|--dim|-2) n=2 ;;
            -i|--italic|-3) n=3 ;;
            -u|--underline|-4) n=4 ;;
            -t|--blink|-5) n=5 ;;
            -T|--fast-blink|-6) n=6 ;;
            -R|--reverse|-7) n=7 ;;
            -I|--hidden|-8) n=8 ;;
            -s|--strike|-9) n=9 ;;
            -p|--print-code) print_code=1 ;;
            *)
                return 1 ;;
        esac
        if ! [ -z "$n" ]; then
            ansi_codes[${#ansi_codes[@]}]=$n
        fi
        shift
    done
    inner_seq=$(printf "%s" "${ansi_codes[*]}" | tr " " ";")
    ansi_seq="\033[${inner_seq}m"
    if [ ${print_code} ]; then
        # if print code is non-empty, echo the literal string (useful for constructing PS1 prompt string)
        echo "${ansi_seq}"
    else
        # otherwise, actually print the code
        echo -e "${ansi_seq}"
    fi
)

