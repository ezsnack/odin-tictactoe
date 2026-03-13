require "curses"

require "./Grid.rb"
require "./Player.rb"
require "./Choice.rb"

field_size = 3
field = Grid.new(field_size)
players = [Player.new("X"), Player.new("O")]
current = 0 # index to select the current player
min_rounds_to_win = field_size * 2 - 1
rounds_played = 0
max_rounds = field_size * field_size

def win(winner)
  puts "#{winner} wins!"
end

def draw
  puts "Draw!"
end

Curses.init_screen
Curses.noecho
Curses.cbreak
w = Curses::Window.new(field_size + 2, field_size + 2, 0, 0)
w.keypad(true)
w.box("|", "-", players[current].symbol)
y = 1
w.setpos(y, 1)
field.grid.each do |line|
  line.each do |cell|
    w.addch(cell) # addch also advances the cursor to the right
  end
  y += 1
  w.setpos(y, 1)
end
w.setpos(1, 1)
w.refresh

loop do # this is the game loop
  choice = Choice.new(nil, nil, players[current].symbol)
  chosen = false
  until chosen do
    case w.getch
    when Curses::Key::ENTER, "\n".ord, " "
      if (w.inch & Curses::A_CHARTEXT).chr == " "
        choice.y = w.cury - 1
        choice.x = w.curx - 1
        field.fill(choice)
        w.addch(players[current].symbol)
        chosen = true
      end
    when Curses::Key::UP, "w", "k"
      if w.cury - 1 > 0
        w.setpos(w.cury - 1, w.curx)
      end
    when Curses::Key::DOWN, "s", "j"
      if w.cury + 1 < w.maxy - 1
        w.setpos(w.cury + 1, w.curx)
      end
    when Curses::Key::LEFT, "a", "h"
      if w.curx - 1 > 0
        w.setpos(w.cury, w.curx - 1)
      end
    when Curses::Key::RIGHT, "d", "l"
      if w.curx + 1 < w.maxx - 1
        w.setpos(w.cury, w.curx + 1)
      end
    end
    w.refresh
  end
  rounds_played += 1
  if rounds_played >= min_rounds_to_win
    if field.check_victory(choice)
      w.close
      Curses.close_screen
      win(players[current].symbol)
      break
    end
    if rounds_played == max_rounds
      w.close
      Curses.close_screen
      draw
      break
    end
  end
  current = (current == 0) ? 1 : 0
  w.setpos(0, 0)
  w.box("|", "-", players[current].symbol)
  w.setpos(1, 1)
  w.refresh
end
