# extract compressed files. http://serverfault.com/questions/3743/
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# setup proxy if needed
country=`wget -qO - ifconfig.co/x-ifconfig-country`
if [ $country == "China" ]; then
   export http_proxy=http://tw.liruqi.info:21
   export https_proxy=http://tw.liruqi.info:21
fi

# http://askubuntu.com/questions/323944/convert-webm-to-other-formats
webmTOmp4 () {
   ffmpeg -i "$1".webm -qscale 0 "$1".mp4
}

mp4TOmp3 () {
   ffmpeg -i "$1".mp4 "$1".mp3
}
