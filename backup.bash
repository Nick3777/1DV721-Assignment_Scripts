#Exit values:
#  0 on success
#  1 on failure

SCRIPT=$( basename "$0")
VERSION="1.0"

function usage
{
	local txt=(
		"Utility $SCRIPT to backup a directory"
		"Usage: $SCRIPT [options] <command> [arguments]"
		""
		"Command:"
		" backup[dir]    Standard backup in a tar.gz file in tmp dir"
		""
		"Options:"
		" --help, -h     Print help"
		" --version, -v  Print versione"
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

function backup
{
	local dir="$1"
	local name="/tmp/backup_2022-01-25.tar.gz"

	if [ -d "$dir" ] && [ ! -f "$name" ]; then
		tar -czvf "$name" "$dir"
	elif [ -d "$dir" ] && [ -f "$name" ]; then
		printf "The backup file already exist\n"
	elif [ ! -d "$dir" ]; then
		printf "%s : No such directory\n" "$dir"
	fi
	sleep 2
	printf "The command took %s to execute\n" "$SECONDS"

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

		backup)
			command=$1
			shift
			"$command" "$*"
			exit 0
			;;
		*)
			badUsage "Option/command not recognized"
			exit 1
			;;
	esac
done
	
