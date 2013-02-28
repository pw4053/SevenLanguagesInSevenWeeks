// Use foldLeft to compute the total size of a list of strings


val aList = List("abc", "de", "fghi", "jklmnopqrstuvwxyz");
println(aList);
println(aList.foldLeft(0)((totalSize, str) => totalSize + str.size));

println("-------------------------------------------");

trait Censor {
   val replacements = Map("Shoot" -> "Pucky", "Darn" -> "Beans");
   def censor(text:String):String = {
      replacements.foldLeft(text) (
         (censoredContent, replaceContent) =>
             censoredContent.replaceAll(replaceContent._1, replaceContent._2)
      )
   }
}

class Reviewer() extends Censor {

}

val workIt = new Reviewer();
val before = "Shoot the Darn pig";
println(before);
println(workIt.censor(before));


