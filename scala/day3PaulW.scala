import scala.io._
import scala.actors._
import Actor._

// START:loader
object PageLoader {
  def getPageSize(url : String) = getPageContent(url).length

  def getLinkCount(url:String):Int = {
     var linkCount = 0
     try {
        val webpage = getPageContent(url).mkString
        val linkr = new scala.util.matching.Regex("""<a\s+href="([^"]*?)"\s*>""", "linkurl")
        linkr.findAllIn(webpage).matchData.foreach { m => 
           if(m.subgroups(0).length>1 && !m.subgroups(0).startsWith("javascript:")) {
              linkCount = linkCount + 1
           }
        }
     }
     catch {
        case e: Exception =>
           println(e.toString)
     }
     linkCount
  }

  def getPageContent(url: String) = Source.fromURL(url).mkString;

}
// END:loader

val urls = List("http://www.amazon.com/", 
               "http://www.twitter.com/",
               "http://www.google.com/",
               "http://www.cnn.com/" )

// START:time
def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageSizeSequentially() = {
 for(url <- urls) {
   println("Size for " + url + ": " + PageLoader.getPageSize(url))
 }
}
// END:sequential

// START:concurrent
def getPageSizeConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getPageSize(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, size) =>
       println("Size for " + url + ": " + size)            
   }
 }
}

def getNoLinksConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getLinkCount(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, noLinks) =>
       println("Links within " + url + ": " + noLinks)            
   }
 }
}
// END:concurrent

// START:script
println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }
timeMethod { getNoLinksConcurrently }
// END:script


