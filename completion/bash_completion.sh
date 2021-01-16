_bkm_list()
{
    _init_completion || return
    _filedir '@(bkm)'
}

_bkm_create()
{
    if [ "${COMP_CWORD}" -eq 1 ] &&
       [ "$(xclip -o 2> /dev/null | wc -w)" -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$(xclip -o 2> /dev/null)" -- "${COMP_WORDS[COMP_CWORD]}") )
    else
        COMPREPLY=( $(compgen -o default -- "${COMP_WORDS[COMP_CWORD]}") )
    fi
}

complete -F _bkm_list bkm-open
complete -F _bkm_create bkm-create
