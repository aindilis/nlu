;; (nlu-add-spanlist 1 nlu-sample-tags)
;; (nlu-tags nlu-sample-plist)
;; (plist-keys nlu-sample-plist)
;; (plist-values nlu-sample-plist)

(setq nlu-sample-plist '(nlu-test test face font-lock-function-name-face fontified t))
(setq nlu-sample-tags
 (list
  (prin1-to-string '("matches-pattern" "SELF" "Space"))
  (prin1-to-string '("matches-pattern" "SELF" "Word"))
  (prin1-to-string '("word-sense-disambiguation" "SELF" "Pedersen" ("wordnet-sense" "time" "n" "5")))))
(setq nlu-sample-tags (list '(213 214 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "213" "214") "Space")) '(176 185 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "176" "185") "Alpha-numeric String")) '(187 188 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "187" "188") "Space")) '(224 225 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "224" "225") "Whitespace")) '(42 43 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "42" "43") "Space")) '(37 38 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "37" "38") "Whitespace")) '(165 166 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "165" "166") "Whitespace")) '(217 221 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "217" "221") "Alpha-numeric String")) '(27 31 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "27" "31") "Alpha-numeric String")) '(21 24 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "21" "24") "Alpha-numeric String")) '(73 75 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "73" "75") "Alpha-numeric String")) '(60 62 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "60" "62") "Alpha-numeric String")) '(153 156 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "153" "156") "Alpha-numeric String")) '(119 122 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "119" "122") "Alpha-numeric String")) '(73 74 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "73" "74") "Whitespace")) '(164 174 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "164" "174") "Alpha-numeric String")) '(143 144 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "143" "144") "Space")) '(76 83 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "76" "83") "Alpha-numeric String")) '(128 134 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "128" "134") "Alpha-numeric String")) '(123 124 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "123" "124") "Space")) '(97 98 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "97" "98") "Whitespace")) '(12 19 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "12" "19") "Alpha-numeric String")) '(219 220 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "219" "220") "Space")) '(53 54 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "53" "54") "Space")) '(129 130 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "129" "130") "Whitespace")) '(54 59 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "54" "59") "Alpha-numeric String")) '(31 32 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "31" "32") "Whitespace")) '(26 27 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "26" "27") "Space")) '(35 37 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "35" "37") "Alpha-numeric String")) '(54 59 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "54" "59") "Pedersen" ("wordnet-sense" "quite" "r" "3"))) '(99 103 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "99" "103") "Alpha-numeric String")) '(34 35 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "34" "35") "Whitespace")) '(62 72 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "62" "72") "Alpha-numeric String")) '(26 27 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "26" "27") "Whitespace")) '(111 118 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "111" "118") "Alpha-numeric String")) '(63 73 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "63" "73") "Pedersen" ("wordnet-sense" "voluminous" "a" "1"))) '(138 141 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "138" "141") "Alpha-numeric String")) '(25 26 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "25" "26") "Alpha-numeric String")) '(151 152 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "151" "152") "Space")) '(21 23 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "21" "23") "Closing period")) '(219 220 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "219" "220") "Whitespace")) '(50 53 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "50" "53") "Pedersen" ("wordnet-sense" "and" "ND" "undef"))) '(85 87 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "85" "87") "Alpha-numeric String")) '(88 96 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "88" "96") "Alpha-numeric String")) '(162 163 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "162" "163") "Alpha-numeric String")) '(202 207 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "202" "207") "Alpha-numeric String")) '(37 38 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "37" "38") "Space")) '(31 32 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "31" "32") "Space")) '(32 34 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "32" "34") "Alpha-numeric String")) '(97 98 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "97" "98") "Alpha-numeric String")) '(135 137 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "135" "137") "Alpha-numeric String")) '(154 155 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "154" "155") "Whitespace")) '(211 216 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "211" "216") "Alpha-numeric String")) '(158 159 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "158" "159") "Whitespace")) '(99 100 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "99" "100") "Whitespace")) '(139 140 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "139" "140") "Whitespace")) '(222 230 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "222" "230") "Alpha-numeric String")) '(53 54 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "53" "54") "Whitespace")) '(59 60 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "59" "60") "Space")) '(1 8 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "1" "8") "Alpha-numeric String")) '(142 149 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "142" "149") "Alpha-numeric String")) '(129 130 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "129" "130") "Space")) '(104 106 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "104" "106") "Alpha-numeric String")) '(88 89 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "88" "89") "Whitespace")) '(59 60 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "59" "60") "Whitespace")) '(210 211 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "210" "211") "Space")) '(111 112 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "111" "112") "Whitespace")) '(104 105 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "104" "105") "Space")) '(104 105 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "104" "105") "Whitespace")) '(165 166 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "165" "166") "Space")) '(123 124 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "123" "124") "Whitespace")) '(224 225 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "224" "225") "Space")) '(62 63 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "62" "63") "Space")) '(208 210 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "208" "210") "Alpha-numeric String")) '(157 161 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "157" "161") "Alpha-numeric String")) '(24 25 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "24" "25") "Whitespace")) '(38 42 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "38" "42") "Pedersen" ("wordnet-sense" "mean" "a" "1"))) '(50 53 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "50" "53") "Alpha-numeric String")) '(119 120 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "119" "120") "Whitespace")) '(38 42 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "38" "42") "Alpha-numeric String")) '(99 100 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "99" "100") "Space")) '(123 128 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "123" "128") "Alpha-numeric String")) '(42 43 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "42" "43") "Whitespace")) '(35 37 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "35" "37") "Pedersen" ("wordnet-sense" "no" "a" "1"))) '(191 194 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "191" "194") "Alpha-numeric String")) '(158 159 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "158" "159") "Space")) '(136 137 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "136" "137") "Space")) '(32 34 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "32" "34") "Pedersen" ("wordnet-sense" "of" "ND" "undef"))) '(107 110 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "107" "110") "Alpha-numeric String")) '(111 112 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "111" "112") "Space")) '(196 197 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "196" "197") "Space")) '(143 144 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "143" "144") "Whitespace")) '(107 108 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "107" "108") "Space")) '(187 188 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "187" "188") "Whitespace")) '(34 35 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "34" "35") "Space")) '(43 48 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "43" "48") "Alpha-numeric String")) '(136 137 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "136" "137") "Whitespace")) '(74 76 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "74" "76") "Pedersen" ("wordnet-sense" "as" "n" "1"))) '(12 19 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "12" "19") "Pedersen" ("wordnet-sense" "Canoine" "ND" "undef"))) '(107 108 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "107" "108") "Whitespace")) '(62 63 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "62" "63") "Whitespace")) '(25 26 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "25" "26") "Pedersen" ("wordnet-sense" "a" "n" "4"))) '(88 89 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "88" "89") "Space")) '(1 8 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "1" "8") "Pedersen" ("wordnet-sense" "Fothadh" "ND" "undef"))) '(24 25 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "24" "25") "Space")) '(196 197 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "196" "197") "Whitespace")) '(139 140 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "139" "140") "Space")) '(59 60 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "59" "60") "Closing period")) '(73 74 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "73" "74") "Space")) '(192 193 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "192" "193") "Whitespace")) '(60 62 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "60" "62") "Pedersen" ("wordnet-sense" "as" "n" "1"))) '(97 98 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "97" "98") "Space")) '(43 48 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "43" "48") "Pedersen" ("wordnet-sense" "order" "n" "10"))) '(210 211 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "210" "211") "Whitespace")) '(77 84 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "77" "84") "Pedersen" ("wordnet-sense" "Spenser" "n" "1"))) '(151 152 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "151" "152") "Whitespace")) '(119 120 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "119" "120") "Space")) '(150 152 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "150" "152") "Alpha-numeric String")) '(213 214 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "213" "214") "Whitespace")) '(9 11 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "9" "11") "Pedersen" ("wordnet-sense" "na" "NR" "undef"))) '(27 31 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "27" "31") "Pedersen" ("wordnet-sense" "poet" "n" "1"))) '(192 193 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "192" "193") "Space")) '(76 77 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "76" "77") "Space")) '(9 11 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "9" "11") "Alpha-numeric String")) '(154 155 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "154" "155") "Space")) '(186 190 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "186" "190") "Alpha-numeric String")) '(76 77 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "76" "77") "Whitespace")) '(21 24 '("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "21" "24") "Pedersen" ("wordnet-sense" "wa" "n" "1"))) '(194 199 '("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "194" "199") "Alpha-numeric String"))))

(defun nlu-load-test-domain ()
 "Load a sample test domain for testing of the nlu.el stuff"
 (interactive)
 (find-file "/var/lib/myfrdcsa/codebases/minor/nlu/test.txt")
 (mark-whole-buffer)
 (nlu-add-spanlist 1 nlu-sample-tags)
 )
