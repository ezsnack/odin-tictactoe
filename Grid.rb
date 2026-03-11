class Grid
  attr_reader :grid_size, :grid

  def initialize(size)
    @grid_size = size
    @grid = Array.new(self.grid_size) {Array.new(self.grid_size, " ")}
  end

  def check_vertical(choice)
    score = 1
    next_y = choice.y + 1
    while next_y < self.grid_size do
      if self.grid[next_y][choice.x] == choice.symbol
        score += 1
        next_y += 1
      else
        break
      end
    end
    next_y = choice.y - 1
    while next_y >= 0 do
      if self.grid[next_y][choice.x] == choice.symbol
        score += 1
        next_y -= 1
      else
        break
      end
    end
    score == self.grid_size
  end

  def check_horizontal(choice)
    score = 1
    next_x = choice.x + 1
    while next_x < self.grid_size do
      if self.grid[choice.y][next_x] == choice.symbol
        score += 1
        next_x += 1
      else
        break
      end
    end
    next_x = choice.x - 1
    while next_x >= 0 do
      if self.grid[choice.y][next_x] == choice.symbol
        score += 1
        next_x -= 1
      else
        break
      end
    end
    score == self.grid_size
  end

  def check_diagonal_down(choice)
    score = 1
    next_x = choice.x + 1
    next_y = choice.y + 1
    while next_x < self.grid_size && next_y < self.grid_size do
      if self.grid[next_y][next_x] == choice.symbol
        score += 1
        next_x += 1
        next_y += 1
      else
        break
      end
    end
    next_x = choice.x - 1
    next_y = choice.y - 1
    while next_x >= 0 && next_y >= 0 do
      if self.grid[next_y][next_x] == choice.symbol
        score += 1
        next_x -= 1
        next_y -= 1
      else
        break
      end
    end
    score == self.grid_size
  end

  def check_diagonal_up(choice)
    score = 1
    next_x = choice.x - 1
    next_y = choice.y + 1
    while next_x >= 0 && next_y < self.grid_size do
      if self.grid[next_y][next_x] == choice.symbol
        score += 1
        next_x -= 1
        next_y += 1
      else
        break
      end
    end
    next_x = choice.x + 1
    next_y = choice.y - 1
    while next_x < self.grid_size && next_y >= 0 do
      if self.grid[next_y][next_x] == choice.symbol
        score += 1
        next_x += 1
        next_y -= 1
      else
        break
      end
    end
    score == self.grid_size
  end

  def check_victory(choice)
    self.check_horizontal(choice) ||
    self.check_vertical(choice) ||
    self.check_diagonal_down(choice) ||
    self.check_diagonal_up(choice)
  end

  def fill(choice)
    self.grid[choice.y][choice.x] = choice.symbol
  end
end
