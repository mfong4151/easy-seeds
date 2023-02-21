require_relative 'easy_seeder'

  
class_names = [User, Restaurant, Menu, MenuItem]
class_image_names = [Restaurant, MenuItem]

EasySeeds.create_easy_seed_data(class_names)
EasySeeds.attach_images(class_image_names)


