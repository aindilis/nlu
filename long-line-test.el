(if 
 (string-match 
  (concat "[	 \n]*" "<id>\\(.*?\\)</id>" "[	 \n]*" "<sender>\\(.*?\\)</sender>" "[	 \n]*" "<receiver>\\(.*?\\)</receiver>" "[	 \n]*" "<date>\\(.*?\\)</date>" "[	 \n]*" "<contents>\\(\\([^.]?[.]?\\)*\\)</contents>" "[	 \n]*" "<data>\\(\\([^.]?[.]?\\)*\\)</data>" "[	 \n]*")
  joined) 
 (let (... ... ... ... ... ...) (setq uea-output-kept nil) (setq uea-buffer-message-raw ...) (setq uea-buffer-message contents)))

(if
 (string-match 
  (concat "[	 \n]*" "<id>\\(.*?\\)</id>" "[	 \n]*" "<sender>\\(.*?\\)</sender>" "[	 \n]*" "<receiver>\\(.*?\\)</receiver>" "[	 \n]*" "<date>\\(.*?\\)</date>" "[	 \n]*" "<contents>\\(\\([^.]?[.]?\\)*\\)</contents>" "[	 \n]*" "<data>\\(\\([^.]?[.]?\\)*\\)</data>" "[	 \n]*") joined)
 (let (... ... ... ... ... ...) (setq uea-output-kept nil) (setq uea-buffer-message-raw ...) (setq uea-buffer-message contents)))