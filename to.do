(see about using CLP and fd and CHR to constrain meanings for
 NLU)

(Gate's Parser_SUPPLE)

(if it matches the grammar or regexp or whatever for a given
 thing, test to see if it is a known instance of thing.  For
 instance, if you have a filename, test whether it is an actual
 file on any of our filesystems, things like that.)

(We need to come up with stuff for processing text using XWordNet
 and NLU.  Similar to that notes-axiomatized.pro.  Basically, we
 can use CHR or FD to implement a bunch of constraints on
 meaning, and then reason with that meaning.  We can convert
 everything to the WNprolog-3.0 sense numbers and then use FD
 with that to specify which ones are thought to hold, or to
 qualify it somewhat with Suppose.  Then use PFC to forward chain
 the complete meaning of a sentence.  Also, map to Cyc constants.
 Integrate e2c.  Need to integrate a reductive component such as
 an external parser.  Integrate KNext parses as domain knowledge.
 Also integrate itmo or whatever or tifmo etc for RTE and use as
 an additional knowledge source)

(consider using FLUX for an intelligent reading agent)

(Just had an interesting idea, the NLU markup, which presumably
 has different tags for different items, can rotate through
 permutations of the different overlapping tags.  So
 if ("helper" "scripts") was two tags, and ("helper scripts") was
 a different one, it would cycle between those.  This can be
 animated by repeatedly swooping in and changing the fonts.  It
 can be turned on and off.  A given projection can be selected or
 rotated through using keybindings.  For point or region, all the
 enclosing tags can be rotated through and or selected.  The
 delay for auto rotation can be changed.  A list of subtags to
 consider, or tags that satisfy a predicate, can be used to
 select which tags get displayed, or using a function to
 determine in what way)

(get the KBFS identity for the file or buffer that is being
annotated, and use the nlu-analyze-region start and end to assert
a tag to be sent back as part of the annotation from the
annotation program that a given snippet has been annotated in the
current context.  Refer to a specific git revision if possible.

)

(have an nlu function for getting the location i.e. (entry-fn
 sayer ?X) of the most general piece of text containing point)
(add an nlu function for editing the context of an assertion)

(depends
 (start translating en-masse a bunch of text)
 (fix ("entry-fn" "sayer" "20"))
 )

(defun bind-a-to-b-in-c (a b c)
 "FIXME: want to treat for quantification"
 (interactive)
 (if (equal a c)
  b
  (if (listp c)
   (mapcar (lambda (c-prime) (bind-a-to-b-in-c a b c-prime)) c)
   c)))

(list "suppose"
 (bind-a-to-b-in-c
  'var-X 
  '("substring-of" ("array-element" ("entry-fn" "sayer" "20") "0") "0" "201")
  '("and" ("isa" var-X "Sentence") ("has-ID" var-X "2015390835815"))))

(list "suppose"
 (funcall
  (lambda (var-X)
   (list
    "and"
    (list "isa" var-X "Sentence")
    (list "has-ID" var-X "2015390835815")))
  '("substring-of" ("array-element" ("entry-fn" "sayer" "20") "0") "0" "201")))


(ATPM := a system for enumerating all the possible meanings (not
just a finite number of parses, but an arbitrary number of
possible meanings) of a piece of text (All The Possible
Meanings|At The Present Moment))


(Documents that should be read
http://frdcsa.org/~andrewdo/writings/workhorse.odp
http://frdcsa.org/~andrewdo/writings/nlu.txt
http://frdcsa.org/~andrewdo/projects/automatic-argument-mapping.txt

)




(need to find programmers)

(need to set up a large set of regression tests and have the NLU
 system pass each regression, like gnugo)

(here are some ideas with this system, we can tag things and then
 prove things about the items in the tags, and possibly in
 relation to the items containing those tags (for context))

(
 "It is raining cats and dogs"
 <and><item>cats<item></item>dogs</item></and>
 <idiom id=1 def="to rain cats and dogs"></idiom>
 "It is raining <entity id=1351>cats</entity> and <entity id=3215>dogs<entity>"
 "It is <idiom id=1>raining cats and dogs</idiom>"

 "It is <disj a=1 b=2,3><idiom tid=1 id=1>raining <entity tid=2 id=1351>cats</entity> and <entity tid=3 id=3215>dogs</entity></idiom></conj>"
 )

(
 Need to do some things.  Every used text analysis technique
 needs to generate annotation outputs.  

 WSD needs to output all the results.

 Need to be able to view the different tags different ways.

 Need to start organizing other programmers.
 )



(Document metadata)
(Document layout)
(Document structure)
(Document style)
(Document organization)

(some functions - have a relation or formula builder which has
tab completion for predicates in the freekbs2-ring, then allows
you to go around and push-thing-at-point into the available
argument positions of the predicate, and furthermore, it knows
the entity classes that are allowed into the argument.  So for
instance, you can have forward-matching-entity and
backward-matching-entity that will jump between the text to
location spans that match the required input type
(moreover, you can have things for VPEs (elliptical verb phrases)
as well as pronoun antecedants and general anaphora and
coreference resolution), allowing faster tagging and creation of
data sets and manual tidying up of the text to knowledge process)

(Here are some things that we could do to improve the system
 (fix the handling where it is processing '"undef"')
 (fix up navigation to work better, to start at the first toggle,
  and to automatically come on after running analyze)
 (add a tag which tells us whether text has been analyzed with
  nlu, and what time, etc)
 (create a font visualization mode, that will alter the font
  characteristics for certain tagged items, i.e. illustrate named
  entities, etc)
 (fix the way the shallow parsing is re-run every time)
 (clean up startup, so you don't have to manually start it, also,
  fix the "NLU, echo" function so it isn't sending us two messages at startup) 
 (create associated functions for manipulating things at point)
 (integrate with FreeKBS2-Ring)
 (write documentation or a tutorial)
 (provide a set of thing-at-point classes)
 (automatically invoke nlu-analyze-region or something when we
  use any of the thing-at-point type stuff) 
 (have the ability to add tags to the knowledge base, so that we
  can begin augmenting the data)
 (develop a poetry mode and otherwise extend the NLU component
  that makes the decisions) 
 (write a document on how the decisions are made)
 (add PPI support, and any other parsers we might wish to use)
 (use file/language recognition)
 )


(Here are some ideas.  Suppose you have a body of text - you
 should be able to create an object from it, and to ask questions
 of it.

 e.g.
 my $text = ""				  ;
 my $obj = NLU::Object->new(Text => $text) ;
 my $answer = $obj->Question(Question => "What are all the programming languages mentioned in the text?") ;
 my $answertype = AnswerType(Question => "What are all the programming languages mentioned in the text?") || ref $answer ;
 # $answer->Values

 # same with document collections - use QUAC to be able to answer
   questions from a document collection, in a given context, etc

 my $documents = Documents->new(Source => "Gutenberg",) # etc - specify a set of documents somehow

 )

(add a feature to show all dates in the current document)

(add a function for returning all the tokens in a given buffer)
