
; remove any models which correctly exist and return 
; ACT-R to initial state
(clear-all)

; define-model includes model name and all the calls to
; ACT-R commands that will provide the inital conditions and knowledge
(define-model demo2  

; the sgp command which is used to set parameters for the model
(sgp :seed (123456 0))
(sgp :v t :show-focus t :trace-detail high)

; A chunk-type is a way for the modeler to specify categories for 
; the knowledge in the model by indicating a set of slots which will 
; be used together in the creation and testing of chunks.
; Format: (chunk-type type-name slot-name-1 slot-name-2 ... slot-name-n)
; Note: chunk-type are not required and is not part of the ACT-R achitecture
; but rather a part of the software. It makes it easier to debug and create models
(chunk-type read-letters state) 
(chunk-type array letter)

; Specification of initial chunks to be placed in the model's
; declarative memory:
; Note: add-dm -> command to create a set of chunks and place 
; those into the model’s declarative memory.

; "start", "attend", "respond", "done", "goal" is the name of the different chunks
; "isa chunk" iis the optional declaration of a chunk-type to describe the chunk being created.
; goal = chunk name, isa chunk/read-letters = chunk-type name, state = slot name, start = slot value
(add-dm 
 (start isa chunk) 
 (attend isa chunk)
 (respond isa chunk) 
 (done isa chunk)
 (goal isa read-letters state start))

; -- Creating productions --
; P = production
; find-unattended-letter = production name
; ==> = production condition
(P find-unattended-letter
; specifies a pattern to match to the goal buffer
   =goal>
      ; declarative of the set of slots which are being used in the test
      ISA         read-letters
      ; this first slot test in the pattern has a name = state and a constant
      ; value = start.
      ; For this production to match, the chunk in the goal buffer must have a slot
      ; named state which has the value start.
      state       start
 ==>
 ; "==>" indicates the end of production condition

 ; -- Production actions --
 ; To indicate a particular action to perform with a buffer a symbol is used 
 ; which starts with a character that indicates the action to take, followed by 
 ; the name of a buffer, and then the character ">". That is followed by an 
 ; optional chunk-type declaration using isa and a chunk-type name and then the 
 ; specification of slots and values to detail the action to perform.

 ; If the buffer name is prefixed with the character "+", then the action 
 ; is a request to that buffer’s module, and we will often refer to such an 
 ; action as a “buffer request” where buffer is the name of the buffer indicated 
 ; e.g. a visual-location request. Any buffer request with a “+” action will also 
 ; cause that buffer to be cleared.
 ; This :attended specification is called a request parameter. It acts like a slot 
 ; in the request, but does not correspond to a slot in the chunk which was created. 
 ; A request parameter is valid for any request to a buffer regardless
 ; of any chunk-type that is specified (or when no chunk-type is specified as 
 ; is the case here). Request parameters are used to supply general information to 
 ; the module about a request which may not correspond to any information that 
 ; would be included in a chunk that is placed into a buffer. A request parameter 
 ; is specific to a particular buffer and will always start with a “:” which
 ; distinguishes it from an actual slot of some chunk-type.
   +visual-location>
      ; the :attended request parameter to specify whether the
      ; vision module should try to find the location of an object which the model 
      ; has previously looked at (attended to) or not.
      ; nil = has not attended
      ; t = has attended
      ; new = has never attended
      :attended    nil
   ; If the buffer name is prefixed with the character "=" then the action 
   ; will cause the production to immediately modify the chunk currently in 
   ; that buffer.
   =goal>
      state       find-location
)

(P attend-letter
   =goal>
      ISA         read-letters
      state       find-location
   =visual-location>
   ?visual>
      state       free
==>
   +visual>
      cmd         move-attention
      screen-pos  =visual-location
   =goal>
      state       attend
)

(P encode-letter
   =goal>
      ISA         read-letters
      state       attend
   =visual>
      ; The “=” prefix on a symbol in a production is used to indicate a variable.
      value       =letter
   ?imaginal>
      state       free
==>
   =goal>
      state       respond
   +imaginal>
      isa         array
      letter      =letter
)


(P respond
   =goal>
      ISA         read-letters
      state       respond
   =imaginal>
      isa         array
      letter      =letter
   ?manual>   
      state       free
==>
   =goal>
      state       done
   +manual>
      cmd         press-key
      key         =letter
)
; -- setting the goal --
; The goal-focus command is provided by the goal module to 
; allow the modeler to specify a chunk to place into the goal 
; buffer when the model starts to run.
(goal-focus goal)

)
