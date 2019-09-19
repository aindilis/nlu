sentence('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceIdFn(5),'The Chinese character xiao (pronounced "sheeow" in a falling, affirmative tone) was originally a highly stylized picture of a gray-haired old person and a young child , reflecting as it does generational deference and the reverence it engenders.').

hasManualFormalization('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
                 [
                  'xiao is a chinese character',
		  'a chinese character is a letter in the chinese alphabet',
		  'xiao is pronounced "sheeow"',
		  'the pronunciation of xiao is in a falling tone',
		  'the pronunciation of xiao is in an affirmative tone',
		  'xiao is a picture',
		  'the picture of xiao contains a gray-haired old person',
		  'the picture of xiao contains a young child',
		  'the picture of xiao reflects generational deference',
		  'the picture of xiao reflects reverence',
		  'generational deference engenders reverence',
                 ]).


hasManualPrologifiedFormalization('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
				  [
				   isa(xiao,chineseCharacter),
				   isa(chineseCharacter,in(letter,chineseAlphabet)),
				   pronounced(xiao,sheeow),
				   hasProperty(pronounciationFn(xiao),falling(tone)),
				   hasProperty(pronounciationFn(xiao),affirmative(tone)),
				   isa(xiao,picture),
				   and(
				       %% contains(v1_1, v1_2, v1_4), pictureFn(v1_2, v1_3), xiao(v1_3), person(v1_4)
				       contains(pictureFn(xiao),Person),
				       isa(Person,person),
				       hasProperty(Person,old),
				       hasPart(Person,Hair),
				       isa(Hair,hair),
				       hasProperty(Hair,grey)
				      ),
				   and(
				       contains(pictureFn(xiao),Child),
				       isa(Child,child),
				       hasProperty(Child,young)
				      ),
				   reflects(pictureFn(xiao),generationalDeference),
				   reflects(pictureFn(xiao),reverence),
				   engender(generationalDeference,reverence)
				  ]).



hasHandExtractedResult('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
	  ['assert',
	   [
	    'pronounced sheeow in a falling affirmative tone',
	    'falling affirmative',
	    'highly stylized picture',
	    'reflecting as a highly stylized picture of a gray-haired old person and a young child',
	    'engenders it the reverence'
	   ]
	  ]).

hasActualResult('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
		['assert',
		 '0: [ARG1 The Chinese character xiao] [TARGET pronounced ] [ARG1 sheeow] [ARGM-LOC in a falling affirmative tone] was originally a highly stylized picture of a gray-haired old person and a young child reflecting as it does generational deference and the reverence it engenders
		0: The Chinese character xiao pronounced sheeow in a [TARGET falling ] [ARG1 affirmative] tone was originally a highly stylized picture of a gray-haired old person and a young child reflecting as it does generational deference and the reverence it engenders
		0: The Chinese character xiao pronounced sheeow in a falling affirmative tone was originally a [ARGM-EXT highly] [TARGET stylized ] [ARG1 picture] of a gray-haired old person and a young child reflecting as it does generational deference and the reverence it engenders
		0: The Chinese character xiao pronounced sheeow in a falling affirmative tone was originally [ARG2 a highly stylized picture of a gray-haired old person and a young child] [TARGET reflecting ] [ARGM-ADV as] it does generational deference and the reverence it engenders
		0: The Chinese character xiao pronounced sheeow in a falling affirmative tone was originally a highly stylized picture of a gray-haired old person and a young child reflecting as it does generational deference and [ARG1 the reverence] [ARG0 it] [TARGET engenders ]
		'
		]).

hasAutomaticallyProcessedResult('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
		['assert',
		 '''Processed'' => [
                           {
                             ''ARG1'' => ''sheeow'',
                             ''ARGM-LOC'' => ''in a falling affirmative tone'',
                             ''TARGET'' => ''pronounced''
                           },
                           {
                             ''ARG1'' => ''affirmative'',
                             ''TARGET'' => ''falling''
                           },
                           {
                             ''ARG1'' => ''picture'',
                             ''ARGM-EXT'' => ''highly'',
                             ''TARGET'' => ''stylized''
                           },
                           {
                             ''ARG2'' => ''a highly stylized picture of a gray-haired old person and a young child'',
                             ''TARGET'' => ''reflecting'',
                             ''ARGM-ADV'' => ''as''
                           },
                           {
                             ''TARGET'' => ''engenders'',
                             ''ARG1'' => ''the reverence'',
                             ''ARG0'' => ''it''
                           }
		]'
		]).
			   
 	
hasActualResult('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
		['ollie',
		 'The Chinese character xiao (pronounced "sheeow" in a falling, affirmative tone) was originally a highly stylized picture of a gray-haired old person and a young child , reflecting as it does generational deference and the reverence it engenders.
		0.926: (sheeow; was originally a highly stylized picture of; a gray-haired old person and a young child)
		0.81: (sheeow; was originally; a highly stylized picture of a gray-haired old person)
		0.531: (it; does; generational deference and the reverence it engenders)'
		]).

hasHandExtractedResult('theChineseClassicOfFamilyReverenceRosemontAmes_TheBook',sentenceFn(5),
	  ['ollie',
	   [
	    'sheeow was originally a highly stylized picture of a gray-haired old person and a young child',
	    'sheeow was originally a highly stylized picture of a gray-haired old person',
	    'it does generational deference and the reverence it engenders'
	   ]
	  ]).
