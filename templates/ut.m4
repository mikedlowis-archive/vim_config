define(SEP_IDX, regexp(ARGS,` '))dnl
define(FNNAME,  substr(ARGS,0,SEP_IDX))dnl
define(FNDESC,  patsubst(substr(ARGS,eval(SEP_IDX+1)),` ',`_'))dnl
dnl
format(`void test_%s_%s',FNNAME,FNDESC)(void) // Implementation
{
    /* Ensure known test state */
    /* Setup expected call chain */
    /* Call function under test */
    /* Verify test results */
}

