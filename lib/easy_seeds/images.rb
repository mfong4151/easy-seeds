require_relative 'easy_seeds/csv_methods'

module EasySeeds
    class Images
         #Attaches images
        include CSVS

        def self.attach_images(class_image_names)

            begin
          Dir.chdir('../seed_image_files')
            rescue
          Dir.chdir(Dir.pwd + '/db/seed_image_files')
            end
  
            Dir.glob("*").each_with_index do |seed_file, i|
          headers, data = EasySeeds.unpack_csvs(seed_file)
          class_image_name = class_image_names[i]
          puts "Attaching to #{class_image_name}..."
  
          data.each_with_index do |row|
  
              object_id, url, filename = row
              class_instance = class_image_name.find_by_id(object_id)
  
              begin
                class_instance.image.attach(io: URI.open(url), filename: filename)
                puts "Attached to #{filename}"
  
              rescue OpenURI::HTTPError
                puts('Waiting 30 seconds before seeding the next row of data, please be patient')
                sleep(30.second)
                class_instance.image.attach(io: URI.open(url), filename: filename)
                puts "Attached to #{filename}"
              end
          end
            end
        

        end
    end

end