#!/usr/bin/ruby

require "./core.rb"

# string table to array table
def strtable2arrtable(str)
  res = [];
  enter_word = false;
  next_escape = false;
  str.each_line do |line|
    line_res = [];
    word = "";
    line.split("").each do |char|
      if enter_word then
        # check \"
        if next_escape then
          if char.eql? "\"" then
            word << "\"";
            next_escape = false;
            next;
          else
            word << "\\" << char;
            next_escape = false;
            next;
          end
        end
        # check special charactor
        if char.eql? "\"" then
          enter_word = !enter_word;
          line_res << word.clone;
          next
        elsif char.eql? "\\" then
          next_escape = true;
          next
        end
        word << char;
      elsif char.eql? "\"" then
        enter_word = !enter_word;
        word = "";
      end
    end
    res << line_res.clone;
  end
  return res;
end

$version_n = 10000
$version_s = "1.0.0"

if ARGV.size == 0 then
  puts "Thanks for using. Use option \"-h\" or \"--help\" for more information.";
  Process.exit;
end

if ARGV.size > 2 then
  puts "Too many options!"
end

str_table = ""

case ARGV[0]
when "-f", "--file"             then
  if !File.exist?(ARGV[1]) then
    puts "No such file #{ARGV[1]}.";
    Process::exit(1);
  end
  begin
    str_table = File::read(ARGV[1], mode: "rt");
  rescue IOError >> e
    puts e.message;
    Process::exit(1);
  end
when "-h", "--help"             then
  puts "Use option \"-v\" or \"--version\" to get Version.";
  puts "Use option \"-f\" or \"--file\" to specifie a file as input.";
  puts "Use option \"-i\" or \"--interactive\" to enter interactive mode.";
  puts "Use option \"-h\" or \"--help\" to show this page.";
  puts "";
  puts "If you put something like this:";
  puts "\"bar\"\"foo\"";
  puts "\"foo\"\"bar\"";
  puts "You will get something like this:";
  print "+---+---+\n|bar|foo|\n+---+---+\n|foo|bar|\n+---+---+\n"
  Process.exit;
when "-v", "--version"          then
  puts $version_s;
  Process.exit;
when "-i", "--interactive"      then
  puts "Puts an end sign:"
  end_sign = $stdin.readline.chomp;
  puts "Your end sign is #{end_sign}. "
  puts "The result will be shown after you type end sign verbatim on a blank"
  puts "line, then the process will be end."
  line = ""
  while(1)
    line = $stdin.readline.chomp;
    if line.eql? end_sign then
      break;
    end
    str_table << line.clone << "\n";
  end
else
  puts "No such option #{ARGV[0]}."
end

table = strtable2arrtable(str_table)
puts maketable(table)
