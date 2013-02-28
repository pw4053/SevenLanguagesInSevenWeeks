// Scala day 1
// tic tac toe
//
// use symbols to nominate board position
//    1 2 3
//    4 5 6
//    7 8 9
import collection.mutable.MutableList 


class TicTacToeBoardCell() {
   val EMPTY = " ";
   val validCellValues = List("X","O");
   var cellValue = EMPTY;

   def setCellValue(value:String) = {
     if (!isValidValue(value)) {
        throw new IllegalStateException("Why are you entering " + value + " .");
     }
     if (isOccupied()) {
        throw new IllegalArgumentException("Cannot change cell value.");
     }
     cellValue = value;
   }

   def == (target: TicTacToeBoardCell ):Boolean = {
     return this.getCellValue() == target.getCellValue();
   }

   override def toString():String = {
      if (isOccupied()) {
         return (this.getCellValue());
      } else {
         return ("-");
      }
   }

   def isOccupied() = {
      getCellValue() != EMPTY;
   }

   def isValidValue(value:String) = {
      validCellValues.contains(value);
   }

   def getCellValue() = {
      cellValue;
   }
}

class TicTacToeBoard() {
   val boardSize = 3;
   val board = new MutableList[TicTacToeBoardCell];
   for (i <- 0 until calculateBoardSlots()) {
     board += new TicTacToeBoardCell();
   }


   val winningCombinations = List(
      List(0,1,2), List(3,4,5), List(6,7,8),         // rows
      List(0,3,6), List(1,4,7), List(2,5,8),         // columns
      List(0,4,8), List(2,4,6)                       // diagonals
   );


   def boardWon(): Boolean  = {
      winningCombinations.foreach(path =>
        if (pathContainsWinner(path)) {
           return true;
        }      
      );
     return false;
   }

   def boardFull(): Boolean = {
      board.count(!_.isOccupied()) == 0;
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
     for(i <- 0 until calculateBoardSlots()) {
       result += " " + board(i);
       if ((i+1) % boardSize == 0) {
          result += " \n";
       }
     }
     return result;
   }

   def showEmptyCells():String = {
     var result = "\n";
     for(i <- 0 until calculateBoardSlots()) {
       result += " ";
       if (board(i).isOccupied()) {
          result += " ";
       } else {
          result += i;
       }
       if ((i+1) % boardSize == 0) {
          result += " \n";
       }
     }
     return result;
   }

   def calculateBoardSlots() = {
     boardSize * boardSize;
   }

   def pathContainsWinner(path: List[Int]) = {
      val cell1 = board(path(0));
      val cell2 = board(path(1));
      val cell3 = board(path(2));
 
      cell1.isOccupied() && cell1 == cell2 && cell1 == cell3;
   }
}

class TicTacToeGame() {

    val board = new TicTacToeBoard();
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

