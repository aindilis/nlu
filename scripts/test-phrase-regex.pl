#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $scalar = 'Location: http://nlp.cs.rpi.edu/kbp/2014/tools.html                                                  
                       NIST TAC Knowledge Base Population (KBP2014) Entity Linking Track            
                                                                                                    
[tac-logo]             Validators:                                                                  
                                                                                                    
  * Overview             * Validator for KBP 2013 English Entity-Linking submission file:           
  * Task Definition        check_kbp2013_english-entity-linking.pl v1.1 (September 13, 2013)        
  * Annotation           * Validator for KBP 2013 Chinese Entity-Linking submission file:           
    Guideline              check_kbp2013_chinese-entity-linking.pl (September 16, 2013)             
  * Scorer               * Validator for KBP 2013 Spanish Entity-Linking submission file:           
  * Tools                  check_kbp2013_spanish-entity-linking.pl (September 16, 2013)             
  * Data                                                                                            
  * Reading List                                                                                    
  * Mailing List       Publicly Available Entity Linkers/Entity Clusterers/Wikifiers:               
  * Registration       (collected and recommended by Heng Ji, Feb 2014, highly biased and           
  * TAC 2014           incomplete, suggestions are welcome)                                         
                                                                                                    
                         * UIUC Wikifier                                                            
                                                                                                    
                         * DBpediaSpotlight                                                         
                                                                                                    
                         * AIDA                                                                     
                                                                                                    
                         * SemLinker (will be available at the end of Feb 2014)                     
                                                                                                    
                         * THD: (A wikifier for English, German and Dutch)                          
                                                                                                    
                         * UMASS KBBridge and its extension that plugs into UMass\'s factorie NLP    
                           pipeline                                                                 
                                                                                                    
                         * Tagme Wikifer                                                            
                         * RPI\'s Old KBP Toolkit including an Entity Linker and a Slot Filler       
                                                                                                    
                         * RPI\'s Cross-document Entity Clustering Algorithms                        

                       Publicly Available Name Taggers:                                             
                                                                                                    
                         * UIUC Name Tagger                                                         

                       Publicly Available Relation Extractors                                       

                       Publicly Available Event Extractors                                          

';

my $phrase = 'entity clustering algorithms';
my @all = $scalar =~ /(.*?)\b(\Q$phrase\E)\b(.*?)/isg;
print Dumper({All => \@all});
