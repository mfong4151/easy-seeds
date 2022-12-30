# easy_seeds
Easy seeder for rails seed projects. Allows use of csv files in rails seeding

1. Git clone or copy paste the easy_seeder.rb file into your rails /db folder. Remove the .git file to prevent nested repos.
2. Copy all your CSVs into a folder /db/seeds_resources folder. Your file names must be named the same as your tables. See the examples attached in the repo.
3. Header name columns follow the following format "name":"data_type".
4. require_relative "easy_seeder.rb" into your /db/seeds.rb file.
5. Initialize an array of class names following the alphabetical your seed CSVs are arranged in /db/seeds/resources.
