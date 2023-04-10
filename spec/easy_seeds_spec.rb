require 'rails_helper'
require 'easy_seeds'

RSpec.describe EasySeeds do
  describe '.CSVLoader' do
    it 'should return an array of headers and data' do
      headers, data = EasySeeds::CSVLoader.unpack_csvs('spec/fixtures/test.csv')
      expect(headers).to eq(['id', 'name', 'email'])
      expect(data).to eq([
        ['1', 'John', 'john@example.com'],
        ['2', 'Jane', 'jane@example.com']
      ])
    end

    it 'should return the cleaned headers and data in the correct data type' do
      expect(EasySeeds::CSVLoader.clean_headers('ID:int')).to eq(['id', 'int'])
      expect(EasySeeds::CSVLoader.type_conversion('1', 'int')).to eq(1)
    end

    it 'should return all seed data from CSVs and their corresponding table strings' do
      data, table_strings = EasySeeds::CSVLoader.tables_from_csvs
      expect(table_strings).to eq(['users', 'products'])
      expect(data).to eq([
        [{'id'=>1, 'name'=>'John', 'email'=>'john@example.com'}, {'id'=>2, 'name'=>'Jane', 'email'=>'jane@example.com'}],
        [{'id'=>1, 'name'=>'Product 1', 'description'=>'Description 1', 'price'=>10.99}, {'id'=>2, 'name'=>'Product 2', 'description'=>'Description 2', 'price'=>20.99}]
      ])
    end
  end
end
