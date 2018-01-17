;;; -*- Mode: LISP; Syntax: Common-lisp; Package: REPRESENTATIONS; Base: 10 -*-
(in-package :reps)


; utensils (spoons,forks,knives)
(define-frame utensil
  (isa (value (inanimate-object)))
  )

(define-attribute-value CUTTING.0   
  (isa  (value (purpose-value)))
  )  
  
(define-frame robot
  (isa (value (animate-object)))
  (name (value (literal)))
  )
  
(define-frame Knife
	(isa (value (utensil)))
	(purpose (value cutting.0))
	)

(define-attribute-value STICK.0   
  (isa  (value (purpose-value)))
  ) 

	
(define-frame glue
	(isa (value (household-object)))
	(purpose (value stick.0))
	)
	

   
; deaggregater to cut the object(in-animate) into two slices
(define-frame deaggregator
	      (isa (value (mop)))
  (actor (value (robot)))
  (object (value (inanimate-object)))
  (instrumental-scene
    (value (knife
	     (actor (value =actor))
	     (object (value (hand =r
				  (body-part-of (value =actor)))))
	     (from (value (at-location
			    (domain (value =r))
			    (co-domain (value (near
						(domain (value =r))
						(co-domain (value =actor))
						))))))
	     (to (value (at-location
			  (domain (value =r))
			  (co-domain (value (physical-location
					      (domain (value =r))
					      (co-domain (value =object))))))))
	     )))
  (slice1 (value (results
		  (domain (value =object))
		  (co-domain (value =BROKEN.0)))))
  (slice2 (value (results
		  (domain (value =object))
		  (co-domain (value =BROKEN.0)))))
		  
  (main-result (value (physical-state
			(domain (value =object))
			(co-domain (value (=slice1 =slice2))))))
			
(define-attribute-value BROKEN.0
			(isa (value (physical-state-value))))	



; glues two slices			
(define-frame aggregator
	      (isa (value (mop)))
   
  (actor (value (robot)))
  (object (value (=BROKEN.0 =BROKEN.0)))
  (instrumental-scene
    (value (glue
	     (actor (value =actor))
	     (object (value (hand =r
				  (body-part-of (value =actor)))))
	     (from (value (at-location
			    (domain (value =r))
			    (co-domain (value (near
						(domain (value =r))
						(co-domain (value =actor))
						))))))
	     (to (value (at-location
			  (domain (value =r))
			  (co-domain (value (physical-location
					      (domain (value =r))
					      (co-domain (value =object))))))))
	     )))
  (main-result (value (physical-state
			(domain (value =object))
			(co-domain (value square))))))