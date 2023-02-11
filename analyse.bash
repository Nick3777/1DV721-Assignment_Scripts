SCRIPT=$( basename "$0" )

VERSION="1.0.0"

function usage
{
    local txt=(
"Utility $SCRIPT for downloading and analyse text or binary files."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"Command:"
"  analyze [URL]  Download the resource at the given url and analyze it."
""
"Options:"
"  --help, -h     Print help."
"  --version, -h  Print version."
    )

    printf "%s\\n" "${txt[@]}"
}

function badUsage
{
    local message="$1"
    local txt=(
                "For an overview of the command, execute:"
                "$SCRIPT --help"
                )

    [[ -n $message ]] && printf "%s\\n" "$message"

    printf "%s\\n" "${txt[@]}"
}

function version
{
    local txt=(
                "$SCRIPT version $VERSION"
                )

    printf "%s\\n" "${txt[@]}"
}


function analyse
{
        local dl="$1"
	local dlf=${dl##*/}
	local filesize
	printf "%s" "$dlf"
        wget -q "$dl"
		printf "\nThe type of the file is: "
		file "$dlf"
		printf "The size of the file is: "
                filesize=$(du -sh "$dlf" | awk '{print $1}')
                printf "%s" "$filesize"
		if [[ $dlf == *txt ]]; then
			printf "\nNumbers of lines, words and spaces: "
				wc -lw "$dlf" | awk '{printf "%s ", $1}{printf "%s ", $2}'; grep -o ' ' "$dlf" | wc -l
			printf "\nThe first line is: "
				head -n 1 "$dlf"
			printf "The last line is: "
				tail -n -1 "$dlf"
			printf "\n"
		else
			printf "\nBytes number of the file: "
				 wc -c "$dlf" | awk '{print $1}'
			printf "\nThe first 10 bytes are: "
				head -c 10 "$dlf"
			printf "\nThe last 10 bytes are: " 
				tail -c 10 "$dlf"
			printf "\n"
        	fi
	firefox "$dlf"
	exit 0;
}

while (( $# ))
do
    case "$1" in

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;

        analyse)
            shift
            analyse "$*"
            exit 0
        ;;

        *)
            badUsage "Option/command not recognized."
            exit 1
        ;;

    esac
done

    
