define(SEP_IDX, regexp(ARGS,` '))dnl
define(NAME,  substr(ARGS,0,SEP_IDX))dnl
define(FNAME, patsubst(substr(ARGS,eval(SEP_IDX+1)),` ',`_'))dnl
define(GUARD, translit(format(`%s_H', FNAME), `a-z', `A-Z'))dnl
dnl
/**
    @file "format(`%s.h',FNAME)"
    @brief TODO: Describe this file
    $Revision$
    $HeadURL$
*/
`#'define GUARD
`#'ifndef GUARD



`#'endif /* GUARD */
