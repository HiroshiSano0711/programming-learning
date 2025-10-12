// Listing1-3.S 
//
// A simple Gas module that contains 
// an empty function to be called by 
// the C++ code in Listing 1-2 

.text 


// Here is the asmMain function: 

.global _asmMain, asmMain 
.align  2    // Guarantee 4-byte alignment. 

_asmMain: 
asmMain: 
        // Empty function just returns to C++ code. 
        ret          // Returns to caller
