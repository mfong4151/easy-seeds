require 'csv'


class String

    def convert_to_a
        res = []
        self.split("\n").each do |row| 
            temp = []
            row.each_char do |col| 
                temp << col
            end
            res << temp
        end
        res
    end

end



def unpack_csvs()
    #puts 'Please give type in the maze text file'
    #ui = gets.chomp
    ui = 'maze.txt'
    file = File.open(ui)
    text = file.read 
    
    file.close

    text.convert_to_a
end





def unpack_csvs(seed_file)
  data = []
  CSV.foreach(seed_file) do |row|
    data << row
  end
  headers = data.shift
  return headers, data
end

def type_conversion(datum, data_type = 'string')
  if ['text', 'string'].include?(data_type)
    return datum.to_s

  elsif ['int', 'integer', 'i'].include?(data_type)
    return datum.to_i

  elsif ['float', 'f'].include?(data_type)

    return datum.to_f
  else
    return datum
  end
end

def clean_headers(header)
  if header.include?(":")
    first, second = header.split(":")
    header_and_type = [first.downcase, second]
  else
    header_and_type = [header.downcase, 'string']
  end
  return header_and_type
end

seed_folder = './seedfolders'
Dir.chdir(seed_folder)

Dir.glob("*").each do |seed_file|

  seed_res = []
  headers, data = unpack_csvs(seed_file)

  data.each_with_index do |row, j|
    datum = {}

    row.each_with_index do |col, i|
        
      key = clean_headers(headers[i])
      datum[key[0]] = type_conversion(row[i], key[1])

    end

    seed_res << datum
  end
  title_as_array = seed_file.split("_")
  puts "#{title_as_array[0]} = #{seed_res}\n"
end





# CSV.open(ticker_file_path, "w") do |csv_writer|
#   csv_writer << []
# end
