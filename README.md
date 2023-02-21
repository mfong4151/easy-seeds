# easy_seeds
Easy seedes for Ruby on Rails projects. Allows the use of csv files for bulk seeding.


# The Upshot

Tired of the old fashion way of seeding your database? Have a lot of rows of data? No problem, just try and hard code all 500 rows by hand. Oh dear, where did I miss that comma? 
If that's been your rails seeding experience, then look no further, easy seeds has got you covered. 

With some slight modifications to your_project/db, you'll be on your way to a larger, faster, and more headache free seeding experience.

# Setup instructions

1. Git clone or copy paste the easy_seeds.rb file into your rails /db folder. Remove the .git file to prevent nested repos.
2. Copy all your CSVs into a folder /db/seeds_resources folder. Your file names must be named the same as your tables. See the examples attached in the repo.
3. CSV files must be named in the the format "<number>_<tablename plural>.csv" e.g "1_users_seeds.csv". EasySeeds.create_easy_seed_data works by reading the table you want created in order of entry and creating them accordingly, so pay attention to how you name your .csv files.
4. Header collumn names follow the following format "name":"data_type". If a :"data_type" is not given, EasySeeds defaults to a string object.
5. require_relative "easy_seeds.rb" into your /db/seeds.rb file.
6. Initialize an array of class_names following the order your seed CSVs are arranged in /db/seeds/resources.
7. At the bottom of your your seeds.rb file call EasySeeds.create_easy_seed_data(class_names)
8. Refer to the example included in ./demo/db if you get stuck!

## CSV Seed_Files Setup 

See the samples for how CSV's are set up. The headers need to match the database column names exactly. 
Use the format -- column_name:data_type -- for the headers. easy_seeds will do type conversion for you. Default is "string" and does not need to be declared. 
Accepted data types: string, integer, float, boolean, date. 
If you need an additional data type ping Marcos or Max and we can update. 

## CSV Image Setup

Seed image files Require a Id, URL and Filename. You can copy these last two straight from the AWS console.
the Id will attach the image path to that Id's object instance. See "Easy Seeder Setup" for information on file ordering. 

## Easy Seeder Setup 

File order matters!
Place your model names in class_names for each class you are making Seed Data for. Each class needs its own CSV. 

The order of class_names and the order of files in seed_files should match your migration order (to prevent null database constraint failures).
EasySeeds.attach_images runs after all database instances are created. It uses the value in class_image_names 
to attach images to an instance of that Class_Name and Id. 

hit us up with questions. 


# Projects using easy seeds
    
    https://willow-8s24.onrender.com/
    https://suber-eats.onrender.com/
    

# Common Preconditions:

1. table: Expects an array version of your table that corresponds to the name. 
    Your table MUST be formated as an array containing multiple hashes, see the example from my menu_items class on github.
    Because of how this is set up, the variable name MUST be equivalent to the name of the table in migrations.
2. class_name: Expects the actual class name created in models. Expects an actual class variable.
3. table_string: Table name given as a string. Usually used for destroying tables ahead of import. Expects a string


# Common Issues:

    Deleting: The issue occurs if theres a directed graph cycle relation between tables, or if there are joins tables with multiple presence constraints on the foreign keys. 
    Tip: To avoid this you have to typically drop the entire database, although this is obviously not recommended in production.

