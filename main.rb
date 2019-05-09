#!/usr/bin/env ruby

class Game
  def initialize
    @board = Array.new(3) { Array.new(3) }
    @is_x = true
    @wins = [
      [[0,0], [0,1], [0,2]],
      [[1,0], [1,1], [1,2]],
      [[2,0], [2,1], [2,2]],
      [[0,0], [1,0], [2,0]],
      [[0,1], [1,1], [2,1]],
      [[0,2], [1,2], [2,2]],
      [[0,0], [1,1], [2,2]],
      [[0,2], [1,1], [2,0]],
    ]

    @vicinity = [
      [-1,0],
      [1,0],
      [0,-1],
      [0,1],
      [-1,-1],
      [1,1]
    ]
  end

  # TODO: validate the input value from STDIN
  # - that it's an integer
  # - that it's not already taken
  def place(location)
    row, col = location.split(",")
    # @board[row.to_i][col.to_i] = @is_x ? "X" : "O"
    # if @is_x
    #   @board[row.to_i][col.to_i] = "X"
    # else
    #   @board[row.to_i][col.to_i] = "O"
    # end
    @board[row.to_i][col.to_i] = "X"
    computer_place()
    @is_x = !@is_x
  end

  # TODO: isolate method to check emptiness of neighboring locations
  # TODO: better name for "location"
  def computer_place
    @board.each_with_index do |row, i|
      row.each_with_index do |value, j|
        if value == "O"
          if @board[i][j-1].nil?
            @board[i][j-1] == "0"
          else if @board[i][j-1].nil?

        end
      end
    end
  end

  # TODO: print result to console
  def is_done
    # TODO: create a method to determine if X/O has won
    # check if X has won
    @wins.each do |win|
      all_three_is_x = true
      win.each do |location|
        if @board[location[0]][location[1]] != "X"
          all_three_is_x = false
        end
      end

      return true if all_three_is_x
    end
    # check if O has won
    @wins.each do |win|
      all_three_is_x = true
      win.each do |location|
        if @board[location[0]][location[1]] != "O"
          all_three_is_x = false
        end
      end

      return true if all_three_is_x
    end
    # TODO: simplify logic
    # check if it's a tie
    is_full = true
    @board.each do |row|
      row.each do |value|
        if value.nil?
          is_full = false
          break
        end
      end
    end

    return is_full
  end

  def print_board
    @board.each do |row|
      row.each do |value|
        print("|#{value}|")
      end
      print("\n")
    end
  end
end

game = Game.new
game.print_board
while !game.is_done
  location = $stdin.gets()
  game.place(location)
  game.print_board
end
