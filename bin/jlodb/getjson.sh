#!/bin/bash

# CHECK ARGUMENTS
if [ ! -f "index.html" ]; then
    echo `basename $0` must be run from the jlodb folder root
    exit 1
fi

# PARAMETER DEFAULT VALUES
exs=""
dest="output"
url="jlodb.poufpoufproduction.fr"

OPTIND=1

while getopts "h?o:u:i:" opt; do
    case "$opt" in
    h|\?)
        echo "usage: $0 -i id [OPTIONS]"
        echo "  -i [ID]     : exercice ids                 []"
        echo "  -u [URL]    : jlodb website url            [jlodb.poufpoufproduction.fr]"
        exit 0
        ;;
    i)  exs=$OPTARG ;;
    o)  dest=$OPTARG ;;
    u)  url=$OPTARG ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# CHECK IDS
if [ -z $exs ] ; then
	echo "ERROR: exercice ids are missing..."
	echo "usage: $0 -i id [OPTIONS]"
	exit 0
fi

main()
{
wget "$url/api/exercice.php?detail&source&id=$1" -O p_json.tmp
IFS=$'\n'


for ex in `cat p_json.tmp | sed -e 's/{\("id":"[^"]*","label"\)/\n{\1/g'` ; do
	if [ `echo $ex | grep activity | wc -l` -eq 1 ] ; then
		id=`echo $ex | sed -e 's/^.*id":"\([^"]\+\)","label":.*$/\1/g'`
		source=`echo $ex | sed -e 's/^.*source":"\([^"]\+\).*$/\1/g'`
        echo "+ processing $id"
        activity=`echo $ex | sed -e 's/^.*activity":"\([^"]\+\).*$/\1/g'`
        data=`echo $ex | sed -e 's/^.*,"data":\({.\+\),"ext".*$/\1/g'`
                
        echo "\"$id\":{\"activity\":\"$activity\",\"args\":$data},"
          
        IFS=,
        ary=($source)
        for key in "${!ary[@]}"; do
			s="${ary[$key]}"
			if [[ $s == [* ]] ; then
				ref=`echo $s | sed -e 's/\[\(.*\)\]/\1/g'`
				echo -n "$ref," >> p_ref.tmp
			fi
        done
        IFS=$'\n'
    fi
done

echo "\"zz\":0}"

}

echo "" > p_ref.tmp
main $exs
exs=`cat p_ref.tmp | sed -e 's/\(.*\),$/\1/g'`
if [ ! -z $exs ] ; then main $exs ; fi

rm -f p_*.tmp