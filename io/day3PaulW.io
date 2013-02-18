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


###########################################################
# pretty print XML with attributes
#
# book({"author": "Tate"}...) would print <book author="Tate">

OperatorTable addAssignOperator(":", "atXmlAttribute")

Map atXmlAttribute := method(
    self atPut(
write("..atPutNumber:", evalArgAt(0), evalArgAt(1))
        call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
        call evalArgAt(1)
    )
)
        
Builder curlyBrackets := method(
    newMap := Map clone
    call message arguments foreach(arg,
        newMap doMessage(arg)
#        newMap atPut(arg name, arg next next name)
    )
    return newMap
)

Builder formatAttrs := method(m,
   attrString := "" asMutable
   m foreach(k,v,
        attrString appendSeq(" ", k asMutable removeSeq("\""), "=", v)
   )
   return attrString
)

Builder forward = method(
   nextArg := self doMessage(call message arguments at(0))
   if (nextArg type == "Map", attrList := formatAttrs(nextArg), attrList := "")

   prefix := ("   " repeated(self depth()))
   writeln(prefix, "<", call message name, attrList,  ">")
   self setDepth (self depth() + 1)
   isFirst := true
   call message arguments foreach(
      arg,
      content := self doMessage(arg)
      if(content type == "Sequence", writeln(prefix, content))
   )
   self setDepth (self depth() - 1)
   writeln(prefix, "</", call message name, ">")
)

Builder book({"author" : "Tate"},
       li({"xxx" : "2", "yyy" : "3"}, "Io"),
       li("Lua"),
       li("JavaScript")
)


