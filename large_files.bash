SCRIPT=$( basename "$0" )

VERSION="1.0.0"

function usage
{
    local txt=(
"Utility $SCRIPT for analyze largest size file in a directory."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"Command:"
"  size [dir]     Analyze recursively a directory finding the 5 largest files."
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

function large_files
{
	local p="$1"
	local filesize
	if [ -d "$p" ]; then
		printf "This directory disk space usage is: "
		filesize=$(du -sh "$p" | awk '{print $1}')
			printf "%s\n" "$filesize"
		printf "Number of files and dir examined: "
			find "$p" -mindepth 1 | wc -l
		printf "The 5 larger files (in Bytes) are:\n"
			find "$p" -type f -printf "%sB\t%p\n" | sort -rn | head -5
	else
		printf "No such directory\n"
	fi
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

        size)
            shift
            large_files "$*"
            exit 0
        ;;

        *)
            badUsage "Option/command not recognized."
            exit 1
        ;;

    esac
done
