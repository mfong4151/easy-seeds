# easy_seeds
Easy seeder for rails seed projects. Allows use of csv files in rails seeding

Setup instruction

1. Git clone or copy paste the easy_seeder.rb file into your rails /db folder. Remove the .git file to prevent nested repos.
2. Copy all your CSVs into a folder /db/seeds_resources folder. Your file names must be named the same as your tables. See the examples attached in the repo.
3. CSV files must be named in the the format "<number>_<tablename plural>.csv" e.g "1_users_seeds.csv". EasySeeds.create_easy_seed_data works by taking the table you want created first and making it, so be careful how you name your tables.
4. Header name columns follow the following format "name":"data_type". If a :"data_type" is not given, EasySeeds defaults to a string object.
5. require_relative "easy_seeder.rb" into your /db/seeds.rb file.
6. Initialize an array of class_names following the order your seed CSVs are arranged in /db/seeds/resources.
7. At the bottom of your your seeds.rb file call EasySeeds.create_easy_seed_data(class_names)


# Setup instructions

___ CSV Seed_Files Setup ____

See the samples for how CSV's are set up. The headers need to match the database column names exactly. 
Use the format -- column_name:data_type -- for the headers. Easy_Seeder will do type conversion for you. Default is "string" and does not need to be declared. 
Accepted data types: string, integer, float, boolean, date. 
If you need an additional data type ping Marcos or Max and we can update. 

___ CSV Seed_Files Setup ____

Seed image files Require a Id, URL and Filename. You can copy these last two straight from the AWS console.
the Id will attach the image path to that Id's object instance. See "Easy Seeder Setup" for information on file ordering. 

___ Easy Seeder Setup ___

File order matters!
Place your model names in class_names for each class you are making Seed Data for. Each class needs its own CSV. 

The order of class_names and the order of files in seed_files should match your migration order (to prevent null database constraint failures).
EasySeeds.attach_images runs after all database instances are created. It uses the value in class_image_names 
to attach images to an instance of that Class_Name and Id. 

hit us up with questions. 
