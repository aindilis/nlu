(global-set-key "\C-cntZ" 'nlu-get-tagname-at-point-advanced)
(setq nlu-tmp-target (list "(\"isa\" (\"thing-referred-to\" var-SNIPPET) \"sentence\")" "(\"matches-pattern\" (\"substring-of\" (\"array-element\" (\"entry-fn\" \"sayer\" \"21\") \"0\") \"64\" \"73\") \"Alpha-numeric String\")" "(\"noun-phrase\" (\"substring-of\" (\"array-element\" (\"entry-fn\" \"sayer\" \"21\") \"0\") \"64\" \"82\") \"pleteness Theorems\")" "(\"noun-phrase\" (\"substring-of\" (\"array-element\" (\"entry-fn\" \"sayer\" \"21\") \"0\") \"64\" \"73\") \"pleteness\")"))
(setq nlu-tmp-source (list "nlu-\\(\\\"isa\\\"\\ \\(\\\"thing-referred-to\\\"\\ var-SNIPPET\\)\\ \\\"sentence\\\"\\)" "nlu-\\(\\\"matches-pattern\\\"\\ \\(\\\"substring-of\\\"\\ \\(\\\"array-element\\\"\\ \\(\\\"entry-fn\\\"\\ \\\"sayer\\\"\\ \\\"21\\\"\\)\\ \\\"0\\\"\\)\\ \\\"64\\\"\\ \\\"73\\\"\\)\\ \\\"Alpha-numeric\\ String\\\"\\)" "nlu-\\(\\\"noun-phrase\\\"\\ \\(\\\"substring-of\\\"\\ \\(\\\"array-element\\\"\\ \\(\\\"entry-fn\\\"\\ \\\"sayer\\\"\\ \\\"21\\\"\\)\\ \\\"0\\\"\\)\\ \\\"64\\\"\\ \\\"82\\\"\\)\\ \\\"pleteness\\ Theorems\\\"\\)" "nlu-\\(\\\"noun-phrase\\\"\\ \\(\\\"substring-of\\\"\\ \\(\\\"array-element\\\"\\ \\(\\\"entry-fn\\\"\\ \\\"sayer\\\"\\ \\\"21\\\"\\)\\ \\\"0\\\"\\)\\ \\\"64\\\"\\ \\\"73\\\"\\)\\ \\\"pleteness\\\"\\)"))



(setq nlu-tmp-to-decode (prin1-to-string (make-symbol (concat nlu-property-header (prin1-to-string (list "isa" (list "thing-referred-to" 'var-SNIPPET) "sentence"))))))
(see nlu-tmp-to-decode)
(setq nlu-tmp-partially-decoded (prin1-to-string (read nlu-tmp-to-decode) t))
(setq nlu-tmp-decoded (substring nlu-tmp-partially-decoded (length nlu-property-header) (length nlu-tmp-partially-decoded)))
(setq nlu-tmp-valuestrings (list nlu-tmp-decoded "hi"))
(setq nlu-tmp-valuestrings (mapcar (lambda (symbol) (nlu-clean-prototagname symbol)) nlu-tmp-source))
(completing-read "Choose Tag: " nlu-tmp-valuestrings)
