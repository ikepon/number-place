class Table
  def initialize(number_table)
    @table = number_table
  end

  def table
    @table
  end

  def row(n)
    @table[n - 1]
  end

  def column(n)
    @table.transpose[n - 1]
  end

  # 3x3の正方形は左上から右に
  #   1,2,3
  #   4,5,6
  #   7,8,9
  # とする
  def square(n)
    div, mod = (n - 1).divmod(3)

    [
      @table[div * 3][(mod * 3)..(mod * 3 + 2)],
      @table[div * 3 + 1][(mod * 3)..(mod * 3 + 2)],
      @table[div * 3 + 2][(mod * 3)..(mod * 3 + 2)]
    ]
  end
end

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

print np.row(1)
print np.row(4)
print np.row(8)

print np.column(1)
print np.column(4)
print np.column(8)

print np.square(5)
print np.square(7)
print np.square(9)
