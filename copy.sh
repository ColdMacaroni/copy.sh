#!/usr/bin/env zsh
FILE_DIR="$HOME/.local/share/copysh"

if [ $# -eq 0 ]; then
    exit 0
fi

case $1 in
    "-h")
        echo "copysh"
        echo "Folder at $FILE_DIR"
        printf "\t$(basename "$0") -n 'NAME' 'TEXT'\t Create a new thing to copy with that name and that text\n"
        printf "\t$(basename "$0") 'NAME' \t\t Copy the content of that file in the folder\n"
        printf "\t$(basename "$0") -l \t\t List all current files under that folder\n"
        ;;

    "-n")
        shift
        if [ $# -ne 2 ]; then
            >&2 echo "Wrong number of arguments"
        fi

        file_path="$FILE_DIR/$1"

        if [ -e "$file_path" ]; then
            if ! [ -f  "$file_path" ];
            then
                >&2 echo "$file_path exists but it isn't a regular file."
                exit 1
            else
                echo "$_file_path exists with the following content:"
                cat "$file_path"

                vared -p 'Would you like to overwrite? [y/N]: ' -c inp

                # If the say anything but y
                if ! [ "$(echo "$inp" | tr -d ' ' | tr '[:upper:]' '[:lower:]')" = y ]; then
                    exit 1
                fi
            fi
        fi

        touch "$file_path"
        printf "%s" "$2" > "$file_path"
        ;;

    "-l")
        find "$FILE_DIR" -type f -printf '%P\n'
        ;;

  *)
        if [ $# -ne 1 ]; then
            >&2 echo "Wrong number of arguments"
        fi

        file_path="$FILE_DIR/$1"
        xclip -selection clipboard -in < "$file_path"
        echo "\"$(cat "$file_path")\" copied to clipboard!"
        ;;
esac

