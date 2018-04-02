;;; -*- Mode: LISP; Syntax: Common-lisp; Package: REPRESENTATIONS; Base: 10 -*-
(in-package :reps)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;	      Meta-AQUA Background Knowledge Represented as Frames
;;;;
;;;;	    Copyright (C) 2018   Sampath Gogineni  (sampath.gogineni@gmail.com)
;;;;
;;;;
;;;;                           File: rep_cut.lisp
;;;;
;;;;
;;;;	      *******************************************************
;;;
;;; This  program is  free  software; you can redistribute it and/or  modify it
;;; under the terms  of the GNU General Public License as published by the Free
;;; Software  Foundation;  either  version  1,  or  (at  your option) any later
;;; version.
;;; 
;;; This program is distributed in the hope that it will be useful, but WITHOUT
;;; ANY WARRANTY; without  even the  implied  warranty  of  MERCHANTABILITY  or
;;; FITNESS FOR  A PARTICULAR PURPOSE.  See the GNU General Public  License for
;;; more details.
;;; 
;;; You should  have received a copy of  the  GNU  General Public License along
;;; with this program; if not, write to the Free Software Foundation, Inc., 675
;;; Mass Ave, Cambridge, MA 02139, USA.  In emacs type C-h C-w to view license.
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;table to place knife
(define-frame table
    (isa (value (inanimate-object))))

; utensils (spoons,forks,knives)
(define-frame utensil
  (isa (value (inanimate-object)))
  )

(define-attribute-value CUTTING.0   
  (isa  (value (purpose-value)))
  )  

; robot definition
(define-frame robot
  (isa (value (animate-object)))
  (name (value (literal)))
  )

; name of the robot NEO
(define-attribute-value NEO
    (isa (value (robot))
	 (name (value = "neo"))
       ))

; definition of knife
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



; Leave the knife on table after cutting
(define-frame LEAVE-ON-TABLE
	      (isa (value (mop)))
  (actor
    (value (volitional-agent)))
  (object
    (value (physical-device)))
 (goal-scene
    (value (ptrans
	     (actor
	       (value =actor))
	     (object
	       (value =object))
	     (to
	       (value (at-location
			(domain
			  (value = object))
			(co-domain
			  (value (physical-location
				   (domain
				     (value = object))
				   (co-domain
				     (value = table)))))))))))
  
  (scenes
    (value (=goal-scene)))
  )
	
; cut a block with the knife
 (define-frame CUT-OBJECT 
	      (isa (value (mop)))
  (actor
    (value (volitional-agent)))
  (object
    (value (physical-object)))
  (instrumental-object
    (value (knife)))
  (instrumental-scene
    (value (gain-control-of
	     (actor
	       (value =actor))
	     (object
	       (value =instrumental-object)))))

  (goal-scene
    (value (ptrans
	     (actor
	       (value =actor))
	     (object
	       (value =instrumental-object))
	     (to
	       (value (at-location
			(domain
			  (value =instrumental-object))
			(co-domain
			  (value (physical-location
				   (domain
				     (value =instrumental-object))
				   (co-domain
				     (value =object)))))))))))
  (post-completion-scene
    (value (leave-on-table
	     (actor
	       (value =actor))
	     (object
	       (value =instrumental-object)))))
  (scenes
    (value (=instrumental-scene =goal-scene =post-completion-scene)))
  )
  
; Explanation that says the two slices of the block are cut by robot with a knife
 (define-frame deaggregator
	      (isa (value (xp)))
  (actor (value (neo)))
  (object (value (inanimate-object)))
  (ante (value (cut-object
		(actor (value =actor))
		(instrumental-object
		 (value (knife)))
		)))
  (conseq (value =slice1 =slice1))
  
  (slice1 (value (results
		  (domain (value =object))
		  (co-domain (value =BROKEN.0)))))
  (antecedent (value =ante))
  (consequent (value =conseq))
  (role (value (actor
		 (domain (value =conseq))
		 (co-domain (value =actor)))))
  (explains (value =role))
  (pre-xp-nodes (value (=actor =conseq =object =role)))
  (internal-nodes (value nil.0))
  (xp-asserted-nodes (value (=ante)))
  (link1 (value (results       
		  (domain (value =ante))
		  (co-domain (value =conseq)))))
  (links (value (=link1)))
  )
  
  
  
			
 (define-attribute-value BROKEN.0
			(isa (value (physical-state-value))))	




; glues two slices
;yet to complete
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
