#! /usr/bin/env io

###########################################################
# add indentation to the XML structure output

Builder := Object clone
Builder depth ::= 0;

Builder forward := method(
  prefix := ("   " repeated(self depth()))
  writeln(prefix, "<", call message name, ">")
  self setDepth (self depth() + 1)
  call message arguments foreach(
     arg,
     content := self doMessage(arg);
     if(content type == "Sequence", writeln(prefix, content))
  )
  self setDepth (self depth() - 1)
  writeln(prefix, "</", call message name, ">")
)

Builder ul(
       li("Io"),
       li("Lua"),
       li("JavaScript")
)

###########################################################
# Create a list syntax that uses brackets
#  xx := { 10, 11, 12 }
#
# the use of curly brackets (or curly braces) causes the curlyBrackets()
# method to be invoke in the context of the current object

curlyBrackets := method(

     newList := call message() arguments() map(
          value,
          self doMessage(value);
     )
 
     return(newList);
)

xx := {10,11,12}
xx println
xx size() println








