# easy-seeds
Easy seeds for Ruby on Rails projects. Allows the use of CSV files for bulk seeding.


# Projects using easy seeds

https://willow-8s24.onrender.com/ : Fullstack web-app clone of Zillow with thematic elements
https://suber-eats.onrender.com/ : Fullstack web-app clone of Uber Eats


# The Upshot

Tired of the old fashion way of seeding your database? Have a lot of rows of data? No problem, just try and hard code all 500 rows by hand. Oh dear, where did I miss that comma?
If that's been your Ruby on Rails seeding experience, then look no further, Easy Seeds has got you covered.

With some slight modifications to your_project/db, you'll be on your way to a larger, faster, and more headache free seeding experience.

https://user-images.githubusercontent.com/5301131/230407876-c9b0d2b7-fa61-459c-961a-830369bb3147.mp4

# Setup instructions

The best way to read these setup instructions is to open the demo folder in e

1. Add the following line to your Gemfile:
```Ruby
gem 'easy_seeds'
```
2. Copy all your CSVs into `/db/seed_files` and `/db/seed_image_files` folder for files and images respectively. Your file names must be named the same as your tables. See the examples attached in the repo.
3. CSV files must be named in the the format "<number>_<tablename plural>.csv" e.g "1_users_seeds.csv". EasySeeds::Seeder.`#create_easy_seed_data` works by reading the rows you want created in the order of entry and creating them accordingly, so pay attention to how you name your .csv files.
4. Header column names follow the following format "name":"data_type". If a :"data_type" is not given, EasySeeds defaults to a string object.
5. At the top of your seeds.rb file:
```Ruby
require 'easy_seeds/easy_seeds'
```
6. Initialize an array of class_names following the order your seed CSVs are arranged in /db/seed_files or /db/seed_image_files. The reason for this is because Rails is largely agnostic as to what order you want your seed files to be loaded in. Generally you should seed the folders with items that don't have foreign keys first. 

```Ruby
##Initialize array members in order we want things to be seeded. There is a foreign key on menus pointing to restaurants, so we seed restairamts first
##Same goes for menuitems, cartitems, etc
class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]
```

 Now, intialize a list of strings that are lowercase, plural versions of their table counterpart. These should follow the same order:

```Ruby
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']
```


7. At the bottom of your your seeds.rb file call EasySeeds::Seeder.create_easy_seed_data(class_names)
```Ruby
EasySeeds::Seeder.create_easy_seed_data(class_names) 

8. Refer to the example included in ./demo/db if you get stuck! For convenience, heres what your file should look like:

```Ruby

require 'easy_seeds/easy_seeds' #Step 5.


##Initialize tables in order we want things to be seeded. There is a foreign key on Menus pointing to Restaurant, so we seed Restaurant first
##In other words, things should be seeded in the topologically sorted order.

class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]  #Step 6.
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']


EasySeeds::Seeder.create_easy_seed_data(class_names)  #Step 7. 


class_image_names = [Restaurant]

```


Now, lets say that you messed up on your table somehow. You need to reseed again.

9. When deleteing items from your tables, you generally want to go in the other direction: items with foreign keys first, items with foreign keys point to it last. Effectively, this is what EasySeeds::Destroy.destroy_tables() does. Your file should look something like this:

```Ruby
require 'easy_seeds/easy_seeds'

class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]  #Step 6.
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']

EasySeeds::Destroy.destroy_tables(class_names, table_strings) 

EasySeeds::Seeder.create_easy_seed_data(class_names)
```


## CSV Seed_Files Setup

See the samples for how CSVs are set up. The headers need to match the database column names exactly.
Use the format -- column_name:data_type -- for the headers. easy_seeds will do type conversion for you. Default is "string" and does not need to be declared.
Accepted data types: string, integer, float, boolean, date.
If you need an additional data type, ping Marcos or Max and we can update.

## CSV Images Setup

Easy_seeds has an image upload method built specifically for AWS dev and production buckets. Your buckets and permissions need to be set up separately. It uses images.attach() to attach the files to the relevant model using Active Storage. See the example for file structure. 
    
Seed image files Require an ID, URL and Filename. The Image path will be attached to the model instance matching the ID. The URL and Filename can be found directly in the AWS console.
    
See "Easy Seeder Setup" for information on file ordering.

## Easy Seeder Setup

File order matters!
Place your model names in class_names for each class you are making Seed Data for. Each class needs a separate CSV.

The order of class_names and the order of files in seed_files should match your migration order (to prevent null database constraint failures).
If you are using `EasySeeds#attach_images`, it must run after all database instances are created. It uses the value in class_image_names
to attach images to an instance of that ClassName and ID.

Hit us up with questions.


# Common Preconditions:

1. table: Expects an array version of your table that corresponds to the name.
    Your table MUST be formated as an array containing multiple hashes, see the example from my [menu_items class on github](https://github.com/mfong4151/Suber-Eats/tree/main/db/seed_files).
    Because of how this is set up, the variable name MUST be equivalent to the name of the table in migrations.
2. class_name: Expects the actual class name created in models. Expects an actual class variable.
3. table_string: Table name given as a string. Usually used for destroying tables ahead of import. Expects a string.

# Methods:

## EasySeeds::CSVMethods

The **CSVMethods** class provides methods for parsing and unpacking CSV files into usable seed data.


### unpack_csvs(seed_file):

Given a CSV file, returns an array of headers and an array of arrays containing data from the CSV.

### tables_from_csvs:
Given a directory of CSV files, returns an array of arrays containing seed data and an array of table names.

## EasySeeds::Seeder

The **Seeder** class provides methods for creating seed data.

### single_seeder(table, class_name, table_string):

Given a table (an array of hashes containing seed data), a class name (the name of the ActiveRecord class to seed), and a table string (the name of the table in the database), creates a single instance of seed data.

### create_easy_seed_data(class_names):

Given an array of class names (the names of the ActiveRecord classes to seed), creates easy seed data for all of the classes.

## EasySeeds::Images

The **Images** class provides methods for attaching images to seed data.


### attach_images(class_image_names):

Given an array of class names (the names of the ActiveRecord classes to attach images to), images to the seed data for each class.

## EasySeeds::Destroy

The **Destroy** class provides methods for destroying seed data.
Methods

### destroy_table(class_name, table_string):

Given a class name (the name of the ActiveRecord class to destroy) and a tablestring (the name of the table in the database), destroys the table and resets the primary key sequence.

### destroy_tables(class_names, table_strings):

Given an array of class names (the names of the ActiveRecord classes to destroy) and an array of table strings (the names of the tables in the database), this destroys all of the tables and resets their primary key sequences.


# Common Issues:

## Deleting:

The issue occurs if there's a directed graph cycle relation between tables, or if there are associative ("joins") tables with multiple presence constraints on the foreign keys, then deleting causes a referential integrity error.

Tip: To avoid this you have to typically drop the entire database, although this is obviously not recommended in
production.
