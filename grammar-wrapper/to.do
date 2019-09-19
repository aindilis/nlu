(

Anyone want to work on anything? Here's an idea - take text and develop a universal natural language understanding system that produces standoff logical form assertions about the text, including all the usual suspects, plus additionally derived knowledge delineating possible (defeasible) meanings about text-spans. Also have assertions about the relationship between the contents of the text and the containing file or other source. So for instance, if you have a text-span in which is estimated to exist a self-contained sentence, you can assert that, as well as provide some evidence for it by linking to a memoized result of running a grammar parser on it like the Link Parser. That's the first step. The goal is to have the computer be a deliberative agent in the execution of tasks. You provide it with a model of the types of commands (shell/emacs/perl/APIs/etc) it can use, along with handlers for invoking these commands. Then, you obtain grammars for these languages and embed the parse results of sample commands in those languages into the NLU system, augmented by type information and other semantics. Finally, you develop a classical AI planning or intelligent agent domain, which embeds the grammatical constraints into the planning domain and so provides the ability to generate commands using AI planning. So for instance, you might parse "mv file.txt file2.txt", and so derive facts that there is an <expression> containing a <command> with <arg1> and <arg2> thus, and that (equals <arg1> "file.txt") etc, (isa "file.txt" FileName) (exists-file "file.txt") and (isa "file2.txt" FileName), and then link this to an action object in the planning domain. Then by AI planning and other domain specific knowledge, such as derived from scanning the filesystem, you might compose a command to move a file somewhere. The effects of the operations can be learned automatically by diffing the set of environmental observations, or explicitly via either conversion from man files, or from tacit programming of the preconditions and postconditions of effects. (such as here http://arxiv.org/pdf/1210.4889.pdf ) The end result should be a system that can initiate software commands/programming. For instance, the use of ssh could be added, as well as standard syntax for many CS-related concepts, and ultimately, you could have an intelligent agent that could transport itself from computer to computer, and provided with more knowledge, could defend or attack a network, manage system routines, and generally interface with a personal planning system for the automatic achievement of user goals stated in a natural language.

)

(
 (build a toy system that does the grammatical
  composition/planning, vm/cow running, fabric.sudo () command
  compostion and execution.)  send Jess a write-up of some
 system: 
 (Ideas: it used to be the case that when I would think,
  like during chess, I could almost visualize the thought as a
  discrete point in the space of thoughts, and have access to it's
  affordances intuitively.  And I could think by linking these
  different points together very quickly, and reaching new points.
  The entire expression or statement fit in a point.  So what I am
  thinking now is that I could build an AI which had such a way of
  thinking, which could think very quickly and reason with these
  points.  It makes sense to come up with a calculus of these
  points and their relationships.  Also, I keep thinking now that
  episodic logic is relevant in some way to this.

  Now the metalogic of FOL or something can have statements like
  S := U Phi_i, or something, and therefore that S is like that
  object.  But the S is relative to the logic it's in and the
  affordances in the APIs of the objects that are present.  So the
  API learner could be useful here.  The API learner learns the
  kinds/types of inputs and outputs that are expected by items, and
  how to use them.  It learns whether functions are applicative or
  effect free.  And it can learn sample inputs using Sayer.))
