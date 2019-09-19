%% Here is a way to think about how we might make this intelligent system
%% I keep envisioning.

%% First, it can be applied to reading.

%% As it reads, it makes certain assumptions.

%% Suppose that ...

fassert(suppose(means(this,that))).

%% (this means that), etc.

%% Now, in certain cases, it can specify generalizations.  i.e.

fassert(suppose(reading(nlu,sentence))).

%% One observation is that I get beat at chess simply because my
%% ability to store and recall assumptions is not as strong as that of
%% others.  That there really is no mystery there, why that is.  Now,
%% I don't think its sufficient for intelligence simply to be able to
%% do that.  But nonetheless necessary, so we ought to implement that
%% if we can.

fassert(suppose(and(reading(nlu,Sentence),like(Sentence,this)))).

%% 1 Jane went to the bank to visit her friends.

%% It could say:

fassert(suppose(isa(object_referred_to(substring(entryfn(sayer,100),10,14)),'#$person'))).
fassert(suppose(has_wn_sense(object_referred_to(substring(entryfn(sayer,100),18,22)),'went#v#1'))).
fassert(suppose(isa(object_referred_to(substring(entryfn(sayer,100),25,29)),placename))).

%% simply take a parser output and covert it to these suppositional
%% forms, then use modal reasoning to eliminate inconsistent items

%% ;; need a modal logic here

fassert(suppose(isa("Jane",person))).
fassert(suppose(or_holds(mean("went",wn_sense(this)),mean("went",wn_sense(that))))).

%% or is it

fassert(or_holds(suppose(mean("went",wn_sense(this)),suppose(mean("went",wn_sense(that)))))).

fassert(suppose(mean("bank",place))).

%% Note that instead of assigning a sense to bank, it simply
%% generalizes that it is a place, and continues with the
%% interpretation.

%% Now, this model naturally handles many sentences, because these
%% suppositions are sustained.

%% When it runs into a problem, such as it detects a constraint that
%% is violated, then it can backtrack to see which assumptions might
%% be mistaken.

%% Lastly, it should build multiple of these models, or some such
%% thing.  Perhaps it should use metareasoning about the knowledge in
%% the search process.  But in other words it should use other
%% intelligent techniques to reason about these.

%% The suppositions could be brought about by simple observations.
%% For instance, to suppose that Jane is a person could follow from
%% the observation that Jane is a person's name.  In fact the
%% supposition could be made that Jane is probably a girl, although
%% there could be specific knowledge later that would cause it to
%% think Jane is a guy (if Jane was for instance a transvestite.)

%% Now as these observations/suppositions it makes come up, some of
%% them will invariably prove inconsistent, at which point the system
%% will suppose that it has made an error, and that certain of its
%% observations were wrong.  It will attempt to determine where it
%% made its mistake


%%%% FIXME: FINISH converting to prolog
%%%%
%%%%
%%%% 7 Now, in certain cases, it can specify generalizations.  i.e..
%%%% 
%%%% Suppose by "Now" we mean now#n_6
%%%% 
%%%% (suppose (and
%%%% 	  (has-wn-sense (object-referred-to (substring (entryfn sayer 100) 10 13)) now#n#6)
%%%% 	  (is-capitalized (substring (entryfn sayer 100) 10 13))
%%%% 	  ))
%%%% 
%%%% 	6: (prefatory or transitional) indicates a change of subject
%%%% 	or activity; "Now the next problem is..."
%%%% 
%%%% 9 Suppose by "it" we mean "thinker".
%%%% 
%%%% 
%%%% 10 Suppose by "Suppose" it means suppose#v_2: 
%%%% 
%%%% 	To imagine; to believe; to receive as true.
%%%% 
%%%% 11 Suppose "I" is eclipsed, and by I I mean myself (thinker).
%%%% 12 Suppose by 10."it" it means 9
%%%% 
%%%% 
%%%% 
%%%% 13 Anyhow this should be simple enough to make a test system based on this design
%%%% 
%%%% 
%%%% 
%%%% Here is an interesting tack.  This is really the basis for the
%%%% formalize tool.  Because, we can imagine mapping these to axioms.  For instance:
%%%% 
%%%% Suppose (#$isa 1.1(Jane) #$FemalePerson) by rule X
%%%% 
%%%% rule X: if firstname is in femalenames then, perhaps isa thing such
%%%% that firstname is the name of thing and is thing person and is thing
%%%% female.
%%%% 
%%%% or some such rule or class of rules: perhaps we can codify it into a
%%%% linguistic expression such that the derivations take part as part of
%%%% the evaluation of suppositions
%%%% 
%%%% 
%%%% 
%%%% Whenever the same entity is contacted in a later sentence, such as
%%%% "Jane", it is an additional supposition that Jane refers to the same
%%%% thing as the previous Jane.
%%%% 
%%%% 
%%%% Periodically, the system may submit certain ideas: suppose that what I
%%%% am doing is wrong.  If such is as of yet unproven it goes into a list
%%%% of unproven assertions somehow.
%%%% 
%%%% 
%%%% 
%%%% Here is an example of generalizations at work:
%%%% 
%%%% Here the antecedant of "this" is rather hard to understand, and so the
%%%% system may not make the best guess of what "this" means in this case:
%%%% 
%%%% 13.2(this)
%%%% 
%%%% Perhaps, then it can generalize for the time being, and then later
%%%% refine its generalization based on the existing suppositions.
%%%% 
%%%% 14 "This" is getting too complex for the toy system.
%%%% 
%%%% s1 suppose 14.1("This") means "the present design".
%%%% 
%%%% Here linguistic knowledge is used.
%%%% 
%%%% 
%%%% 
%%%% 15 As for parsing, the system should attempt to interpret text letter by
%%%% letter.
%%%% 
%%%% i.e. 
%%%% 
%%%% suppose 15.l0-l2("As") is the word "as".
%%%% suppose 15.l3(" ") is a space.
%%%% suppose 15.l4-l6("for") is the word "for".
%%%% 
%%%% Okay, in order to prevent state space explosion, local tactics and
%%%% focused investigations are necessary in order to reduce the number of
%%%% hypotheses.
%%%% 
%%%% i.e.
%%%% 
%%%% 16 JaneDoe si a friend of mine.
%%%% 
%%%% So in this case, the similarity of JaneDoe to "Jane Doe"
%%%% should trigger the hypthosis that it is that mispelled.  Same with
%%%% "si" and "is".
%%%% 
%%%% # Suppose "hypothesies" is "hypotheses" mispelled.
%%%% 
%%%% Okay, when an assumption is refuted, it is not clear where the error
%%%% was.  As subsequent assumptions frequently depend upon other
%%%% suppositions
%%%% 
%%%% returning to:
%%%% 
%%%% 	suppose "Jane" is a person
%%%% 	suppose by "went" we mean WN sense this or that
%%%% 	suppose by bank we mean place.
%%%% 	
%%%% 	Note that instead of assigning a sense to bank, it simply generalizes
%%%% 	that it is a place, and continues with the interpretation.
%%%% 
%%%% I note now that you would have this subsequence of suppositions
%%%% 
%%%% suppose "bank" is the word bank.
%%%% suppose "went" is the word went.
%%%% suppose "went" is this sense went:going
%%%% 
%%%% # now we can posit some constraints on the meaning of the word bank.  I suppose it makes sense to declare a goal of deciphering "bank".
%%%% 
%%%% "Let us consider the meaning of the term "bank"".
%%%% 
%%%% At this point we evaluate all the different senses for logical
%%%% cohesion with the assumed meaning of went:
%%%% 
%%%% Well, I personally cannot seem to rule any of the senses of bank out.
%%%% The easiest would be 10 "a flight maneuver", but running it by my
%%%% personal "does that sound right" system, "he went to the bank" is
%%%% tangentially possible.
%%%% 
%%%% The sound right system.  I don't know how this works but it is what I
%%%% use.  So let it use it, and by it I mean thinker.
%%%% 

%%%%	 # can use deep learning for the sound right system.

%%%% Incidentally, I didn't even consider the verb senses.  Perhaps some or
%%%% all of these would be ruled out...
%%%% 
%%%% I suppose you could have probability assessments here.  That would be
%%%% based on existing sense tagged data, which is in short supply, would
%%%% it not?  I suppose it can create its own history of tagged results and
%%%% use this.
%%%% 
%%%% 
%%%% 
%%%% Note that because these are suppositions, we can fire them simply when
%%%% there is a probability of one being true (i.e. the monte carlo
%%%% system).  So, really the system ought to consider the probabilities of
%%%% all the things it is seeing and fire the most probable first.
%%%% 
%%%% Probabilities depend on existing data.
%%%% 
%%%% So it would be wise to find sources of from which we can derive the
%%%% supposition information and learn its probability.
%%%% 
%%%% This begs the question of the incorporation of existing systems for
%%%% doing tasks, such as existing parsers, etc.
