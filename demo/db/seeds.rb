require 'easy_seeds/easy_seeds' #Step 5.


##Initialize tables in order we want things to be seeded. There is a foreign key on Menus pointing to Restaurant, so we seed Restaurant first
##In other words, things should be seeded in the topologically sorted order.

class_names = [User, Restaurant, Menu, MenuItem, Review, Cart, CartItem, Transaction, Location]  #Step 6.
table_strings = ['users', 'restaurants', 'menus', 'menu_items', 'reviews', 'carts', 'cart_items', 'transactions', 'locations']

EasySeeds::Destroy.destroy_tables(class_names, table_strings)  #Optional: erases data in your tables. Sometimes it might be easier to just drop tables altogether

EasySeeds::Seeder.create_easy_seed_data(class_names)  #Step 7. 


class_image_names = [Restaurant]  #An example of seeding photos, please note that the demo files belong to a protected AWS bucket and will not work
EasySeeds::Images.attach_images(class_image_names)