# easy_seeds
Easy seeder for rails seed projects. Allows use of csv files in rails seeding

1. Git clone or copy paste the easy_seeder.rb file into your rails /db folder. Remove the .git file to prevent nested repos.
2. Copy all your CSVs into a folder /db/seeds_resources folder. Your file names must be named the same as your tables. See the examples attached in the repo.
3. CSV files must be named in the the format "<number>_<tablename plural>.csv" e.g "1_users_seeds.csv". EasySeeds.create_easy_seed_data works by taking the table you want created first and making it, so be careful how you name your tables.
4. Header name columns follow the following format "name":"data_type". If a :"data_type" is not given, EasySeeds defaults to a string object.
5. require_relative "easy_seeder.rb" into your /db/seeds.rb file.
6. Initialize an array of class_names following the order your seed CSVs are arranged in /db/seeds/resources.
7. At the bottom of your your seeds.rb file call EasySeeds.create_easy_seed_data(class_names)
