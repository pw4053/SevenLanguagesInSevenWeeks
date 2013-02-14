#! /usr/bin/env io

# start of my Io journey
# http://iolanguage.org/

# Some Io example problems
# http://en.wikibooks.org/wiki/Programming:Io
# http://progopedia.com/language/io/

# An Io community that will answer questions
# http://io-fans.jottit.com/

# A style guide with Io idioms
# http://en.wikibooks.org/wiki/Io_Programming/Io_Style_Guide


# Evaluate 1 + 1 and then 1 + "one". Is Io strongly typed or weakly typed?
1+1
1+"one"
#   Exception: argument 0 to method '+' must be a Number, not a 'Sequence'
# weakly typed - everything treated as a message

#########
# Is 0 true or false? What about the empty string? Is nil true or false?

0 == true
# ==> false

0 == false
# ==> false

0 == ""
# ==> false

"" == true
# ==> false

nil == true
# ==> false

nil = false
# ==> false

# ..... comparision operators return either the true or false

################
# How can you tell what slots a prototype supports
Xxx := Object clone
Xxx slotNames  # returns a list of the names of an object's slots
Xxx protos     # returns a list of the objects which an object inherits from



################
# What is the difference between = (equals), := (colon equals), and ::= (colon
colon equals)?

# ::=    Creates slot, creates setter, assigns value
#  :=    Creates slot, assigns value
#   =    Assigns value to a slot if it exists, otherwise raises an exception

a ::= 1   #  compiles to   newSlot("a", 1)
b  := 1   #  compiles to   setSlot("b", 1)
c   = 1   #  compiles to   updateSlot("c", 1)

##############
# Execute the code in a slot given its name.



newSlot("a", 1) 

Creates slot, creates setter, assigns value 



