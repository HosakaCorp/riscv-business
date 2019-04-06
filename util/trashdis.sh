#!/bin/sh
export ARCH="rv64g"
export CARCH="rv64gc"

while :; do
	case $1 in
		-h|-\?|--help)
			printf "echo 'li a7,0xfff' | trashdis.sh\\ntrashdis.sh 'li a7,0xfff'\\n-c - use compressed instructions\\n-h - print this help\\n"
			exit
			;;
		-c|--compressed)
			ARCH="${CARCH}"
			;;
		-?*)
			printf 'Unknown option: %s\n' "$1" >&2
			;;
		*)
			break
	esac
	shift
done

if [ -p /dev/stdin ]; then
	while IFS= read i; do
		printf "%s\n" "${i}"| \
			gcc -x assembler -march=${ARCH} -c -o /tmp/semiinline.o - \
			&& objdump -D /tmp/semiinline.o | \
			tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f3-| \
			sed '/^$/d' | grep -v -e "section \.text:" -e "format elf"
	done
else 
	printf "%s\n" "$*" |  \
		gcc -x assembler -march=${ARCH} -c -o /tmp/semiinline.o - \
		&& objdump -D /tmp/semiinline.o | \
		tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f3-| \
		sed '/^$/d' | grep -v -e "section \.text:" -e "format elf"
fi
