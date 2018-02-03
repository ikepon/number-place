require 'pry'

class Table
  NUMBERS = [*1..9]
  def initialize(number_table)
    @table = number_table
  end

  def table
    @table
  end

  def complete?
    table.flatten.count { |n| n == 0 } == 0
  end

  def row(row_number)
    @table[row_number - 1]
  end

  def row_count(row_number)
    row(row_number).count { |n| n != 0 }
  end

  def row_count_hash
    (1..9).each.with_object({}) do |n, hash|
      hash[n] = row_count(n)
    end
  end

  def max_rows
    max_value = row_count_hash.values.max
    row_count_hash.select{ |_, v| v == max_value }.keys
  end

  def include_row?(row, number)
    row(row).include?(number)
  end

  def column(column_number)
    @table.transpose[column_number - 1]
  end

  def column_count(column_number)
    column(column_number).count { |n| n != 0 }
  end

  def column_count_hash
    (1..9).each.with_object({}) do |n, hash|
      hash[n] = column_count(n)
    end
  end

  def max_columns
    max_value = column_count_hash.values.max
    column_count_hash.select{ |_, v| v == max_value }.keys
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

  def square_count(square_number)
    square(square_number).count { |n| n != 0 }
  end

  def square_count_hash
    (1..9).each.with_object({}) do |n, hash|
      hash[n] = square_count(n)
    end
  end

  def max_squares
    max_value = square_count_hash.values.max
    square_count_hash.select{ |_, v| v == max_value }.keys
  end

  def include_square?(square, number)
    square(square).include?(number)
  end

  # 行列番号から属している square を出す
  # あとでキレイにしたい
  def belong_square_number(n, m)
    if (1..3).include?(n)
      if (1..3).include?(m)
        1
      elsif (4..6).include?(m)
        2
      elsif (7..9).include?(m)
        3
      end
    elsif (4..6).include?(n)
      if (1..3).include?(m)
        4
      elsif (4..6).include?(m)
        5
      elsif (7..9).include?(m)
        6
      end
    elsif (7..9).include?(n)
      if (1..3).include?(m)
        7
      elsif (4..6).include?(m)
        8
      elsif (7..9).include?(m)
        9
      end
    end
  end

  def solve
    # 10回繰り返し、解ければ終わり、解けなければ10回までの結果をそれぞれ返す
    10.times do |n_time|
      # 行を上から順番に見ていく
      (1..9).each do |n|
        # 行にない数値を出す
        unused_number = Table::NUMBERS - row(n)

        # 0 の箇所を調べる
        row(n).each.with_index(1) do |number, index|
          next if number != 0

          # 行にない数値が当てはまるか見ていく
          candidate_numbers = unused_number - column(index) - square(belong_square_number(n, index))
          if candidate_numbers.length == 1
            table[n - 1][index - 1] = candidate_numbers.join.to_i
          end
        end
      end
      puts "---#{n_time + 1}回目---"
      print table

      if complete?
        puts "---解けたよ---"
        break
      end
    end
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

np.solve
