
# define a sample Sudoku
board <- matrix(
  c(0,0,0,0,0,6,0,0,0,
    0,9,5,7,0,0,3,0,0,
    4,0,0,0,9,2,0,0,5,
    7,6,4,0,0,0,0,0,3,
    0,0,0,0,0,0,0,0,0,
    2,0,0,0,0,0,9,7,1,
    5,0,0,2,1,0,0,0,9,
    0,0,7,0,0,5,4,8,0,
    0,0,0,8,0,0,0,0,0),
  
  byrow = T,
  ncol = 9
)

#  a function that will find all of the empty cells on the board
find_empty_cells <- function(board) {
  which(board == 0, arr.ind = TRUE)
}

# Make sure cell placement is valid
is_valid <- function(board, num, row, col) {
  
  # Check if any cell in the same row has value = num
  if(any(board[row, ] == num)) {
    return(FALSE)
  }
  
  # Check if any cell in the same column has value = num
  if(any(board[, col] == num)) {
    return(FALSE)
  }
  
  # Get cells in num's box
  box_x <- floor((row - 1) / 3) + 1
  box_y <- floor((col - 1) / 3) + 1
  
  # Get subset of matrix containing num's box
  box <- board[(3 * box_x - 2):(3 * box_x), (3 * box_y - 2):(3 * box_y)]
  
  # Check if the number appears elsewhere in its box
  if(any(box == num)) {
    return(FALSE)
  }
  return(TRUE)
}


# Recursively solve the Sudoku

solve_sudoku <- function(board, needed_cells = NULL, index = 1) {
  # Find all empty cells
  if(is.null(needed_cells)) 
    needed_cells <- find_empty_cells(board)
  if(index > nrow(needed_cells)) {
    # Set result equal to current value of board
    # and return TRUE
    result <<- board
    return(TRUE)
  } else {
    row <- needed_cells[index, 1]
    col <- needed_cells[index, 2]
  }
  
  # Solve the Sudoku
  for(num in 1:9) {
    # Test for valid answers
    if(!is_valid(board, num, row, col)) {next} else{
      board2 = board
      board2[row, col] <- num
      # Retest with input
      if(solve_sudoku(board2, needed_cells, index + 1)) {
        return(TRUE)
      }
    }
  }
  # If not solvable, return FALSE
  return(FALSE)
}



solve_sudoku(board)




