(define-derived-mode nlu-tags-mode
 freekbs2-knowledge-editor-mode "NLU-Tags"
 "Major mode for managing NLU Tags.
\\{nlu-tags-mode-map}"
 ;; (define-key academician-mode-map (kbd "aa") 'academician-analyze-region)
 ;; (define-key academician-mode-map (kbd "an") 'academician-declare-page-of-document-read-old)
 ;; (define-key academician-mode-map (kbd "aN") 'academician-declare-page-of-document-unread)
 ;; (define-key academician-mode-map (kbd "ak") 'academician-process-document-with-knext)
 ;; (define-key academician-mode-map (kbd "aK") 'academician-display-knext-processing-result)
 ;; (define-key academician-mode-map (kbd "ar") 'academician-reload-document)
 ;; (define-key academician-mode-map (kbd "ac") 'academician-search-for-citation)
 ;; (define-key academician-mode-map (kbd "at") 'academician-see-title-of-publication)
 ;; (define-key academician-mode-map (kbd "aT") 'academician-override-title)
 ;; (define-key academician-mode-map (kbd "cb") 'clear-queue-current-buffer-referent)
 ;; (define-key academician-mode-map (kbd "cp") 'clear-pause)
 ;; ;; (define-key academician-mode-map "li" 'academician-index-document)
 ;; ;; (define-key academician-mode-map "lr" 'academician-retrieve-document-for-analysis-from-url-at-point)
 ;; (define-key academician-mode-map "lt" 'academician-search-papers)
 ;; (define-key academician-mode-map "lp" 'academician-choose-paper)
 ;; ;; (define-key academician-mode-map "lR" 'academician-w3m-view-html-with-doc-view-mode)
 ;; (define-key academician-mode-map "lc" 'academician-search-for-citation)
 ;; (define-key academician-mode-map "lx" 'academician-lookup-publication-on-citeseer-x)
 ;; (define-key academician-mode-map "lst" 'academician-see-title-of-publication)
 ;; (define-key academician-mode-map "lsp" 'academician-see-parscit-results)
 )

(defun nlu-tags-viewer-show-tags-at-point (&optional plist)
 ""
 (interactive)
 (save-excursion
  (let* ((current-buffer (current-buffer))
	 (nlu-tags-buffer (get-buffer-create "*nlu-tags*"))
	 (plist (or plist (nlu-tags (text-properties-at (point))))))
   (switch-to-buffer-other-window nlu-tags-buffer)
   (mark-whole-buffer)
   (delete-region (point) (mark))
   (dolist (value (plist-values plist))
    (insert (concat (elisp-format-string (prin1-to-string value)) "\n")))
   (beginning-of-buffer)
   (nlu-tags-mode)
   (switch-to-buffer-other-window current-buffer)
   )))

(defun nlu2-tags-viewer-show-tags-at-point (&optional plist)
 ""
 (interactive)
 (save-excursion
  (let* ((current-buffer (current-buffer))
	 (nlu-tags-buffer (get-buffer-create "*nlu-tags*"))
	 (plist (or plist (nlu-tags (text-properties-at (point))))))
   (switch-to-buffer-other-window nlu-tags-buffer)
   (mark-whole-buffer)
   (delete-region (point) (mark))
   (dolist (key (plist-keys plist))
    (insert (concat (format "%s" (nlu-strip-property-header key)) "\n")))
   (beginning-of-buffer)
   (nlu-tags-mode)
   (switch-to-buffer-other-window current-buffer)
   )))

;; (defun xah-unescape-quotes (@begin @end)
;;    "Replace  「\\\"」 by 「\"」 in current line or text selection.
;; See also: `xah-escape-quotes'

;; URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
;; Version 2017-01-11"
;;  (interactive
;;   (if (use-region-p)
;;    (list (region-beginning) (region-end))
;;    (list (line-beginning-position) (line-end-position))))
;;  (save-excursion
;;   (save-restriction
;;    (narrow-to-region @begin @end)
;;    (goto-char (point-min))
;;    (while (search-forward "\\\"" nil t)
;;             (replace-match "\"" "FIXEDCASE" "LITERAL")))))


;; (nlu-strip-property-header 'x-nlu-test)
