(clear-all)

(define-model oddity
    
(sgp :v t :show-focus t :needs-mouse t)


(chunk-type see-images state)
(chunk-type array image1 image2 image3 temp answer position1 position2 position3)

(add-dm 
 (start isa chunk)
 (attend isa chunk)
 (evaluate isa chunk)
 (respond isa chunk)
 (done isa chunk)
 (goal isa see-images state start))

(P find-unattended-image
    =goal>
      ISA see-images
      state start
    ?imaginal>
      state free
==>
    +visual-location>
        :attended nil
    =goal>
        state find-location
    +imaginal>
         image1 nil
)

(P attend-image
    =goal>
        ISA see-images
        state find-location
    =visual-location>
    ?visual>
        state free
    ?manual>
        state free
==>
    +visual>
        isa move-attention
        cmd move-attention
        screen-pos =visual-location
    =goal>
        state attend
    +manual>
       isa move-cursor
       loc =visual-location
)

(P encode-image1
    =goal>
        ISA see-images
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
        image1 nil
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         image1 =text
         position1 =pos
    +visual-location>
         :attended new
)

(P encode-image2
    =goal>
        ISA see-images
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
         image1 =val
         position1 =position1
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         image1 =val
         position1 =position1
         image2 =text
         position2 =pos
         answer =position1
    +visual-location>
         :attended nil
)

(P encode-image3
    =goal>
        ISA see-images
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
         image1 =l1
         position1 =position1
         image2 =l2
         position2 =position2
==>
    =goal>
        state evaluate
    +imaginal>
         isa array
         image1 =l1
         position1 =position1
         image2 =l2
         position2 =position2
         image3 =text
         position3 =pos
         temp =position1
)

(P evaluate-if
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =l1
      image2 =l1
      temp =l1
      image3 =l3
      position3 =position3
==>
   =goal>
      state respond
   +imaginal>
      answer =position3
)

(P evaluate-elif
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =l1
      image2 =l2
      temp =l1
      image3 =l1
      position2 =position2
==>
   =goal>
      state respond
   +imaginal>
      answer =position2
)

(P evaluate-else
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =l1
      - image2 =l1
      - image3 =l1
      position1 =position1
==>
   =goal>
      state respond
   +imaginal>
      answer =position1
)

(P respond
   =goal>
      ISA see-images
      state respond
   =imaginal>
      isa array
      answer =ans
   ?manual>
      state free
==>
   =goal>
      state done
   +manual>
        isa move-cursor
        loc =ans
)

(goal-focus goal)
)
