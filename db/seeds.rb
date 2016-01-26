require 'faker'
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
Rating.delete_all
User.delete_all


def generate_users(n)
  n.times do
    user = User.new(email: Faker::Internet.email, password: Faker::Internet.password(8), firstname: Faker::Name.first_name, lastname: Faker::Name.last_name)
    user.save!
  end
end

# 10.times { Author.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Hipster.paragraph(2))} 
def generate_books(n)
  n.times do 
    book = Book.new(title: Faker::Book.title, description: Faker::Hipster.paragraph(2), price: Faker::Commerce.price, qty: Faker::Number.between(1, 10))
    book.save!
  end
end

def generate_authors(n)
  n.times do
    author = Author.new(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Lorem.paragraph(2))
    rand(1..5).times do
      author.books << Book.find(rand(Book.ids.sort.first..Book.ids.sort.last))
    end
    author.save!
  end
end

def generate_categories(n)
  n.times do
    category = Category.new(title: Faker::Book.genre)
    rand(1..10).times do
      category.books << Book.find(rand(Book.ids.sort.first..Book.ids.sort.last))
    end
    category.save!
  end
end

def generate_ratings(n)
  n.times do
    rating = Rating.new(review_text: Faker::Hipster.paragraph(2), rating: rand(1..10))
    rand(1..5).times do
      User.find(rand(User.ids.sort.first..User.ids.sort.last)).ratings << rating
      Book.find(rand(Book.ids.sort.first..Book.ids.sort.last)).ratings << rating
    end
    rating.save!
  end
end


generate_users(10)
generate_books(30)
generate_authors(10)
generate_categories(4)
generate_ratings(20)
