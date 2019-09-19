%% Look at NLU-MF stuff

%% load do-convert, write a loadable version of it

renderFormalizationQueue :-
	findall(File,formalize(File),FilesToFormalize),
	write_list(FilesToFormalize).

%% formalizeThisWithNLUMF/1, formalize/1, formalizeThisProperly/1, formalizeForHealthChart/2
%% task(TaskID,formalize(fileFn(File)),Importance).

%% (try to formalize all items in %% in FLP prolog files.)

%% (look for all instances of TRANSLATE THESE IMMEDIATELY in prolog
%%  and other files and formalize them as needed to get the job done

%%  (list
%%   (Justin's writings)
%%   (the bible (different versions))
%%   ()
%%   ))

%% (formalize everything that is of the form (formalize ?X) in our
%%  to.do lists)  use do-convert to do this

%% (use files from FLP f f o p to extract comments, and try to
%%  formalize them with nlu-mf)

%% (formalize Niall of the Nine hostages blacksmith fire thing,
%%  other such Irish stories and legends.)

%% (in progress (formalize Life of Hugh Roe O'Donnell))

%% formalize the things int the book formalization queue

%% (formalize US laws as part of life planner)

  %% (for the nlu-mf system, simply ask us to do the disambiguation
  %%  ourselves, when ambiguous, and then put that into formal stuff.
  %%  make it an emacs interface, maybe using manager-subset-select or
%%  something (once we get that fully working))

%% (read/formalize
%%  ("Martyrology of Donegal"))

%% (formalize Ann's photos)

%% (I could formalize goal oriented writings)

%% (begin formalizing Martin Lof randomness etc into Cyc)

%% (sync notes and finish formalizing them into the life planner)

%% (NLU-MF: our formalizations will be insufficient and we will have
%%  to add to them as deficiencies are found.  we will need some way
%%  of tracking and differentiating the different meanings.)

%% (Can work on planning software, or knowledge formalization
%%  software.  Seems planning software is more important somehow.
%%  Won't work as well without the knowledge.  Maybe I could write
%%  my own planner, cause I can't find any others.  Work on the FLUX
%%  stuff, since that's a perfectly good formalism to do it in.)

%% (I should rather work on the planner than on formalizing minutia
%%  of social interactions.)

%% (should be able to transliterate the text using mappings, and
%%  then bootstrap the formalizations, so I don't have to look them
%%  up myself.  tab completions on different senses and
%%  translations)

%% (write a system that if for instance someone asks nl manual
%%  formalize how long can you leave something in the freezer past the
%%  expiration date, it searches using a QA system through digilib
%%  and puts the answer into the formalization queue.)

%% (formalize (BOSS coordinates the software development of our internal
%% 	    codebases, the applications that we are writing to either
%% 	    effectively glue together external codebases as in most cases or
%% 	    as mostly independent projects (like Gourmet).  BOSS converses
%% 	    with Architect to coordinate development of icodebases with
%% 	    respect to overall goals, and RADAR and Machiavelli to provide a
%% 	    project development simulator for use in reasoning about other
%% 	    projects, and in general, to answer software development
%% 	    questions.  BOSS also automates many of the aspects of writing
%% 	    codebases.))

%% (we need to formalize the descriptions of projects.  we need to
%%  have the ability to query project information from prolog, such
%%  as the descriptions of projects (in frdcsa/FRDCSA.xml files))

 %% (we can do causality.  we can formalize it in cyc.  But there
 %%  are a lot of different aspects including various temporal
 %%  elements to causality, therefore we can't simply create one
 %%  relationship.  Have to study the philosophy of causality to
%%  know how to approach this.  Also to understand Cyc's system.)

%% CONTNIUE ~/to.do from this line

%% (which system is responsible for storing the contents of
%%  textbooks that have been formalized and extended?  Is it
%%  formalize, nlu, workhorse, digilib, cyc-common, freekbs2
%%  Figure  this out.)




%% for ~/latest.do

%%   (get the notes about the caregiving from the laptop, formalize
%%   them, find similar resources)

%%     (add a scheduling date of by the end of Feb 3 in order to have
%%     the file formalized.)

%%     (formalize this into the FLP
%%     https://www.newschallenge.org/challenge/healthdata/entries/personal-life-planning-assistant)

%%       (add the Bible and its story and other texts to the nlu-mf
%%  formalization queue)

%% formalize all relevant documents that have this as a parent dir:
%% /var/lib/myfrdcsa/codebases/minor/nlu/systems/mf/formalization-queue

notesAboutSource(internetSacredTextArchive,['specifically, get the wisdom literature, i.e. "Charity begins at home, etc".  There are good Christian, Judaical, Celtic etc.']).

formalizeThisWithNLUMF(internetSacredTextArchive).
hasDistributions(internetSacredTextArchive,[internetSacredTextArchiveDVDDistribution,internetSacredTextArchiveUSBDistribution]).

formalizeThisWithNLUMF(importantIRCConversationsWeHaveHad).

formalizeThisWithNLUMF(urlFn('https://www.dcc.fc.up.pt/~acm/turing-phd.pdf')).

formalizeThisWithNLUMF(urlFn('https://howtogeton.wordpress.com')).
formalizeThisWithNLUMF(urlFn('https://www.achieve-goal-setting-success.com/')).

formalizeThisWithNLUMF(theNewCatholicEncyclopedia2ndEdition15VolumeSetPlusSupplement).
