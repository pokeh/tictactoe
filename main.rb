#!/usr/bin/env ruby

class Game
  VALUE_HUMAN = "X"
  VALUE_AI    = "O"

  def initialize
    @board = Array.new(3) { Array.new(3) }
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
      [-1,-1],
      [-1,0],
      [-1,1],
      [0,-1],
      [0,1],
      [1,-1],
      [1,0],
      [1,1]
    ]
  end

  def place(location)
    row, col = location.split(",").map(&:to_i)
    if (!row.between?(0, 2)) || (!col.between?(0, 2))
      puts 'Row and col have to be between 0 and 2!'
      return false
    end
    if !@board[row][col].nil?
      puts 'Location already taken!'
      return false
    end

    @board[row.to_i][col.to_i] = VALUE_HUMAN
    true
  end

  def ai_place
    puts "[AI] Hmm..."
    sleep 0.2
    row, col = @board.find(VALUE_AI)
    unless row != nil
      @vicinity.each do |delta|
        trial_row = row + delta[0]
        trial_col = col + delta[1]

        if @board[trial_row][trial_col]&.nil?
          @board[trial_row][trial_col] = VALUE_AI
          return
        end
      end
    end

    row, col = find(nil)
    @board[row][col] = VALUE_AI
  end

  def find(target)
    @board.each_with_index do |row, i|
      row.each_with_index do |value, j|
        return i, j if value == target
      end
    end

    return nil
  end

  def is_done
    if is_win(VALUE_HUMAN)
      puts "You won!"
      return true
    elsif is_win(VALUE_AI)
      puts "AI won!"
      return true
    end

    if @board.find(nil)
      false
    else
      puts "It's a tie!"
      true
    end
  end

  def is_win(value)
    @wins.each do |win|
      check = win.map{|location| @board[location[0]][location[1]] == value }
      return true if check.all? true
    end
    false
  end

  def print_board
    @board.each do |row|
      row.each {|value| print "|#{value}|" }
      print "\n"
    end
  end
end

game = Game.new
game.print_board
while !game.is_done
  loop do
    print "Your turn. Enter row,col: "
    location = $stdin.gets()
    break if game.place(location)
  end
  game.print_board
  if game.is_done
    break
  else
    game.ai_place
    game.print_board
  end
end
