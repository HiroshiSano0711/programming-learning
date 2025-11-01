// Listing7-1.S
//
// Initializing qword values with the
// addresses of statement labels

#include "aoaa.inc"

.data
.align 3
lblsInProc: .dword globalLbl1, globalLbl2

.code

proc procWLabels

globalLbl1: b.al globalLbl2
globalLbl2:
    ret
endp procWLabels

.pool
.align 3
dataInCode: .dword globalLbl1, globalLbl2
