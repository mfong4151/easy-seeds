
=begin

Example of what your seeds.rb file should look like. Full project at https://github.com/mfong4151/Suber-Eats

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

=end

require_relative './easy_seeds/easy_seeds.rb'


class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']

EasySeeds::Destroy.destroy_tables(class_names, table_strings)

puts 'Creating easy seeds data'
class_names.delete_at(-1)
EasySeeds::Seeder.create_easy_seed_data(class_names)

class_image_names = [Restaurant]
EasySeeds::Images.attach_images(class_image_names)