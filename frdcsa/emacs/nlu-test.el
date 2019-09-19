(defun nlu-analyze-region-test ()
 "Take a text region and perform the NLU analysis on it"
 (save-excursion
  (let* (
	 ;; have an offset value corresponding to the text
	 ;; create a new theory for this item
	 (context "Org::FRDCSA::NLU::Buffer::Ghost of temp")
	 (filename "/var/lib/myfrdcsa/codebases/minor/nlu/frdcsa/emacs/nlu-sample.txt")
	 (light-var 1)
	 ;; (temp (progn (see (list point mark)) 5))
	 (start 0)
	 (end (length (get-string-from-file filename)))
	 )
   ;; write the contents to a file, run the nlu system on it, adding
   ;; information such as which file it came from, so on and so forth
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
     )
    (message (prin1-to-string message))
    ;; (message (prin1-to-string tobeevaled))
    ;; (if (string-match "nlu-add-spanlist" tobeevaled)
    ;;  (eval (read tobeevaled))
    ;;  ;; (message (concat "message = " tobeevaled))
    ;;  )
    )
   )
  )
 )

;; (nlu-analyze-region-test)

