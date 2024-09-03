function jcd () {
    jd_path=$(jd path "$@")
    jd_path_retval=$?

    if [ $jd_path_retval -eq 0 ] && [ -d $jd_path ]; then
        cd $jd_path
        return $?
    elif [ ! -z $jd_path ]; then
        echo $jd_path
        return $jd_path_retval
    else
        return $jd_path_retval
    fi

}
