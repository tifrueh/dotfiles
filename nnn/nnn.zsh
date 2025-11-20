export NNN_TRASH=trash
export NNN_BMS="n:${HOME}/Nextcloud;g:${HOME}/Git"
export BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# Enable jdfs plugin if jdfs is installed.
if type "jdfs" &> /dev/null; then
        export NNN_PLUG="j:jcd;${NNN_PLUG}"
fi
