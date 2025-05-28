jcd () {

    jd_path=$(jdfs path "$@")
    jdfs_path_retval=$?

    if [ $jdfs_path_retval -eq 0 ] && [ -d $jd_path ]
    then
        cd $jd_path
        return $?

    elif [ ! -z $jd_path ]
    then
        echo $jd_path
        return $jdfs_path_retval

    else
        return $jdfs_path_retval
    fi
}
