(clear-all)

(define-model count

; sgp is used to set parameters for the model
(sgp :esc t :lf .05 :trace-detail high)

; The number chunk-type specifies the slots that will be used to 
; encode the ordering of numbers.
; The chunk contains a slot number which is the current number and a slot next,
; which indicates the next number.
(chunk-type number number next)
; The count-from chunk type specifies the slots that will be
; used for the goal buffer chunk of the model, and it has slots to hold the starting number, the
; ending number, and the current count.
(chunk-type count-from start end count)

; Initial knowledge in the model's declarative memory
(add-dm
 (one ISA number number one next two)
 (two ISA number number two next three)
 (three ISA number number three next four)
 (four ISA number number four next five)
 (five ISA number number five)
 (first-goal ISA count-from start two end four))

; The goal-focus command is provided by the goal module to allow the modeler to specify a
; chunk to place into the goal buffer when the model starts to run
(goal-focus first-goal)

; This production checks whether there is a number in the start slot.
; The start slot is bound to a variable num1.
; In addition, the production checks if the count is nil (i.e., null). This ensure that
; the count slot does not exist in the goal buffer
(p start
   =goal>
      ISA         count-from
      ; the value in start is bound to the variable num1
      start       =num1
      count       nil
 ==>
   ; When the conditions above is satisfied, the production perform two actions.
   ; (1) adds a slot called count in the goal buffer since it does not exist yet.
   ; This slot is bound to the variable num1
   =goal>
      ISA         count-from
      count       =num1
   ; (2) a retrieval request. That request asks the declarative module to find a chunk that
   ; has the value which is bound to =num1 in its number slot and place that chunk into the retrieval buffer.  
   +retrieval>
      ISA         number
      number      =num1
   )

; This production test both the goal buffer and the retrieval buffer.
(P increment
   =goal>
      ISA         count-from
      count       =num1
      ; The "-" in front of a slot means that the following test must not be True for the
      ; test to be sucessful. This test is checking if the end slot does not have the same value as the
      ; count slot. 
    - end         =num1
   ; The retrieval buffer test checks that there is a chunk in the retrieval buffer which has a value in
   ; its number slot that matches the current count slot from the goal buffer chunk and binds the
   ; variable =num2 to the value of its next slot:
   =retrieval>
      ISA         number
      number      =num1
      next        =num2
 ==>
   ; Actions are similar to the ones in the start production.
   ; It modifies the chunk in the goal buffer to change the value of the count slot to the next number, 
   ; which is the value of the next slot of the chunk in the retrieval buffer, and it makes a retrieval 
   ; request to get the chunk representing that next number. 
   =goal>
      ISA         count-from
      count       =num2
   +retrieval>
      ISA         number
      number      =num2
   ; !output! (pronounced bang-output-bang) can be used on the RHS of a production to display
   ; information in the trace. It may be followed by a single item or a list of items, and the given
   ; item(s) will be printed in the trace when the production fires. In this production it is used to
   ; display the numbers as the model counts.
   !output!       (=num1)
   )

(P stop
   ; The stop production matches when the values of the count and end slots of the chunk in the goal
   ; buffer are the same and they also match the value in the number slot of the chunk in the retrieval buffer. 
   =goal>
      ISA         count-from
      count       =num
      end         =num
   =retrieval>
      ISA         number
      number      =num
 ==>
   ; Clear the goal buffer
   -goal>
   !output!       (=num)
   )
)
