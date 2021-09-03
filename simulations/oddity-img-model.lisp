(clear-all)

(define-model oddity
    
(sgp :v t :show-focus t :needs-mouse t :trace-detail high)


(chunk-type see-images state)
(chunk-type array image1 image2 image3 answer position1 position2 position3)

(add-dm 
 (start isa chunk)
 (attend isa chunk)
 (evaluate isa chunk)
 (move-mouse isa chunk)
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
         screen-pos =current-pos
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
         position1 =current-pos
    +visual-location>
         :attended new
)

(P encode-image2
    =goal>
        ISA see-images
        state attend
    =visual>
         value =text
         screen-pos =current-pos
    ?imaginal>
        state free
    =imaginal>
         image1 =val
         position1 =pos1
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         image1 =val
         position1 =pos1
         image2 =text
         position2 =current-pos
         answer =pos1
    +visual-location>
         :attended nil
)

(P encode-image3
    =goal>
        ISA see-images
        state attend
    =visual>
         value =text
         screen-pos =current-pos
    ?imaginal>
        state free
    =imaginal>
         image1 =img1
         position1 =pos1
         image2 =img2
         position2 =pos2
==>
    =goal>
        state evaluate
    +imaginal>
         isa array
         image1 =img1
         position1 =pos1
         image2 =img2
         position2 =pos2
         image3 =text
         position3 =current-pos
)

(P evaluate-if
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =img1
      image2 =img1
      image3 =img3
      position3 =pos3
==>
   =goal>
      state move-mouse
   +imaginal>
      answer =pos3
)

(P evaluate-elif
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =img1
      image2 =img2
      image3 =img1
      position2 =pos2
==>
   =goal>
      state move-mouse
   +imaginal>
      answer =pos2
)

(P evaluate-else
   =goal> 
      isa see-images
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      image1 =img1
      - image2 =img1
      - image3 =img1
      position1 =pos1
==>
   =goal>
      state move-mouse
   +imaginal>
      answer =pos1
)

(P move-mouse
   =goal>
      ISA see-images
      state move-mouse
   =imaginal>
      isa array
      answer =ans
   ?manual>
      state free
==>
   =goal>
      state respond
   +manual>
        isa move-cursor
        loc =ans
)

(P respond
   =goal>
      ISA see-images
      state respond
   ?manual>
      state free
==>
   =goal>
      state done
   +manual>
        cmd click-mouse
)


(goal-focus goal)
)
