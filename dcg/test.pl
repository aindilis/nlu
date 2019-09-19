as --> [].
as --> [a].
as --> [a, b], as.

cliche(X) -->
	thing(X),
	" is a ",
	type_of_thing(X),
	" trapped in a ",
	opposite_type_of_thing(X),
	" body.".
thing(1) --> "Cygwin".
thing(2) --> "Fluffy".
type_of_thing(1) --> "Unix OS".
type_of_thing(2) --> "dog".
opposite_type_of_thing(1) --> "Windows'".
opposite_type_of_thing(2) --> "cat's".

fizz_buzz(Msg) --> anything, fizz(Msg), anything, buzz, anything.
anything --> [].
anything --> [_], anything.
fizz(Msg) -->
	"fizz",
	{
	 format('At fizz we have Msg=~w~n', [Msg])
	}.
buzz -->
	"buzz".

s --> subject," ",verb_phrase," ",object," ",direct_object_phrase.
subject --> ("I";"He";"She";"It").
verb_phrase --> ("walks";"eats";"flies";"sails"), " ",("to";"near").
object --> article,("pier";"catwalk";"domicile").
article --> ("a " ; "the ").
direct_object_phrase --> preposition," ",article,direct_object.
preposition --> ("at";"over";"across").
direct_object --> ("bank"; "ATM"; "station").

at_end --> \+ [_].

%% term_expansion/2 - a mechanism analogous to macros in other languages.