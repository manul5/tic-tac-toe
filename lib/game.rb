class Game

  @@board = Array.new(3) {Array.new(3, " ")}

  def self.print_board()
    for i in 0..2
      for j in 0..2
        print "[ " << @@board[i][j] << " ]"
      end
      puts ""
    end
  end

  def self.is_empty?
    count = 0
    for i in 0..2
      for j in 0..2
        if @@board[i][j] == " "
          count += 1
        end
      end
    end
    if count.positive?
      true
    else
      false
    end
  end

  def self.check_rows?(player)
    check = false
    for i in 0..2
      count = 0
      for j in 0..2
        if @@board[i][j] == player
          count += 1
        end
      end
      if count == 3
        check = true
      end
    end
    return check
  end

  def self.check_columns?(player)
    check = false
    for i in 0..2
      count = 0
      for j in 0..2
        if @@board[j][i] == player
          count += 1
        end
      end
      if count == 3
        check = true
      end
    end
    return check
  end

  def self.check_diagonals?(player)
    if @@board[0][0] == player && @@board[1][1] == player && @@board[2][2] == player
      return true
    elsif @@board[2][0] == player && @@board[1][1] == player && @@board[0][2] == player
      return true
    else
      return false
    end
  end

  def self.check_tateti?(player)
    check_diagonals?(player) || check_rows?(player) || check_columns?(player)
  end

  def self.play_round(player)
    played = false
    puts "Elegí la fila en la que querés poner tu ficha (del 0 al 2)"
    row = gets.chomp!.to_i
    puts "Elegí la columna en la que querés poner tu ficha (del 0 al 2)"
    column = gets.chomp!.to_i
    if !(0..2).include?(row) || !(0..2).include?(row)
      puts "El número ingresado no es válido"
    else
      if @@board[row][column] == " "
        @@board[row][column] = player
        played = true
      else
        puts "El casillero ya está ocupado, elija otro"
      end
      print_board
    end
    played
    
  end

  def self.play_game()
    players = ["X","O"]
    number = Random.new.rand(2)
    current_player = players[number]
    player_won = ""
    puts "Bienvenido al juego del TATETI"
    
    while is_empty?
      puts "---------------------------------------------"
      puts "Es el turno del jugador #{current_player}"
      while !play_round(current_player)
      end
      if check_tateti?(current_player)
        player_won = current_player
        break
      end
      if number == 0
        number = 1
        current_player = players[number]
      else
        number = 0
        current_player = players[number]
      end
    end

    puts "---------------------------------------------"
    if !player_won.empty?
      puts "GANÓ #{player_won}"
    else
      puts 'EMPATE'
    end
  end
end
