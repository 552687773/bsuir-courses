def open_files(file_name)
  if File.exist?("#{file_name}.tree")
    puts add_to_level(File.read("#{file_name}.tree"))
  elsif file_name.nil?
    all_trees
  else
    puts 'such a tree does not grow in this forest'
  end
end

def comma_delete(str)
  str.each_char{ |char| str.sub!(char,' ') if char==',' }
end

def find_level(str)
  comma_delete(str)
  level = str.scan(/\[\d*\s*\d*\]/).to_s
  comma_delete(level)
end

def add_to_level(str,lvl = 0,hash = {})
  find_level_lvl = 1 + lvl
  find_level_hash = hash
  find_level_hash[find_level_lvl]||= find_level(str)
  if comma_delete(str).gsub!(/\[\d*\s*\d*\]/,' ') =~ /\d/
    find_level_hash[find_level_lvl+1] = find_level(str)
    add_to_level(comma_delete(str).gsub!(/\[\d*\s*\d*\]/,' '),find_level_lvl,find_level_hash)
  end
  show (find_level_hash)
end
def show(hash)
  tree_array = hash.values.reverse
  array_to_print = tree_array.map {|item| item.to_s.scan(/\d+/).join(" ") }
  array_to_print.each_index{ |index| array_to_print[index] = array_to_print[index].center(array_to_print.last.length) }
  forest_control(array_to_print)
end

def draw_directory
  files = []
  work_directory = Dir.pwd
  dir_of_files = Dir.entries(work_directory)
  dir_of_files.sort!
  dir_of_files.each do |files_to_push|
    files.push(files_to_push) if files_to_push =~ /.tree/ }
    files
  end
end

def all_trees
  draw_directory.each do |files_name|
  puts 'Do you want to continue?[y/n]'
  name = gets.chomp
  if name == 'Y' || name == 'y'
    puts add_to_level(File.read(files_name.to_s))
  elsif name == 'N' || name == 'n'
    puts 'Good bye'
    exit
  else
    puts 'wrong'
    redo
  end
  end
end

def forest_control(arr,sum = 0)
  arr_for_sum =arr
  kek = arr_for_sum.join.scan(/\d+/)
  kek.each { |item| sum += item.to_i }
  trees_array = []
  if sum > 5000 || arr_for_sum.count > 5
    decision = 'cut down'
  else
    decision = 'leave alone'
  end
  trees_array[0] = arr_for_sum
  trees_array[2] = decision.center(arr_for_sum.last.length)
  trees_array[1] = ' '
  trees_array
end
open_files(ENV['NAME'])
