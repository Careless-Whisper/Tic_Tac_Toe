require 'pry'
class Board
  attr_accessor :board
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
  puts
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-------------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-------------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  puts
  end

  def play(array)  #@info_player = [player.name, player.player_symbol, cell]
    if @board[array[2]] == " "
      if array[1] == "X"
        @board[array[2]] << "X"
      else
        @board[array[2]] << "O"
      end
    else
      puts "Tu sautes ton tour!"
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
    when @board[2] == @board[5] && @board[2] == @board[8] && @board[2] != " " && @board[2] != " " && @board[8] != " "
      return true
    when @board[0] == @board[4] && @board[0] == @board[8] && @board[0] != " " && @board[4] != " " && @board[8] != " "
      return true
    when @board[2] == @board[4] && @board[2] == @board[6] && @board[2] != " " && @board[4] != " " && @board[6] != " "
      return true
    when @board[1] == @board[4] && @board[1] == @board[7] && @board[1] != " " && @board[4] != " " && @board[7] != " "
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
    p "Quel est le nom du premier joueur ?"
    name_player_1 = gets.chomp
    p "#{name_player_1} vous avez le pion X"
    player_symbol_1 = "X"
    @player_1 = Player.new(name_player_1, player_symbol_1)
    p "Quel est le nom du second joueur ?"
    name_player_2 = gets.chomp
    p "#{name_player_2} vous avez les pions O"
    player_symbol_2 = "O"
    @player_2 = Player.new(name_player_2, player_symbol_2)
    @players = [@player_1, @player_2]
    @object_board = Board.new
  end

  def go
    puts "=======> Comment jouer ? <======="
    puts
    puts "Voici les numéros qu'il faudra indiquer "
    puts "pour placer vos pions :"
    puts
    puts "  1 | 2 | 3 "
    puts "-------------"
    puts "  4 | 5 | 6 "
    puts "-------------"
    puts "  7 | 8 | 9 "

    self.turn
  end

  def turn
      turns = 0  # initialise turn qui fera office de compteur
    while @object_board.win? == false do # tant que l'objet board sous la méthode retourne faux:
      @players.each{ |player|   # utilise display_board pour afficher l'objet_board
        @object_board.display_board #On affiche le tableau
        #p turns
        p "TOUR #{turns + 1} " #affiche le nombre de tours
        p "#{player.name} ! Où veux-tu placer ton pion ?"   #On demande une case à l'utilisateur
        p "Donne une valeur entre 1 et 9 :"   #affiche la demande à l'utilisateur
        n = gets.chomp.to_i    #enregistre la réponse dans une variable

          until n > 0 && n < 10   #jusqu'à ce que cette variable soit comprise entre 1 et 9
            puts "Veuillez renseigné un bon numéro"
            puts "Choisissez en un nouveau :"
            n = gets.chomp.to_i
          end
          n = n - 1  # on soustrait -1 pour qu'elle corresponde à un index
          #Ensuite on enregistre les informations de l'utilisateur dans un tableau (array)
          #Car on a besoin de les utiliser avec une méthode qui affecte la grille du tableau (@board)
        @info_player = [player.name, player.player_symbol, n]
        @object_board.play(@info_player)
        #puts @object_board.victory?

        if @object_board.win?
          @object_board.display_board

          puts "       Bravo #{player.name},Tu as gagné !    "
          puts ""
          puts "Voulez vous faire une nouvelle partie? (Y or N)"
          answer = gets.chomp
          if answer == "Y"
            Game.new.go
          else
            puts "Au revoir!"
          end
          break # on sort de la boucle each si c'est le joueur a gagné.
        end

      turns += 1 # incrémente le compteur de tour

      if turns == 9 # on sort de la boucle each si turns arrive à 9 et on annonce le draw.
        @object_board.display_board
        puts ""
        puts "C'est un draw"
        puts ""

        puts "Voulez vous faire une nouvelle partie? (Y or N)"
        answer = gets.chomp
        if answer == "Y"
          Game.new.go
        else
          puts "Au revoir!"
        end
        break
      end
      }
    end #Fin de While loop
  end
end

Game.new.go
