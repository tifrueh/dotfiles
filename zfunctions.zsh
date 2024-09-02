function jcd () {

    if jd_path=$(jd path "$@") && [ -d $jd_path ]; then
        cd $jd_path
        return 0;
    else
        return 1;
    fi

}
