class Table
  def initialize(number_table)
    @table = number_table
  end

  def table
    @table
  end

  def row(row_number)
    @table[row_number - 1]
  end

  def include_row?(row, number)
    row(row).include?(number)
  end

  def column(column_number)
    @table.transpose[column_number - 1]
  end

  def include_column?(column, number)
    column(column).include?(number)
  end

  # 3x3の正方形は左上から右に
  #   1,2,3
  #   4,5,6
  #   7,8,9
  # とする
  def square(square_number)
    div, mod = (square_number - 1).divmod(3)

    [
      @table[div * 3][(mod * 3)..(mod * 3 + 2)],
      @table[div * 3 + 1][(mod * 3)..(mod * 3 + 2)],
      @table[div * 3 + 2][(mod * 3)..(mod * 3 + 2)]
    ].flatten
  end

  def include_square?(square, number)
    square(square).include?(number)
  end

  def solve

  end
end

# 例題はここのサンプルを使ってる http://www.puzzlegame.jp/gameinfo/number_place.php
table = [
  [0, 0, 7, 0, 3, 0, 2, 0, 0],
  [0, 4, 0, 8, 2, 7, 0, 3, 0],
  [6, 0, 3, 0, 0, 0, 9, 0, 7],
  [0, 5, 0, 7, 0, 4, 0, 1, 0],
  [4, 7, 1, 0, 8, 0, 5, 2, 9],
  [0, 3, 0, 2, 0, 1, 0, 4, 0],
  [8, 0, 5, 0, 0, 0, 3, 0, 1],
  [0, 6, 0, 5, 1, 9, 0, 7, 0],
  [0, 0, 2, 0, 6, 0, 4, 0, 0]
]

np = Table.new(table)

puts np.include_row?(2, 2)
puts np.include_column?(2, 3)
puts np.include_square?(2, 1)
