(add-to-list 'load-path "/var/lib/myfrdcsa/codebases/minor/nlu/frdcsa/emacs")

(global-set-key "\C-crerk" 'nlu-edit-rules)

(make-local-variable 'nlu-lock-state)

(define-derived-mode nlu-mode
 text-mode "NLU"
 "Major mode for asserting knowledge about text.
\\{nlu-mode-map}"
 (setq case-fold-search nil)
 (define-key nlu-mode-map "cb" 'clear-queue-current-buffer-referent)

 (define-key nlu-mode-map "ll" 'nlu-lookup-item-extensively)
 (define-key nlu-mode-map "ln" 'nlu-push-n-words-onto-stack)
 (define-key nlu-mode-map "tn" 'nlu-toggle-navigation)
 (define-key nlu-mode-map "tt" 'nlu-see-tags-at-point)
 (define-key nlu-mode-map "tT" 'nlu-see-properties-at-point)
 (define-key nlu-mode-map "tp" 'nlu-add-tag-to-region)
 (define-key nlu-mode-map "tPi" 'nlu-add-isa-tag-to-region)
 (define-key nlu-mode-map "tmr" 'nlu-remove-tag-at-point)
 (define-key nlu-mode-map "tmt" 'nlu-remove-tags-from-region)
 (define-key nlu-mode-map "tmn" 'nlu-remove-non-tags-from-region)
 (define-key nlu-mode-map "tme" 'nlu-remove-properties-from-region)
 (define-key nlu-mode-map "tq" 'nlu-reset-buffer)

 (define-key nlu-mode-map "tA" 'nlu-analyze-region)
 (define-key nlu-mode-map "ta" 'nlu-analyze-region-light)
 (define-key nlu-mode-map "tosa" 'nlu-analyze-tos)
 (define-key nlu-mode-map "tg" 'nlu-ghost-buffer)
 (define-key nlu-mode-map "tr" 'nlu-reset)
 (define-key nlu-mode-map "tR" 'nlu-reset-tags)
 (define-key nlu-mode-map "t." 'nlu-see-tag-at-point)
 (define-key nlu-mode-map "ti" 'nlu-push-most-interesting-tag-at-point-onto-stack)
 (define-key nlu-mode-map "t>" 'nlu-push-tag-at-point-onto-stack)
 (define-key nlu-mode-map "t," 'nlu-get-tag-at-point-test)
 (define-key nlu-mode-map "tw" 'nlu-tag-word-sense)

 (define-key nlu-mode-map "\M-e" 'nlu-forward-sentence)
 (define-key nlu-mode-map "\M-a" 'nlu-backward-sentence)

 (define-key nlu-mode-map "q" 'quit-window)
 (suppress-keymap nlu-mode-map)
 )

(global-set-key "\C-c\C-k\C-vve" 'nlu-load-windows)

(define-derived-mode nlu-ghost-mode
 nlu-mode "NLU-Ghost"
 "Major mode for asserting knowledge about text ghost.
\\{nlu-ghost-mode-map}"
 (setq case-fold-search nil)
 ;; (define-key nlu-ghost-mode-map "cb" 'clear-queue-current-buffer-referent)
 (nlu-read-only t)
 (define-key nlu-ghost-mode-map "ts" 'nlu-ghost-save-with-properties-and-tags)
 )

(global-set-key "\C-cnll" 'nlu-lookup-item-extensively)
(global-set-key "\C-cnln" 'nlu-push-n-words-onto-stack)
(global-set-key "\C-cntn" 'nlu-toggle-navigation)
(global-set-key "\C-cntt" 'nlu-see-tags-at-point)
(global-set-key "\C-cntT" 'nlu-see-properties-at-point)
(global-set-key "\C-cntp" 'nlu-add-tag-to-region)
(global-set-key "\C-cntPi" 'nlu-add-isa-tag-to-region)
(global-set-key "\C-cntmr" 'nlu-remove-tag-at-point)
(global-set-key "\C-cntmt" 'nlu-remove-tags-from-region)
(global-set-key "\C-cntmn" 'nlu-remove-non-tags-from-region)
(global-set-key "\C-cntme" 'nlu-remove-properties-from-region)
(global-set-key "\C-cntq" 'nlu-reset-buffer)

(global-set-key "\C-cntA" 'nlu-analyze-region)
(global-set-key "\C-cnta" 'nlu-analyze-region-light)
(global-set-key "\C-cntb" 'nlu-analyze-buffer)
(global-set-key "\C-cntos" 'nlu-analyze-tos)
(global-set-key "\C-cntg" 'nlu-ghost-buffer)
(global-set-key "\C-cntr" 'nlu-reset)
(global-set-key "\C-cntR" 'nlu-reset-tags)
(global-set-key "\C-cnt." 'nlu-see-tag-at-point)
(global-set-key "\C-cnti" 'nlu-push-most-interesting-tag-at-point-onto-stack)
(global-set-key "\C-cnt>" 'nlu-push-tag-at-point-onto-stack)
(global-set-key "\C-cnt," 'nlu-get-tag-at-point-test)
(global-set-key "\C-cntw" 'nlu-tag-word-sense)
(global-set-key "\C-crepf" 'nlu-edit-nlu-manual-formalization-queue)

(global-set-key "\C-cn\M-e" 'nlu-forward-sentence)
(global-set-key "\C-cn\M-a" 'nlu-backward-sentence)

(defvar nlu-display-tags-mode t)

(defvar nlu-navigation-on nil)
(setq nlu-property-header "x-nlu-")

(defun nlu-reset ()
 "Resets the tags in the buffer"
 (interactive)
 (nlu-reset-tags)
 (nlu-reset-buffer))

(defun nlu-reset-tags ()
 "Resets the tags in the buffer"
 (interactive))

(defun nlu-see-tags-at-point ()
 "List the tags for the current point of text"
 (interactive)
 (nlu2-tags-viewer-show-tags-at-point (nlu-tags (text-properties-at (point)))))

;; (defun nlu2-tags-viewer-show-tags-at-point ()
;;  "List the tags for the current point of text"
;;  (interactive)
;;  ;;(message (elisp-format-string (prin1-to-string (nlu-tags (text-properties-at (point)))))))
;;  (let* ((tags (nlu-tags (text-properties-at (point))))
;; 	(valuestrings (plist-values tags)))
;;   (message (elisp-format-string (prin1-to-string valuestrings)))))

;; (defun nlu-show-tags (plist)
;;  "Convert from the raw tags format to the output"
;;  ;; first, get just the keys
;;  (dolist (value (plist-values plist))
;;   (see value)))

(defun nlu-add-tag-to-region (&optional prop-arg)
 "Annotation a text with a tag"
 (interactive)
 (let* ((prop
	 (or
	  prop-arg
	  (read
	   (completing-read
	    "Tag?: "
	    (mapcar
	     (lambda (item) (prin1-to-string item))
	     nlu-tag-suite-entries))))))
  (nlu-add-tag (mark) (point) prop prop)))

(defun nlu-add-spanlist (start spanlist)
 "Add all spans to text"
 (dolist (span spanlist) 
  (nlu-add-tag (+ (nth 0 span) start) (+ (nth 1 span) start) (eval (nth 2 span)) (eval (nth 2 span))))
 (if nlu-display-tags-mode
  (nlu-redisplay-text-with-tags-emphasized))
 )

(defun nlu-add-tag (start end prop value)
 ""
 (if (derived-mode-p 'nlu-ghost-mode)
  (nlu-unlock-temporarily-and-execute
   '(put-text-property start end (make-symbol (concat nlu-property-header (prin1-to-string prop))) t))))

;; (nlu-strip-property-header 'x-nlu-test)

(defun nlu-strip-property-header (prop)
 "interactive"
 (read (nlu-strip-property-header-to-string prop)))

(defun nlu-strip-property-header-to-string (prop)
 "interactive"
 (substring (format "%s" prop) (length nlu-property-header)))
(defun nlu-tags (plist)
 (let* ((newplist nil))
  (dolist (key (plist-keys plist))
   (if (string= (substring (prin1-to-string key) 0 (min (length (prin1-to-string key)) (length nlu-property-header))) nlu-property-header)
    (progn 
     (push (plist-get plist key) newplist)
     (push key newplist)
     )
    )
   )
  newplist))

(defun nlu-non-tags (plist)
 (let* ((newplist nil))
  (dolist (key (plist-keys plist))
   (if (not (string= (substring (prin1-to-string key) 0 (min (length (prin1-to-string key)) (length nlu-property-header))) nlu-property-header))
    (progn 
     (push (plist-get plist key) newplist)
     (push key newplist)
     )
    )
   )
  newplist))

(defun plist-keys (plist)
 "Return the plist's keys"
 (let ((newlist nil))
  (while plist
   (shift plist)
   (push (shift plist) newlist)
   )
  newlist))

(defun plist-values (plist)
 "Return the plist's keys"
 (let ((newlist nil))
  (while plist
   (push (shift plist) newlist)
   (shift plist)
   )
  newlist))

;;   (backward-paragraph)

;;   ;; get the position
;;   (forward-paragraph)
;;   (let* (
;; 	 ;; have an offset value corresponding to the text
;; 	 (start (progn (backward-paragraph) (set-mark (point)) (prin1-to-string (point))))
;; 	 (end (progn (forward-paragraph) (prin1-to-string (point))))
;; 	 ;; create a new theory for this item
;; 	 (context (concat "Org::FRDCSA::NLU::Buffer::" (buffer-name)))
;; 	 (filename (make-temp-file "nlu-"))
;; 	 )

(defun nlu-region-min (&optional mark-arg point-arg)
 (let* ((mark (if mark-arg mark-arg (mark)))
	(point (if point-arg point-arg (point)))
	)
  (min mark point)))

(defun nlu-region-max (&optional mark-arg point-arg)
 (let* ((mark (if mark-arg mark-arg (mark)))
	(point (if point-arg point-arg (point)))
	)
  (max mark point)))

(defun nlu-test ()
 ""
 (interactive)
 (see
  (uea-query-agent-raw "echo hi" "NLU")))

(defun nlu-analyze-region (&optional mark-arg point-arg light)
 "Take a text region and perform the NLU analysis on it"
 (interactive "r")
 (setq debug-on-error t)
 ;; change this to read, if buffer is non-ghost, make it ghost
 (if (not (derived-mode-p 'nlu-ghost-mode))
  (nlu-ghost-buffer))
 (save-excursion
  (let* (
	 ;; have an offset value corresponding to the text
	 ;; create a new theory for this item
	 (context (concat "Org::FRDCSA::NLU::Buffer::" (buffer-name)))
	 (filename (make-temp-file "nlu-"))
	 (light-var (if light light 0))
	 (point (if point-arg point-arg (point)))
	 (mark (if mark-arg mark-arg (mark)))
	 ;; (temp (progn (see (list point mark)) 5))
	 (start (prin1-to-string (nlu-region-min mark point)))
	 (end (prin1-to-string (nlu-region-max mark point)))
	 )
   ;; write the contents to a file, run the nlu system on it, adding
   ;; information such as which file it came from, so on and so forth
   (write-region mark point filename)
   (let*
    ((message 
      (uea-query-agent-raw nil "NLU"
       (freekbs2-util-data-dumper
	(list
	 (cons "_DoNotLog" 1)
	 (cons "Database" "freekbs2")
	 (cons "Context" context)
	 (cons "All" 1)
	 (cons "Run" 1)
	 (cons "File" filename)
	 (cons "Emacs" 1)
	 (cons "Start" start)
	 (cons "End" end)
	 (cons "Light" light-var)
	 )
	)
       )
      )
     (view message)
     (result
      (assoc "Result"
       (freekbs2-util-data-dedumper
     	(nth 5 message))))
     (tobeevaled
      (if (non-nil 'result)
       (cdr result)
       ""))
     )
    ;; (message (prin1-to-string message))
    ;; (message (prin1-to-string tobeevaled))
    (if (string-match "nlu-add-spanlist" tobeevaled)
     (progn
      (nlu-store-lock-state)
      ;; (see (read tobeevaled))
      (eval (read tobeevaled))
      (nlu-restore-lock-state)
      )
     ;; (message (concat "message = " tobeevaled))
     )
    )
   )
  )
 )

(defun nlu-analyze-region-light (&optional mark-arg point-arg)
 "Take a text region and perform a weaker NLU analysis on it"
 (interactive "r")
 (nlu-analyze-region mark-arg point-arg 1)
 )

;; have the option for running only those results which are near instantaneous

(defun nlu-make-tag-for-object (object)
 ""
 (make-symbol object))

(defvar nlu-predicate-priorities 
 '(("timex3-date" . 40000)
   ("noun-phrase" . 30000)
   ("word-sense-disambiguation" . 20000)
   ("matches-pattern" . 10000)
   ("has-string" . 5000)
   ))

;; (cdr (assoc "fdsf" nlu-predicate-priorities))

(defun nlu-sort-formulae-by-interest (formula1 formula2)
 ""
 (let* ((f1t (cdr (assoc (car formula1) nlu-predicate-priorities)))
	(f2t (cdr (assoc (car formula2) nlu-predicate-priorities)))
	(f1p (or f1t 0))
	(f2p (or f2t 0))
	)
  (if (= f1p f2p)
   ;; do something here with sorting based on other properties than just the predicate
   t 
   (> f1p f2p))
  )
 )

(defun nlu-formula-to-tagname (formula)
 "Convert from a lisp object which is a formula to a tag"
 (prin1-to-string (make-symbol (concat nlu-property-header (prin1-to-string formula)))))

(defun nlu-tagname-to-formula (tagname)
 "Convert from a tagname to lisp object which is a formula"
 (let ((printed (prin1-to-string tagname t)))
  (read (substring printed (length nlu-property-header) (length printed)))))

(defun nlu-tagname-to-string (tagname)
 (interactive)
 (let ((printed (prin1-to-string (read tagname) t)))
  (substring printed (length nlu-property-header) (length printed))))

(defun nlu-string-to-tagname (string)
 (interactive)
 (prin1-to-string (make-symbol (concat nlu-property-header string))))

(defun nlu-get-most-interesting-tag-at-point (&optional skip)
 "According to a particular ordering of interesting"
 (interactive)
 (if (not skip)
  (nlu-ensure-text-surrounding-point-has-tags))
 (let* (
	(tags (nlu-tags (text-properties-at (point))))
	;; (debug-1 (see tags))
	(formulae (mapcar (lambda (symbol) (nlu-tagname-to-formula symbol)) (plist-keys tags)))
	;; (debug-2 (see formulae))
	(list (sort formulae 'nlu-sort-formulae-by-interest))
	)
  ;; FIXME make sure that this is the correct usage of "tag" or set up some proper terminology
  (if (non-nil list)
   (nlu-get-tag (nlu-formula-to-tagname (car list)))
   (error "no tag at point"))))

(defun nlu-ensure-text-surrounding-point-has-tags ()
 ""
 (if (nlu-text-at-point-has-no-tags) 
  (nlu-analyze-text-at-point)))

(defun nlu-analyze-text-at-point ()
 ;; for now, just move to the beginning of the sentence, and the end
 ;; of the sentence, then analyze the region
 ;; check if the buffer is read only, if so, ask if 
 (let ((mark (save-excursion
	      (backward-sentence 1)
	      (point)))
       (point (save-excursion
	       (forward-sentence 1)
	       (point))))
  (nlu-analyze-region-light mark point)
  )
 )

(defun nlu-analyze-text-at-point-original ()
 ;; for now, just move to the beginning of the sentence, and the end
 ;; of the sentence, then analyze the region
 ;; check if the buffer is read only, if so, ask if 
 (save-excursion
  (backward-sentence 1)
  (set-mark (point))
  (forward-sentence 1)
  (nlu-analyze-region-light)
  )
 )

(defun nlu-see-tag-at-point ()
 ""
 (interactive)
 (see (nlu-get-tag-at-point)))

(defun nlu-push-tag-at-point-onto-stack (arg)
 ""
 (interactive "P")
 (freekbs2-push-onto-stack (nlu-get-tag-at-point) arg))

(defun nlu-get-tagname-at-point ()
 "Get the tagname at point"
 (interactive)
 (let* (
	(tags (nlu-tags (text-properties-at (point))))
	(tagnames (mapcar (lambda (symbol) (prin1-to-string symbol)) (plist-keys tags)))
	(strings (mapcar (lambda (tagname) (nlu-tagname-to-string tagname)) tagnames))
	(string (if (> (length strings) 1) 
		 (completing-read "Choose String: " strings)
		 (if (= (length strings) 1)
		  (car strings)
		  "")))
	(tagname (nlu-string-to-tagname string))
	)
  (if (> (length tagname) 0)
   tagname
   nil)))

(defun nlu-get-tagname-at-point-original ()
 "Get the tagname at point"
 (let* (
	(tags (nlu-tags (text-properties-at (point))))
	(valuestrings (mapcar (lambda (symbol) (prin1-to-string symbol)) (plist-keys tags)))
	(tagname (if (> (length valuestrings) 1) 
		  (completing-read "Choose Tag: " valuestrings)
		  (if (= (length valuestrings) 1)
		   (car valuestrings)
		   "")))
	)
  (if (> (length tagname) 0)
   tagname
   nil)))

(defun nlu-get-tag-at-point ()
 ""
 (interactive)
 ;; first get a list of the tags at point
 (let* ((tagname (nlu-get-tagname-at-point)))
  (if tagname
   (nlu-get-tag tagname)
   (message "ERROR: No tags found for point"))))

(defun nlu-get-tag-at-point-test ()
 ""
 (interactive)
 (see (nlu-text-at-point-has-tag nlu-current-tagname)))

(defun nlu-get-tag (tagname)
 ""
 (save-excursion
  (nlu-back-to-beginning-of-tag tagname)
  (set-mark (point))
  ;; (see (point))
  (nlu-forward-to-ending-of-tag tagname)
  ;; (see (point))
  (buffer-substring-no-properties (point) (mark))))

;; (see (nlu-text-at-point-has-no-tags))

(defun nlu-text-at-point-has-no-tags ()
 "Determine whether or not the text has nlu tags, presumably to
 determine whether to run nlu-analyze-region on it"
 (interactive)
 (not (> (length (nlu-tags (text-properties-at (point)))) 0)))

(defun nlu-screwed-up-plist-to-alist (plist)
 (let ((newlist nil))
  (while plist
   (unshift (cons (prin1-to-string (pop plist)) (list (pop plist))) newlist)
   )
  newlist))

(defun nlu-text-at-point-has-tag (tagname)
 "Determine if the text at point has the tag by tagname"
 (let* (
	(tags (nlu-tags (text-properties-at (point))))
	(alist (nlu-screwed-up-plist-to-alist tags))
	(matches (assoc tagname alist))
	)
  (> (length matches) 0)))

(defun nlu-back-to-beginning-of-tag (tagname)
 "Move backward to the beginning of a tag"
 (while
  (nlu-text-at-point-has-tag tagname)
  (backward-char))
 (forward-char))

(defun nlu-forward-to-ending-of-tag (tagname)
 "Move forward to the end of a tag"
 (while
  (nlu-text-at-point-has-tag tagname)
  (forward-char)))

;; navigational aids

(defun nlu-forward-char (&optional num)
 "Forward char but displaying the nlu-tags at point in the minibuffer"
 (interactive "p")
 (forward-char num)
 (nlu2-tags-viewer-show-tags-at-point))

(defun nlu-backward-char (&optional num)
 "Forward char but displaying the nlu-tags at point in the minibuffer"
 (interactive "p")
 (backward-char num)
 (nlu2-tags-viewer-show-tags-at-point))

(defun nlu-previous-line (&optional num)
 "Forward char but displaying the nlu-tags at point in the minibuffer"
 (interactive "p")
 (forward-line (* -1 num))
 (nlu2-tags-viewer-show-tags-at-point))

(defun nlu-next-line (&optional num)
 "Forward char but displaying the nlu-tags at point in the minibuffer"
 (interactive "p")
 (next-line num)
 (nlu2-tags-viewer-show-tags-at-point))

(defun nlu-toggle-navigation ()
 "Switch between normal navigation bindings and nlu navigation bindings"
 (interactive)
 (if nlu-navigation-on
  (progn
   (define-key nlu-mode-map "\C-f" 'forward-char)
   (define-key nlu-mode-map "\C-b" 'backward-char)
   (define-key nlu-mode-map "\C-n" 'next-line)
   (define-key nlu-mode-map "\C-p" 'previous-line)
   (define-key nlu-mode-map (kbd "<right>") 'right-char)
   (define-key nlu-mode-map (kbd "<left>") 'left-char)
   (define-key nlu-mode-map (kbd "<down>") 'next-line)
   (define-key nlu-mode-map (kbd "<up>") 'previous-line)
   (message "NLU navigation off")
   )
  (progn
   (define-key nlu-mode-map "\C-f" 'nlu-forward-char)
   (define-key nlu-mode-map "\C-b" 'nlu-backward-char)
   (define-key nlu-mode-map "\C-n" 'nlu-next-line)
   (define-key nlu-mode-map "\C-p" 'nlu-previous-line)
   (define-key nlu-mode-map (kbd "<right>") 'nlu-forward-char)
   (define-key nlu-mode-map (kbd "<left>") 'nlu-backward-char)
   (define-key nlu-mode-map (kbd "<down>") 'nlu-next-line)
   (define-key nlu-mode-map (kbd "<up>") 'nlu-previous-line)
   (message "NLU navigation on")
   )
  )
 (setq nlu-navigation-on (not nlu-navigation-on)))

(defun nlu-export-mallet-feature-sequences ()
 "Export the format for the mallet simpletagger"

 ;; Eventually allow it to reimport the results and then use those
 ;; results to run tests, i.e., is this what it has been tagged as.

 ;; Do tag overlaps, etc

 )

;; some things to write, import/export to and from standoff to inline
;; to text properties

;; use the unilang agent to do the converstion, send to nlu agent

;; have to know which tag suite to apply

(defun nlu-add-tag-to-region-special ()
 "Annotation a text with a tag"
 (interactive)
 (let* ((prop (completing-read "Please select metadata: " nlu-sample-tags)))
  (nlu-add-tag (mark) (point) prop prop)))

;; add a function for classifying the item at point, or entity
;; detecting it, etc.

;; use the knowledge base to add new tag types

;; have to remove tags from a region before proceeding

;; have the context information stored as well..., or at least
;; retrievable, i.e. the whole document, or what else

(setq nlu-tag-suite-entries
 (list
  '("matches-pattern" var-SNIPPET "Alpha-numeric String")
  '("isa" ("thing-referred-to" var-SNIPPET) "IM chat handle")
  '("isa" ("thing-referred-to" var-SNIPPET) "IM communication")
  '("isa" ("thing-referred-to" var-SNIPPET) "IM communication content")
  '("isa" ("thing-referred-to" var-SNIPPET) "timestamp")
  '("isa" ("thing-referred-to" var-SNIPPET) "sentence")
  '("task" var-SNIPPET)
  '("completed" var-SNIPPET)
  ))

;; (defun nlu-remove-tag-class-from-region ())

(defun nlu-remove-tag-at-point ()
 "Remove a specific tag from the region"
 (interactive)
 ;; get a list of all the tags in the region
 (let* ((tagname (nlu-get-tagname-at-point)))
  (save-excursion
   (nlu-back-to-beginning-of-tag tagname)
   (nlu-unlock-temporarily-and-execute 
    '(while
      (nlu-text-at-point-has-tag tagname)
      (progn
       (nlu-remove-tagname-at-point tagname)
       (forward-char)))))))

(defun nlu-tagname-to-tags (tagname)
 "return the tags"
 (list (read tagname) (read (nlu-tagname-to-string tagname))))

;; (remove-text-properties (point) (+ (point) 1) (list (cons (make-symbol "nlu-\(\"isa\" \(\"thing-referred-to\" var-SNIPPET\) \"sentence\"\)") nil)))

;; FIXME
(defun nlu-remove-tagname-at-point (tagname)
 "Remove the selected tags"
 ;; (see (nlu-tagname-to-tags tagname))
 ;; THIS DOES NOT WORK
 
 (remove-text-properties (point) (+ (point) 1) (nlu-tagname-to-tags tagname)))

(defun nlu-remove-tags-from-region (&optional mark-arg point-arg)
 "Remove all the tags in the region"
 (interactive)
 (let* ((mark (if mark-arg mark-arg (mark)))
	(point (if point-arg point-arg (point)))
	(min (nlu-region-min mark point))
	(max (nlu-region-max mark point)))
  (save-excursion
   (goto-char min)
   (nlu-unlock-temporarily-and-execute
    '(while (<= (point) max)
      (nlu-remove-tags-at-point)
      (forward-char))))))

(defun nlu-remove-non-tags-from-region (&optional mark-arg point-arg)
 "Annotation a text with a tag"
 (interactive)
 (let* ((mark (if mark-arg mark-arg (mark)))
	(point (if point-arg point-arg (point)))
	(min (nlu-region-min mark point))
	(max (nlu-region-max mark point)))
  (save-excursion
   (goto-char min)
   (nlu-unlock-temporarily-and-execute 
    '(while (<= (point) max)
      (nlu-remove-non-tags-at-point)
      (forward-char))))))
 
(defun nlu-remove-properties-from-region (&optional mark-arg point-arg)
 "Annotation a text with a tag"
 (interactive)
 (let* ((mark (if mark-arg mark-arg (mark)))
	(point (if point-arg point-arg (point)))
	(min (nlu-region-min mark point))
	(max (nlu-region-max mark point)))
  (save-excursion
   (goto-char min)
   (nlu-unlock-temporarily-and-execute
    '(while (<= (point) max)
      (nlu-remove-properties-at-point)
      (forward-char))))))

(defun nlu-remove-tags-at-point ()
 ""
 (interactive)
 (remove-text-properties (point) (+ (point) 1) (nlu-tags (text-properties-at (point)))))

(defun nlu-remove-non-tags-at-point ()
 ""
 (interactive)
 (remove-text-properties (point) (+ (point) 1) (nlu-non-tags (text-properties-at (point)))))

(defun nlu-remove-properties-at-point ()
 ""
 (interactive)
 (remove-text-properties (point) (+ (point) 1) (text-properties-at (point))))

(defun nlu-see-properties-at-point ()
 ""
 (interactive)
 (dolist (pair (text-properties-at (point))) (see pair)))

(defun nlu-test-emphasize-region ()
 "Test changing the font properties of a piece of text"
 (interactive)
 (add-text-properties (point) (mark) '(face nlu-face-temp)))

(defun nlu-reset-faces-for-tags ()
 ""
 (interactive)
 (setq nlu-possible-faces (face-list))
 (shift nlu-possible-faces)
 (setq nlu-faces-for-tags nil))

(nlu-reset-faces-for-tags)
(setq nlu-display-tags-mode t)

(defun nlu-reset-buffer ()
 "Reset all the things associated with the buffer"
 (interactive)
 (save-excursion
  (beginning-of-buffer)
  (set-mark-command nil)
  (end-of-buffer)
  (backward-char)
  (nlu-remove-tags-from-region)
  (nlu-remove-non-tags-from-region)
  )
 (nlu-reset-face-for-tag)
 )

(defun nlu-reset-face-for-tag ()
 (interactive)
 (nlu-reset-faces-for-tags)
 (setq nlu-faces-for-tags nil))

(defun nlu-get-face-for-tag (tag)
 "Return the face associated with a tag, or associate a new face
with the tag and return that"
 (let* ((printed (prin1-to-string tag))
	(face (cdr (assoc printed nlu-faces-for-tags))))
  (if (not (facep face))
   (push (cons printed (shift nlu-possible-faces)) nlu-faces-for-tags)))
 (cdr (assoc (prin1-to-string tag) nlu-faces-for-tags)))

;; (nlu-get-face-for-tag "test2")

(defun nlu-redisplay-text-with-tags-emphasized ()
 "Redraw the text, taking care to colorize and put on special fonts for each text item"
 (interactive)
 (let ((min (min (mark) (point)))
       (max (max (mark) (point))))
  (save-excursion
   (goto-char min)
   (nlu-unlock-temporarily-and-execute
    '(while (<= (point) max)
      (dolist (tag (plist-keys (nlu-tags (text-properties-at (point))))) 
       (add-text-properties (point) (+ (point) 1) (list 'face (nlu-get-face-for-tag tag))))
      (forward-char))))))

(defgroup nlu-faces nil
 "NLU faces for highlighting text"
 :prefix "nlu-face-"
 :group 'nlu-faces)

(setq nlu-face-temp 'nlu-face-temp)
(defface nlu-face-temp
 '((((class grayscale) (background light)) (:foreground "DimGray" :slant italic))
   (((class grayscale) (background dark)) (:foreground "LightGray" :slant italic))
   (((class color) (min-colors 88) (background light)) (:foreground "RosyBrown"))
   (((class color) (min-colors 88) (background dark)) (:foreground "LightSalmon"))
   (((class color) (min-colors 16) (background light)) (:foreground "RosyBrown"))
   (((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon"))
   (((class color) (min-colors 8)) (:foreground "green"))
   (t (:slant italic)))
 "Font Lock mode face used to highlight strings."
 :group 'nlu-faces)

(defun nlu-tag-search ()
 "Search for a tag based on concept, so you don't have to remember the exact tag"
 (interactive)
 )

;; need to make the tag suite be stored somewhere remotely

(defun nlu-highlight-all-tags-of-type ()
 "Highlight any tags that are subsumed by a particular tag type"
 (interactive)
 )

;; have options to apply computational semantics and other functions
;; on point, have a dictionary of functions

;; we have lookup-meaning-of-text, translate-text, speak-text
;; need parse-text,

;; view the current interpretation context

;; nlu-sem-

;; mark a given text region as completed

;; maybe we can mark a text by having the text snippet a reference to
;; the contents of the text and then also locking that portion of the
;; text for editing

;; read-only

;; modification-hooks
;; insert-in-front-hooks
;; insert-behind-hooks

;; perform operation on text - based on it's isa class, have different
;; operations that can be performed on text - for instance, you could
;; mark a task complete, mark a task as being identical to another task

;; you should have a normal form that text is reduced to when dealing
;; with the actual meaning of the text

(defun nlu-tag-word-sense ()
 "Get the word, look up all the senses, perhaps recommend a
default sense.  Overwrite existing sense data if tagged, or place
a sense with the assertion that the user has entered it"
 (interactive)
 ;; get the word at point, probably just symbol at point, or do token
 ;; at point, expand on that eventually look up through NLU probably
 ;; the various senses of the word
 (let* 
  ((word (erc-string-no-properties (thing-at-point 'word)))
   (message (uea-query-agent-raw nil "NLU" (freekbs2-util-data-dumper
					    (list
					     (cons "_DoNotLog" 1)
					     (cons "Command" "Get Word Senses")
					     (cons "Word" word)
					     )
					    )))
   (senses
    (assoc "Result"
     (freekbs2-util-data-dedumper
      (nth 5 message))))
   )
  ;; (see senses)
  ;; (see message)
  (completing-read "Choose sense: " (mapcar 'cdr (cdr senses)))
  ))

;; the basic idea is that we should have the data structure for the
;; value of an nlu text property be a hash of various items including
;; an abstracted form (without the position data, but a variable
;; instead), a type, the actual statement, etc, etc.


(defun nlu-paraphrase-object ()
 "Generate alternative ways of saying the same thing (possibly to
 verify the computers understanding of the sense of the item)"
 ;; objects may be thing-at-point, any combination of the freekbs stack
 ;; or ring, the region, or the kill buffer

 )

;; do more reading on linguistics

(defun nlu-get-tags-in-region ()
 "extract all of the tags in the region"
 (interactive)
 (let 
  ((min (min (mark) (point)))
   (max (max (mark) (point)))
   (hash (make-hash-table :size 1000 :test 'eql))
   (list nil))
  (save-excursion
   (goto-char min)
   (while (<= (point) max)
    (dolist (value (plist-values (nlu-tags (text-properties-at (point))))) 
     (puthash (prin1-to-string value) t hash)
     )
    (forward-char)))
  (maphash (lambda (key value) (push (read key) list)) hash)
  list))

(defun nlu-see-tags-in-region ()
 ""
 (interactive)
 (see (nlu-get-tags-in-region)))

(defun nlu-convert-inline-in-region-to-text-properties (text offset) "")

(defun nlu-convert-text-properties-in-region-to-inline () 
 ""
 (interactive)
 (let* 
  ((message
    (uea-query-agent-raw nil "NLU"
     (freekbs2-util-data-dumper
      (list
       (cons "_DoNotLog" 1)
       (cons "Command" "Convert Text Properties To Inline")
       (cons "Text" (nlu-get-text-in-region))
       (cons "Properties" (nlu-get-tags-in-region))
       )
      )
     ))
   (replacement
    (assoc "Result"
     (freekbs2-util-data-dedumper
      (nth 5 message))))
   )
  (see replacement)
  )
 )

(defun nlu-get-text-in-region ()
 ""
 (buffer-substring-no-properties (point) (mark)))

;; (defun nlu-convert-standoff-to-text-properties (text) "")
;; (defun nlu-convert-text-properties-to-standoff (text) "")
;; (defun nlu-convert-inline-to-standoff (text) "")
;; (defun nlu-convert-standoff-to-inline (text) "")

(defun nlu-push-n-words-onto-stack (arg)
 "Load as many as the argument of symbols onto the stack"
 (interactive "p")
 (save-excursion
  (forward-word (+ (floor (/ arg 2)) 1))
  (set-mark (point))
  (backward-word arg)
  (freekbs2-push-onto-stack (buffer-substring-no-properties (point) (mark)) nil)))

(defun nlu-resolve-deixis ()
 "Display information about the meaning of the deixis of the word or phrase at point")

(defun nlu-highlight-tag-schema-in-region ()
 "Highlight a particular tag schema in the region, so for instance, named entities"
 (interactive)
 ;; choose the tag schema
 
 )

(defun nlu-index-tags ()
 "Make an index of the tags that includes different important
 information, and make it available for other functions to use"
 ;; 
 
 )

;; (defun nlu-lookup-item-extensively ()
;;  "grab the most relevant item under the text cursor"
;;  (interactive)
;;  (let ((tag (nlu-get-most-interesting-tag-at-point)))
;;   ;; push the tag onto the stack
;;   (freekbs2-push-onto-stack tag nil)
;;   ;; now run the various emacs commands on the tag at point
;;   (freekbs2-execute-emacs-function-on-stack "freekbs2-execute-functions-lookup-item-extensively")))

(defun nlu-lookup-item-extensively ()
 "grab the most relevant item under the text cursor"
 (interactive)
 (nlu-push-most-interesting-tag-at-point-onto-stack)
 ;; now run the various emacs commands on the tag at point
 (freekbs2-execute-emacs-function-on-stack "freekbs2-execute-functions-lookup-item-extensively"))

(defun nlu-push-most-interesting-tag-at-point-onto-stack ()
 "Grab the most relevant item under the text cursor and put it on
the stack"
 (interactive)
 (let ((tag (nlu-get-most-interesting-tag-at-point)))
  ;; push the tag onto the stack
  (freekbs2-push-onto-stack tag nil)))

(defun nlu-forward-most-interesting-tag ()
 "Move forward across the most interesting tag"
 )

(defun nlu-backward-most-interesting-tag ()
 "Move backward across the most interesting tag")

;; have a lazy evaluate syntax mode that does formatting on the
;; current buffer

;; add functions for knowledge base lookup, etc

(defun nlu-buffer-has-ghost (buffer)
 "Check whether that the buffer has a ghosted copy"

 )

;; (see (concat "/var/lib/myfrdcsa/codebases/minor/nlu/data/ghost-buffers/" (replace-regexp-in-string "\\([^a-z0-9A-Z]+\\)+" "_" (academician-get-title-of-document-in-buffer-or-on-top-of-stack)) "-" (md5 (current-buffer))))

(defun nlu-ghost-buffer (&optional buffer)
 "Create a copy of the current buffer useful for performing an
 analysis on" 

 ;; look for a previously ghosted copy of the buffer
 ;; save the ghost to a file so that we can use Emacs bookmarks on it
 ;; have a mechanism for finding the same text contents, just formatted differently

 (interactive)
 (let* 
  ((buffer-to-use (if (and buffer (bufferp buffer)) buffer (current-buffer))))
  (if (non-nil (string-match "^Ghost of " (buffer-name buffer-to-use)))
   (message "Already ghosted")
   (let* ((current-point (point))
	  (current-mark (mark))
	  (ghost-buffer-contents
	   (kmax-buffer-contents-with-properties))
	  (title (replace-regexp-in-string "\\([^a-z0-9A-Z]+\\)+" "_" (academician-get-title-of-document-in-buffer-or-on-top-of-stack)))
	  ;; (ghost-buffer-name (concat "Ghost of " title))
	  (ghost-buffer-name (concat "Ghost of " (buffer-name buffer-to-use)))
	  (save-file-name (concat "/var/lib/myfrdcsa/codebases/minor/nlu/data/ghost-buffers/" title "-" (md5 buffer-to-use))))
    (ffap save-file-name)
    (rename-buffer ghost-buffer-name)
    ;; change the name to 
    ;; (switch-to-buffer (get-buffer-create ghost-buffer-name))
    (if (zerop (buffer-size))
     (progn
      (insert ghost-buffer-contents)
      ;; FIXME figure out how to save buffer properties as well
      ;; (enriched-mode t)
      (save-buffer)))
    (if current-mark
     (goto-char current-mark))
    (set-mark-command nil)
    (goto-char current-point)
    (nlu-ghost-mode)
    ;; save a variable that indicates this is a ghost buffer, so that we
    ;; can lock read-only the buffer when we are not running NLU stuff
    ;; on it
    (set-mark (point))
    save-file-name))))


(defun nlu-ghost-buffer-original (&optional buffer)
 "Create a copy of the current buffer useful for performing an
 analysis on" 

 ;; look for a previously ghoested copy of the buffer
 ;; save the ghost to a file so that we can use Emacs bookmarks on it

 (interactive)
 (let ((current-point (point)))
  (save-excursion
   (if (and buffer (bufferp buffer)) (switch-to-buffer buffer))
   (mark-whole-buffer)
   (setq nlu-ghost-buffer-contents (buffer-substring (point) (mark))))
  ;; change the name to 
  (switch-to-buffer (get-buffer-create (concat "Ghost of " (buffer-name (current-buffer)))))
  (insert nlu-ghost-buffer-contents)
  (goto-char current-point)
  ;; save a variable that indicates this is a ghost buffer, so that we
  ;; can lock read-only the buffer when we are not running NLU stuff
  ;; on it
  ))

(defun nlu-ghost-buffer-p (&optional buffer-arg)
 "Determine if the buffer is a ghost buffer or not"
 (interactive)
 (let* ((buffer (if buffer-arg buffer-arg (current-buffer)))
	(buffer-name (buffer-name buffer)))
  (eq (string-match "^Ghost of " buffer-name) 0)))

;; create a major mode for Ghost Buffers
;; add all kinds of analysis options

;; create an analyzer reasoner that schedules analysis (knowing how
;; long it usually takes)

;; create a goal based system for understanding the meaning of all
;; the text, maybe use soar or a production system

;; export the marked up tags to a combined feature learner

;; have the ability to adjust markup to correct for mistakes

;; have the ability to recognize when the user is not using the
;; interface in order to do extra processing of the text

;; dynamically highlight text as new information is learned

;; have the ability to swap between different highlighting schemes as
;; needed, maybe a ring of them

;; analyze the whole buffer in certain cases

;; fix the problematic sayer cache results

;; add locking to read-only for ghost buffers

;; have text independent knowledge for each buffer, and a mode for
;; accessing and manipulating it

;; add sentence tags

(defun nlu-what-can-I-do-with-nugget-at-point ()
 "List the available actions for the nugget at point"
 (interactive)
 
 )

(defun nlu-list-affordances-for-item-on-top-of-stack ()
 "Use the NLU system to prove things about the item on
 stack (such as where it was obtained from, keep that information
 somewhere) and determine what the item is and how it can be
 used.  For instance, a publication reference can be retrieved, a
 software can (possibly) be downloaded, etc."
 (interactive)
 ;; obtain the classification and facts about them item

 ;; retrieve the affordances 

 ;; possibly use text properties to keep metadata about the item
 
 )


;; DEVELOP A METHODOLOGY FOR PROGRESSING THROUGH A TEXT AND PROCESSING
;; IT COMPLETELY

;; have a process for resolving anaphoras to elements in the domain of
;; discourse, or sets of elements if there is amibuity...  annotate
;; further what is known about the ambiguities

;; POSSIBLY USE AN AGENT-ORIENTED DEVELOPMENT MODEL FOR CREATING TASKS
;; FOR THE AGENT TO COMPLETE.  EITHER USE SPARK OR JADE/JASON, etc.


;; add the ability to rephrase a particular text segment


;; maybe NLU should shift the KB to the context for the current document

;; should everything asserted in the tags be asserted in the logic?
;; need to keep different microtheories separate

;; Model the different modes of text availability: image-pdf,
;; searchable-image-pdf, text-pdf, latex, html-doc


;; Develop persistence mechanism for tags
;; Develop locking mechanism
;; Develop version control using git, probably



;; Develop a major mode for asserting knowledge about text


;; Have a way to mark a sentence as being didactic

;; Markup text using assert and shalmaneser, or at least a framenet
;; annotator


;; create a minor mode for text annotation of ghost buffer

;; nlu-ghost-buffer-mode


;; run acronym extraction

;; hook up a BDI agent responsible for analyzing the buffer deeply,
;; deal with large text length, etc.

;; develop a document that defines all the terms in this nlu system


;; get all words or phrases that are unknown in the text

;; want to be able to assert that the whole document is an instance of
;; a research paper

;; could have a system of analogies that allows one to see if a given
;; piece of text matches a particular pattern.  

;; For instance, the quotes around “adversary” mean a certain thing in
;; this text:

;; Our notion of maintenance is more sensitive to a good-natured agent
;; which struggles with an “adversary” environment, which hinders her
;; by unforeseeable events to reach her goals (not in principle, but
;; in case).

(defun nlu-index-linguistic-curiosity ()
 "Take the text on top of the stack and store it for future
 analysis as a curiosity of linguistic usage" 
 (interactive)
 ;; for now, just open a file and move to the bottom
 ;; (ffap "")
 )

(defun nlu-ghost-tos ()
 "Ghost Top of FreeKBS2 Stack"
 (interactive)
 (let*
  ((ghost-buffer-contents (freekbs2-get-top-of-stack))
   (ghost-buffer-name (concat "Ghost of TOS(" ghost-buffer-contents ")")))
  (if (non-nil (get-buffer ghost-buffer-name))
   (message "Already ghosted")
   (let* 
    ((save-file-name (concat "/var/lib/myfrdcsa/codebases/minor/nlu/data/ghost-buffers/" (replace-regexp-in-string "\\([^a-z0-9A-Z]+\\)+" "_" ghost-buffer-contents) "-" (md5 ghost-buffer-contents))))
    (ffap save-file-name)
    (rename-buffer ghost-buffer-name)
    (if (zerop (buffer-size))
     (progn
      (insert ghost-buffer-contents)
      (save-buffer)
      ))
    ;; save a variable that indicates this is a ghost buffer, so that we
    ;; can lock read-only the buffer when we are not running NLU stuff
    ;; on it
    )
   )
  (switch-to-buffer (get-buffer ghost-buffer-name))
  (nlu-ghost-mode)))

(defun nlu-analyze-tos-no-buffer ()
 "Analyze the top of stack, but don't output a buffer for
everyone to see, pass the results to an analyzer that can act on
them"
 (interactive))

(defun nlu-analyze-tos ()
 "Analyze the top of stack"
 (interactive)
 (nlu-ghost-tos)
 (mark-whole-buffer)
 (nlu-analyze-region-light (point) (mark)))

(defun nlu-analyze-buffer (arg)
 "Analyze the top of stack"
 (interactive "P")
 (nlu-ghost-buffer)
 (mark-whole-buffer)
 (let ((point (point))
       (mark (mark))
       (buffer (current-buffer)))
  (set-mark (point))
  (if arg (progn (ushell-restart)))
  (sit-for 5)
  (switch-to-buffer buffer)
  (nlu-analyze-region-light point mark)))

(defun nlu-duck-type-tos ()
 ""
 (kmax-not-yet-implemented))

(defun nlu-blahmotly ()
 ""
 )

(defun nlu-extract-keywords (text)
 "Extract keywords from the text passed into it using any one of
 numerous keyword extraction platforms"
 (interactive)
 
 )

(defun nlu-replace-non-words-characters-make-safe-filename (text)
 ""
 (interactive)
 (replace-regexp-in-string "[^[:alnum:]]" "_" text))

(defun nlu-read-only (state)
 ""
 (setq buffer-read-only state))



(defun nlu-unlock-temporarily-and-execute (command)
 ""
 (nlu-store-lock-state)
 (eval command)
 (nlu-restore-lock-state)
 )

(defun nlu-store-lock-state ()
 ""
 (setq nlu-lock-state buffer-read-only)
 (nlu-read-only nil))
 
(defun nlu-restore-lock-state ()
 ""
 (nlu-read-only nlu-lock-state))

(load "/var/lib/myfrdcsa/codebases/minor/nlu/frdcsa/emacs/nlu-viewer.el")

(defun nlu-load-windows ()
 ""
 (interactive)
 
 )

(defun nlu-edit-rules ()
 "Edit the file containing the rules for NLU to use when processing text"
 (interactive)
 (ffap "/var/lib/myfrdcsa/codebases/minor/nlu/rules/nlu-rules.flr"))

(defun nlu-edit-nlu-manual-formalization-queue ()
 ""
 (interactive)
 (ffap (concat "/var/lib/myfrdcsa/codebases/minor/nlu/frdcsa/sys/flp/autoload/nlu_manual_formalization_queue.pl")))

(defun nlu-forward-until-next ()
 ""
 (interactive)
 ())

(provide 'nlu)

