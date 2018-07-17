require 'pry'
class Board
  attr_accessor :board
   def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
   end

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "--- --- --- "
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "--- --- --- "
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def play(array) #@info_player = [player.name, player.player_symbol, cell]
    if @board[array[2]] == " "
      if array[1] == "X"
        @board[array[2]] << "X"
      else
        @board[array[2]] << "O"
      end
    else
      puts "Tu saute ton tour !"
    end
  end

  def win?
    case
    when @board[0] == @board[1] && @board[0] == @board[2] && @board[0] != " " && @board[1] != " " && @board[2] != " "
      return true
    when @board[3] == @board[4] && @board[3] == @board[5] && @board[3] != " " && @board[4] != " " && @board[5] != " "
      return true
    when @board[6] == @board[7] && @board[6] == @board[8] && @board[6] != " " && @board[7] != " " && @board[8] != " "
      return true
    when @board[0] == @board[3] && @board[0] == @board[6] && @board[0] != " " && @board[3] != " " && @board[6] != " "
      return true
    when @board[1] == @board[4] && @board[1] == @board[7] && @board[1] != " " && @board[4] != " " && @board[7] != " "
      return true
    when @board[2] == @board[5] && @board[2] == @board[8] && @board[2] != " " && @board[5] != " " && @board[8] != " "
      return true
    when @board[0] == @board[4] && @board[0] == @board[8] && @board[0] != " " && @board[4] != " " && @board[8] != " "
      return true
    when @board[2] == @board[4] && @board[2] == @board[6] && @board[2] != " " && @board[4] != " " && @board[6] != " "
      return true
    else
      return false
    end
  end
end


class Player
  attr_accessor :name, :player_symbol

  def initialize(name, player_symbol)
    @name = name
    @player_symbol = player_symbol
  end
end

class Game

  def initialize
    puts "Quel est le nom du premier joueur ?"
    player_1 = gets.chomp
    puts "Vous avez le pion X "
    pion_1 = "X"
    @player_1 = Player.new(player_1, pion_1)
    puts "Quel est le nom du second joueur ?"
    player_2 = gets.chomp
    puts "Vous avez le pion O "
    pion_2 = "O"
    @player_2 = Player.new(player_2, pion_2)
    @players = [@player_1, @player_2]
    @objet_board = Board.new
  end

  def go
    # présentation du jeu, bienvenue, etc (avec des puts)
    self.turn
  end

  def turn
    turns = 0   # initialise turn qui fera office de compteur
    while @objet_board.win? == false do # tant que l'objet board sous la méthode retourne faux:
      @players.each { |player|
        @objet_board.display_board   # utilise display_board pour afficher l'objet_board
        p player.name
        puts "Tour #{turns}"  #affiche le nombre de tours
        puts "Selectionnez la case à jouer, chiffre 1 à 9" #affiche la demande à l'utilisateur
        cell = gets.chomp.to_i #enregistre la réponse dans une variable
        until cell > 0 && cell < 10 #jusqu'à ce que cette variable soit comprise entre 1 et 9
          puts "Selectionnez la case à jouer, chiffre 1 à 9" #affiche la demande à l'utilisateur
          cell = gets.chomp.to_i
        end
        cell -= 1 # on soustrait -1 pour qu'elle corresponde à un index
        #Ensuite on enregistre les informations de l'utilisateur dans un tableau (array)
        #Car on a besoin de les utiliser avec une méthode qui affecte la grille du tableau (@board)
        @info_player = [player.name, player.player_symbol, cell]
        @objet_board.play(@info_player)

      if @objet_board.win?
        @objet_board.display_board
        puts " Bravo #{player.name} ! tu as gagné!"
        puts "Voullez-vous faire une nouvelle partie ? (Y or N)"
        answer = gets.chomp
        if answer == "Y"
          Game.new.go
        else
          puts "Au revoir Mamène !!"
        end
        break
      end
      turns += 1 # incrémente le compteur de tour

      if turn == 9
        @objet_board.display_board
        puts "C'est une égalité ! Dommage t'avais parié un grec !"
        puts "Voullez-vous faire une nouvelle partie ? (Y or N)"
        answer = gets.chomp
        if answer == "Y"
          Game.new.go
        else
          puts "Au revoir Mamène !!"
        end
        break
      end
    }
    end
  end
end
Game.new.go
