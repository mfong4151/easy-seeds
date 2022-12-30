
#1. table: accepts an array version of your table that corresponds to the name. 
    #Your table MUST be formated as an array containing multiple hashes, see the example from my menu_items class
    ##Because of how this is set up, the variable name MUST be equivalent to the name of the table in migrations

#2. class_name, accepts the actual class name of your migration table. That's right, pass a class in as an argument.
    ##Named not according to convention in order to enhance readability

#3. table_string table name as a as string. refers to the table you want to destroy on   ApplicationRecord.connection.reset_pk_sequence!('') 
    ##Someone else can do the hard work of finding a way to get rid of this variable



def seeder(table, class_name, table_string)

    ApplicationRecord.transaction do 
        class_name.destroy_all
        ApplicationRecord.connection.reset_pk_sequence!(table_string)
        puts "Creating #{table_string}..."   
    
        table.each {|table_row| class_name.create!(**table_row)}
        
    end
    
    puts "DONE WITH #{table_string.upcase}, #{table_string.upcase} SEEDING SUCCESSFUL"
    
end 
      
      

#example from my test own project

menu_items =  [{item_name: 'Ha Tien Special Extra Large Combo Noodle Soup', menu_id: 1, price: 19.25, image: ''}, 
                {item_name: 'Combo Beef Noodle Soup', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Rare Beef', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Beef Meatball', menu_id: 1, price: 16.75, image: ''}, 
                {item_name: 'Rare Beef with Chicken', menu_id: 1, price: 16.75, image: ''}
            ]

table = menu_items
class_name = MenuItem
table_string = 'menu_items'

seeder(table, class_name, table_string)