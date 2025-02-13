function reduce.jpeg.size
    for filename in $argv
        set -l filename_split (string split --max 1 --right '.' "$filename")
        set -l new_filename (string join '_.' $filename_split)

        jpegtopnm $filename | pamscale -xyfit 2048 2048 | pnmtojpeg -quality=100 > $new_filename
        jpegoptim --size=150 $new_filename
    end
end
