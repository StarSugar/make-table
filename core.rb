class Array
  def each_index_and_data
    for i in 0...self.size do
      yield(i, self[i]);
    end
  end
end

def maketable(table)
  # wordlen in this function means longest word length in a column.
  def puts_table_level_edge(cols)
    res = "";
    res += '+';
    cols.each do |col|
      col[:wordlen].times do |i|
        res += '-';
      end
      res += '+';
    end
    res += "\n"
    return res;
  end
  def puts_table_vertical_edge(line, cols)
    res = "|";
    now_cols = 0;
    line.each_index_and_data do | index, word |
      now_cols += 1;
      spacelen = (cols[index][:wordlen] - word.length) / 2;
      spacelen.times do |i|
        res += ' ';
      end
      res += word;
      spacelen = cols[index][:wordlen] - word.length - spacelen;
      spacelen.times do |i|
        res += ' ';
      end
      res += '|'
    end
    (now_cols...cols.size).each do |i|
      spacelen = cols[i][:wordlen];
      spacelen.times do
        res += ' ';
      end
      res += '|';
    end
    res += "\n"
    return res;
  end
  linesiz = 0; colsiz = table.size;
  cols = [];
  # check size;
  if table.size == 0 then
    return ""
  end
  # get line size, column word length
  table.each do |line|
    cols.each_index_and_data do |i, d|
      if i < line.size then
        cols[i][:wordlen] = (d[:wordlen] > line[i].length) ? d[:wordlen] : line[i].length;
      end
    end
    if linesiz < line.size then
      (linesiz...line.size).each do |i|
        cols << {:wordlen => line[i].length};
        linesiz = line.size;
      end
    end
  end
  # make table
  res = ""
  res += puts_table_level_edge(cols);
  table.each do |line|
    res += puts_table_vertical_edge(line, cols);
    res += puts_table_level_edge(cols);
  end
  return res;
end

