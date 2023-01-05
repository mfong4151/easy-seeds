require_relative 'easy_seeder'

#example from my own seed data
  
class_names = [User, Restaurant, Menu, MenuItem]
class_image_names = [Listing, Users, Appointments]

EasySeeds.create_easy_seed_data(class_names)
EasySeeds.attach_images(class_image_names)


