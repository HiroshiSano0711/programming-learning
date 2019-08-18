
          global    start
          extern    _puts

          section   .text
start:    push      rbx                     
          lea       rdi, [rel message]      
          call      _puts                   
          pop       rbx                     
          ret

          section   .data
message:  db        "ハロー", 0