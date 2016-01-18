# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Book.delete_all


# 10.times { Author.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Hipster.paragraph(2))} 

class Generator
  def self.generate_books(n)
    n.times do 
      book = Book.new(title: Faker::Book.title, description: Faker::Hipster.paragraph(2), price: Faker::Commerce.price, qty: Faker::Number.between(1, 10))
      book.category = Category.find(rand(Category.ids.first..Category.ids.last))
      book.author = Author.find(rand(Author.ids.first..Author.ids.last))
      book.save
    end
  end
end


Generator.generate_books(30)
