=begin
    Common preconditions:
    1. table: Expects an array version of your table that corresponds to the name. 
        Your table MUST be formated as an array containing multiple hashes, see the example from my menu_items class on github.
        Because of how this is set up, the variable name MUST be equivalent to the name of the table in migrations.

    2. class_name: Expects the actual class name created in models. Expects an actual class variable.

    3. table_string: Table name given as a string. Usually used for destroying tables ahead of import. Expects a string

    Common Issues:

    Deleting: The issue occurs if theres a directed graph cycle relation between tables, or if there are joins tables with multiple presence constraints on the foreign keys. 
    Tip: To avoid this you have to typically drop the entire database, although this is obviously not recommended in production.

=end
module EasySeeds
end


require_relative "./version"
require_relative './seeder.rb'
require_relative './destroy.rb'
require_relative './images.rb'