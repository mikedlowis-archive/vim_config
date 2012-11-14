define(SEP_IDX, regexp(ARGS,` '))dnl
define(NAME,  substr(ARGS,0,SEP_IDX))dnl
define(FNAME, patsubst(substr(ARGS,eval(SEP_IDX+1)),` ',`_'))dnl
dnl
/**
    @file "format(`%s.c',FNAME)"
    @brief TODO: Describe this file
    $Revision$
    $HeadURL$
*/
`#'include "format(`%s.h',FNAME)"



