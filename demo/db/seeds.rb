require 'easy_seeds/easy_seeds'


##Initialize tables in order we want things to be seeded. There is a foreign key on Menus pointing to Restaurant, so we seed Restaurant first
##In other words, things should be seeded in the topologically sorted order.

class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']

EasySeeds::Destroy.destroy_tables(class_names, table_strings)

EasySeeds::Seeder.create_easy_seed_data(class_names)


class_image_names = [Restaurant]
EasySeeds::Images.attach_images(class_image_names)