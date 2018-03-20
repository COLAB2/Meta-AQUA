## Windows Installation Instructions:

Download and install allegro 10.1 from https://franz.com/products/allegro-common-lisp/

Download and install Emacs https://www.gnu.org/software/emacs/download.html  (optional) (version :25)

Download Meta-Aqua \
	``` $ git clone https://github.com/COLAB2/Meta-AQUA.git ```
  

Direct to the Meta-Aqua director \
	change the paths of the Meta-AQUA directory from the files \
		1. clinit.cl \
		2. .emacs \
		3. loader.lisp \
		4. Nonlin/nonlin-sys-def \
		5. Frame/frame-sys-def \
		6. Tale-spin/tspin-sys-def 

copy .emacs from Meta-Aqua directory to C:/Users/username/AppData/Roaming/ \
copy  clinit.cl from Meta-Aqua directory to C:/Users/username 

Run emacs and press cntrl + x + l \
	answer "y" to compile Meta-AQUA 

After succesfull compilation \
	edit C:/Users/username/clinit.cl and change \
    (setf *do-compile-Meta-AQUA* t) to (setf *do-compile-Meta-AQUA* nil) 
 
Run emacs, pres cntrl + x + l and in the other window \
  press "y" to load meta-aqua \
  and "n" to load windows   

