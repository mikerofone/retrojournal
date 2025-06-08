set -e

if [[ "$1" == "" ]] ; then
  echo "Specify one or more .pbm files to convert to .bin. Optionally x,y of start coordinate as first arg."
  exit 1
fi

if echo "$1" | grep ',' ; then
  coords="$1"
  shift 1
else
  coords="0,0"
fi

while (( "$#" )); do
  img="$1"
  echo "Converting $img from coordinates ${coords}"
  dosname="${img/\//\\}"
  python3 "$(pwd)"/pgm_to_bw.py $img
  dosbox \
      -c "mount c $(pwd)" \
      -c "C:" \
      -c "imgtobin.exe ${dosname/.pbm/.rle} ${coords}" \
      -c "exit"
  shift
done

