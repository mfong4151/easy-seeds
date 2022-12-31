require 'csv'

def unpack_csvs(seed_file)
    data = []
    CSV.foreach(seed_file) do |row|
      data << row
    end
    headers = data.shift
    headers.map{|header| header.to_sym}

    return headers, data
end



seed_folder = './seed_files'
Dir.chdir(seed_folder)



Dir.glob("*").each do |seed_file|

    seed_res = []
    headers, data = unpack_csvs(seed_file)

    print headers
    return
end