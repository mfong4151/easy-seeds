require_relative './csv_methods'

module EasySeeds
  class Seeder

    #Creates a single instance of seed data
    def self.single_seeder(table, class_name, table_string)
      ApplicationRecord.connection.reset_pk_sequence!(table_string)
      puts "Creating #{table_string} seed data..."

      table.each_with_index do |row, i|
        puts "Finished Seeding the #{i.to_s}th #{table_string} item" if i % 100 == 0
        class_name&.create!(**row)
      end

      puts "DONE WITH #{table_string.upcase}, #{table_string.upcase} SEEDING SUCCESSFUL"
    end

    #Creates easy seed data for all classes that are passed in
    def self.create_easy_seed_data(class_names)
      puts 'Creating easy seeds data'
      tables, table_strings = EasySeeds::CSVLoader.tables_from_csvs

      (0...tables.length).each do |i|
        EasySeeds::Seeder.single_seeder(tables[i], class_names[i], table_strings[i])
      end
    end
  end
end
