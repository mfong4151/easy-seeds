
module EasySeeds
    class Destroy
        ###For manually destroying tables, useful for if you have many joins tables. 
        def self.destroy_table(class_name, table_string)
            puts "Destroying the #{table_string} table"
            class_name.destroy_all
            ApplicationRecord.connection.reset_pk_sequence!(table_string)
        end
        
        
        ###Used in conjunction to destroy all of your tables
        def self.destroy_tables(class_names, table_strings)
            
            (class_names.length - 1).downto(0) {|i|EasySeeds.destroy_table(class_names[i], table_strings[i])}
        end
    end
end
    