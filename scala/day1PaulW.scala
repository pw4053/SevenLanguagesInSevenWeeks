// Scala day 1
// tic tac toe
//
// use symbols to nominate board position
//    1 2 3
//    4 5 6
//    7 8 9

import collection.mutable.MutableList 

object Marker extends Enumeration {
     type Marker = String
     val EMPTY = " ";
     val X = "X";
     val O = "O";
}

import Marker._

class BoardCell() {
   var cellValue = EMPTY;
   val validCellValues = List(X,O);

   def setCellValue(value:String) = {
     if (!isValidValue(value)) {
        throw new IllegalStateException("Why are you entering " + value + " .");
     }
     if (isOccupied()) {
        throw new IllegalArgumentException("Cannot change cell value.");
     }
     this.cellValue = value;
   }

   override def toString():String = {
      if (isOccupied()) {
         return (this.getCellValue());
      } else {
         return ("-");
      }
   }

   def isOccupied() = {
      this.getCellValue() != Marker.EMPTY;
   }

   def isValidValue(value:String) = {
      validCellValues.contains(value);
   }

   def getCellValue() = {
      this.cellValue;
   }
}

class Board(size: Int) {
   val boardSize = size;
   val board = new MutableList[BoardCell];
   for(i <- 0 until calculateBoardSlots()) {
     board += new BoardCell();
   }


   def rows() = {
      board.grouped(boardSize);
   }

   def cols() = {
      board.zipWithIndex.groupBy(_._2 % boardSize).map(_._2.map(_._1))
   }

   def diags() = {
      MutableList(
        board.zipWithIndex.filter(_._2 % (boardSize + 1) == 0).map(_._1),
        board.zipWithIndex.filter(value => (value._2 % (boardSize) == 0) && (value._2 > 0) && (value._2 < board.length)).map(_._1)
      )
   }


   def allEqualxxxx(elements: MutableList[Marker]) = {
     !elements.contains(Marker.EMPTY) && elements.distinct.size == 1;
   }
   def allEqual(elements: MutableList[BoardCell]) = {
     !elements.contains(Marker.EMPTY) && elements.distinct.size == 1;
   }
   def anyListAllEqual(lists: TraversableOnce[MutableList[Marker]]): Boolean = {
      lists.foldLeft(false)(_ || allEqual(_));
   }
   def anyListAllEqual(lists: MutableList[MutableList[Marker]]): Boolean = {
      anyListAllEqual(lists.toIterator);
   }
   def boardWon(): Boolean  = {
//    anyListAllEqual(rows()) || anyListAllEqual(cols()) || anyListAllEqual(diags());
     return false;
   }
   def boardFull(): Boolean = {
      board.count(!_.isOccupied()) == 1;
   }

   def setCellValue(index:Int, value:String):Boolean = {
      if (index >= 0 && index <= calculateBoardSlots()) {
        board(index).setCellValue(value);
        return true;
      }
      return false;
   }

   override def toString():String = {
     var result = "\n";
     for(i <- 1 until calculateBoardSlots()) {
       result += " " + board(i);
       if (i > 0 && i % boardSize == 0) {
          result += " \n";
       }
     }
     return result;
   }

   def showEmptyCells():String = {
     var result = "\n";
     for(i <- 1 until calculateBoardSlots()) {
       result += " ";
       if (board(i).isOccupied()) {
          result += " ";
       } else {
          result += i;
       }
       if (i % boardSize == 0) {
          result += " \n";
       }
     }
     return result;
   }

   def calculateBoardSlots() = {
     boardSize * boardSize + 1;
    }

}

class TicTacToeGame() {

    val board = new Board(3);
    var currentPlayer = "X";

    def getNextPlayer(player:String):String = {
      if (player == "X"){
        return "O";
      } else {
        return "X";
      }
    }

    def play() {
       while (!board.boardFull() && !board.boardWon()) {
          println("Available board cells to fill :-");
          println(board.showEmptyCells());

          print("Player " + currentPlayer + ", which cell to fill? ");
          var cellIndex = Console.readInt();
          board.setCellValue(cellIndex, currentPlayer);

          currentPlayer = getNextPlayer(currentPlayer);
          println(board);
       }
    }
}

val game = new TicTacToeGame();
game.play();

