# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Book.delete_all
Author.delete_all
Category.delete_all


# 10.times { Author.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Hipster.paragraph(2))} 

class Generator
  def self.generate_books(n)
    n.times do 
      book = Book.new(title: Faker::Book.title, description: Faker::Hipster.paragraph(2), price: Faker::Commerce.price, qty: Faker::Number.between(1, 10))
      book.save!
    end
  end

  def self.generate_authors(n)
    n.times do
      author = Author.new(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Lorem.paragraph(2))
      rand(1..5).times do
        author.books << Book.find(rand(Book.ids.sort.first..Book.ids.sort.last))
      end
      author.save!
    end
  end

  def self.generate_categories(n)
    n.times do
      category = Category.new(title: Faker::Book.genre)
      rand(1..10).times do
        category.books << Book.find(rand(Book.ids.sort.first..Book.ids.sort.last))
      end
      category.save!
    end
  end
end


Generator.generate_books(30)
Generator.generate_authors(10)
Generator.generate_categories(7)
