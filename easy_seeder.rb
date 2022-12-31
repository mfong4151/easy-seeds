require 'csv'


class EasySeeds

    #1. table: accepts an array version of your table that corresponds to the name. 
        #Your table MUST be formated as an array containing multiple hashes, see the example from my menu_items class
        ##Because of how this is set up, the variable name MUST be equivalent to the name of the table in migrations

    #2. class_name, accepts the actual class name of your migration table. That's right, pass a class in as an argument.
        ##Named not according to convention in order to enhance readability

    #3. table_string table name as a as string. refers to the table you want to destroy on   ApplicationRecord.connection.reset_pk_sequence!('') 
        ##Someone else can do the hard work of finding a way to get rid of this variable


    def self.single_seeder(table, class_name, table_string)

        ApplicationRecord.transaction do 
            class_name.destroy_all
            ApplicationRecord.connection.reset_pk_sequence!(table_string)
            puts "Creating #{table_string}..."   
        
            table.each {|table_row| class_name.create!(**table_row)}
            
        end
        
        puts "DONE WITH #{table_string.upcase}, #{table_string.upcase} SEEDING SUCCESSFUL"
        
    end 

    ##class for creating multiple seeds
    def self.create_easy_seed_data(class_names)

            tables, table_strings = csv_to_seeds = EasySeeds.tables_from_csvs
        
            (0...tables.length).each do |i|
        
                class_name = class_names[i]
                EasySeeds.single_seeder(tables[i], class_name, table_strings[i])
            end
        
    end

    def self.unpack_csvs(seed_file)
      data = []
      CSV.foreach(seed_file) do |row|
        data << row
      end
      headers = data.shift
      headers.map{|header| header.to_sym}
    
      return headers, data
    end
    
    
    
    def self.type_conversion(datum, data_type = 'string')
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
    
    def self.tables_from_csvs
        
        all_seed_data = []
        table_strings = []
        seed_folder = './seed_files'

        
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
            
            
            table_strings << seed_file[seed_file.index('_')...seed_file.index('_seed.csv')]
            all_seed_data << seed_res
        end
        
        return all_seed_data, table_strings

    end


    def self.private_method

        puts "LOOK AT ME, I'M RUBY, THE LANGUAGE THAT PRETENDS TO HAVE ENCAPSULATION"
    end

    private

    ##Look at me im pretending to have encapsulation!

    def clean_headers(header)
        if header.include?(":")
          first, second, = header.split(":")
          header_and_type = [first.downcase, second]
        else
          header_and_type = [header.downcase, 'string']
        end
        return header_and_type
    end
end


      
      

#example from my test own project

menu_items =  [{item_name: 'Ha Tien Special Extra Large Combo Noodle Soup', menu_id: 1, price: 19.25, image: ''}, 
                {item_name: 'Combo Beef Noodle Soup', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Rare Beef', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Beef Meatball', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Rare Beef with Chicken', menu_id: 1, price: 16.75, image: ''}
            ]

table = menu_items
class_name = MenuItem
table_string = 'menu_items'


EasySeeds.single_seeder(table, class_name, table_string)




## in the future this will be the desired format


# class_names = [MenuItem, Menu, Restaurant, User]

EasySeeds.create_easy_seed_data(class_names)