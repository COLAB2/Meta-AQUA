
;;; -*- Mode: LISP; Syntax: Common-lisp; Package: REPRESENTATIONS; Base: 10 -*-
(in-package :reps)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;	      Meta-AQUA Background Knowledge Represented as Frames
;;;;
;;;;	    Copyright (C) 2018   Sampath Gogineni  (sampath.gogineni@gmail.com)
;;;;
;;;;
;;;;                           File: rep_mine.lisp
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

; Definition of mine as a physical object
 (define-frame mine
     (isa (value (physical-object)))
   )

; definition of pilot
(define-frame pilot
    (isa (value (person)))
  )

; ship to be broken into two parts 
 (define-frame BROKEN
	(isa (value (physical-object))))

; definition of a ship with an actor and carrying a physical object
 (define-frame ship
     (isa (value (animate-object)))
     (actor (value (pilot)))
     (contains (value (physical-object)))
     )

; qroute as a physical location
(define-frame qroute
    (isa (value (physical-location)))
  )

;clear area
(define-frame clear-area
    (isa (value (physical-location)))
  )

;mine-area
(define-frame mine-area
    (isa (value (physical-location)))
   (contains 
    (value (mine)))
   )

;move to clear area
 (define-frame move-to-clear-area
    (isa (value (mop)))
   (actor (value (animate-object)))
   (ptrans 
	   (actor (value =actor))
	    (from (value (at-location
			  (domain (value =actor))
			  (co-domain (value
				      (outside
				       (domain (value =actor))
				       (co-domain (value (clear-area)))))))))
	    (to (value (at-location
			(domain (value =actor))
			(co-domain (value
				    (inside
				     (domain (value =actor))
				     (co-domain (value (clear-area))))))))
	    )
	  )
   )

;move to mine area
 (define-frame move-to-mine-area
    (isa (value (mop)))
   (actor (value (animate-object)))
   (ptrans 
	   (actor (value =actor))
	    (from (value (at-location
			  (domain (value =actor))
			  (co-domain (value
				      (outside
				       (domain (value =actor))
				       (co-domain (value (mine-area)))))))))
	    (to (value (at-location
			(domain (value =actor))
			(co-domain (value
				    (inside
				     (domain (value =actor))
				     (co-domain (value (mine-area))))))))
	    )
	  )
	  
   )

;state of mine at qroute
(define-frame mine-at-qroute
    (isa (value (mop)))
    (object
     (value (physical-object)))
    (value  (physical-location
	     (domain
	       (value =object))
		 (co-domain
		  (value (clear-area)))))
    )

; State of mine at clear area
(define-frame mine-at-clear-area
    (isa (value (mop)))
    (object
     (value (physical-object)))
    (value  (physical-location
	     (domain
	       (value =object))
		 (co-domain
		  (value (clear-area)))))
    )

; leave the physical object at qroute and return to hiding place
 (define-frame LEAVE-QROUTE
	      (isa (value (mop)))
  (actor
    (value (animate-agent)))
  (object
    (value (physical-device)))

 (goal-scene
    (value (ptrans
	     (actor
	       (value =actor))
	     (object
	      (value =object))
	      (from (value (at-location
			  (domain (value =actor))
			  (co-domain (value
				      (inside
				       (domain (value =actor))
				       (co-domain (value (clear-area)))))))))
	     (to
	       (value (physical-location
		       (domain
			   (value =actor))
			   (co-domain
			    (value (hiding-place)))
			   )
		      )
	       )
	     )
	   )
    )
  
  (scenes
    (value (=goal-scene)))
  )

; Head towards the qroute from hiding place with a ship to qroute and place a mine there.
 (define-frame lay-mine 
     (isa (value (mop)))
  (actor
    (value (pilot)))
  (object
    (value (physical-object)))
  (instrumental-object
   (value (ship
	   (actor 
	    (value =actor))
	  (contains 
	    (value =object))
	   )))
  
 (goal-scene
    (value (ptrans
	     (actor
	       (value =actor))
	     (object
	      (value =instrumental-object))
	      (from (value (at-location
			  (domain (value =actor))
			  (co-domain (value
				      (outside
				       (domain (value =actor))
				       (co-domain (value (clear-area)))))))))
	     (to
	       (value (at-location
			(domain
			  (value =instrumental-object))
			(co-domain
			  (value (physical-location
				   (domain
				     (value =instrumental-object))
				   (co-domain
				     (value (clear-area))))))))))))
  (post-completion-scene
    (value (leave-qroute
	     (actor
	       (value =instrumental-object))
	     (object
	       (value =object)))))
  (scenes
   (value (=goal-scene =post-completion-scene)))
  
  (main-result (value (results 
		       (value (mine-at-clear-area
				       (object (value =object))))))
		)
  )



; Explanation that says why a mine is at qroute
  (define-frame mine-explanator
	      (isa (value (xp)))
  (actor (value (pilot)))
  (object (value (mine)))
  (ante (value (lay-mine
		(actor (value =actor))
                (instrumental-object
		 (value  (ship
			  (actor 
			   (value =actor))
			    (contains 
			     (value =object))
			    ))
		))))
  (conseq (value (mine-at-clear-area
		  (object (value (object))))))
  
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


; Explanation to say why mine is a threat
  
 (define-frame explosion-scene
    (isa (value (VIOLENT-MOP)))
    (actor
     (value (animate-object)))
    (object
     (value (mine)))
    (goal-scene
    (value (ptrans
	     (actor
	       (value =actor))
	     (object
	       (value =object))
	     (to
	       (value (at-location
			(domain
			  (value =actor))
			(co-domain
			 (value =object))))))))
    
    (part1 (value (results
		   (domain (value =actor))
		   (co-domain (value (broken))))))
    
    (post-completion-scene
     (value =part1))
    
    
    (scenes
     (value (=goal-scene =post-completion-scene)))
    )


; Explanation that says why a mine  at a qroute is a threat (because it causes explosion) 
  (define-frame threat
	      (isa (value (xp)))
  (actor (value (ship)))
  (object (value (mine)))
 
  (ante (value (mine-at-qroute
		(object (value =object)))))
  (conseq (value (explosion-scene
		  (actor (value =actor))
		  (object
		   (value =object)
		   ))))
  
  (antecedent (value =ante))
  (consequent (value =conseq))
  (role (value (actor
		 (domain (value =conseq))
		 (co-domain (value =actor)))))
  (explains (value =role))
  (pre-xp-nodes (value (=actor =conseq =role)))
  (internal-nodes (value nil.0))
  (xp-asserted-nodes (value (=ante =object)))
  (link1 (value (results       
		  (domain (value =ante))
		  (co-domain (value =conseq)))))
  (links (value (=link1)))
  )


    
	     