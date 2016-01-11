require_relative '../config/environment'
  describe 'Models' do
    context 'Book' do
      it 'should be a Book class' do
        expect(Book.is_a?(Class)).to be_truthy
        expect(Book < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:book) { Book.new }
        it { is_expected.to respond_to(:title) }
        it { is_expected.to respond_to(:description) }
        it { is_expected.to respond_to(:price) }
        it { is_expected.to respond_to(:qty) }
      end
      it 'should have defined database structure' do
        expect(Book.column_types["title"].type).to eq :string
        expect(Book.column_types["description"].type).to eq :text
        expect(Book.column_types["price"].type).to eq :decimal
        expect(Book.column_types["qty"].type).to eq :integer
      end
      context 'Validators:' do
        it 'does not allow a Book without parameters' do
          expect(Book.new).to_not be_valid
        end
        it 'does not allow a Book without title' do
          expect(Book.new(qty: 12, price: 24.5)).to_not be_valid
        end
        it 'does not allow a Book without price' do
          expect(Book.new(title: 'Book#1', qty:2)).to_not be_valid
        end
        it 'does not allow a Book without qty' do
          expect(Book.new(title: 'Book#1', price:4)).to_not be_valid
        end
        it 'allows a Book with price, qty and title' do
          expect(Book.new(title: 'Book#1', price: 24.5, qty:2)).to be_valid
        end
      end 
    end

    context 'Category' do
      it 'should be a Category class' do
        expect(Category.is_a?(Class)).to be_truthy
        expect(Category < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:category) { Category.new }
        it { is_expected.to respond_to(:title) }
      end
      it 'should have defined database structure' do
        expect(Category.column_types["title"].type).to eq :string
      end
      context 'Validators:' do
        it 'does not allow a Category without parameters' do
          expect(Category.new).to_not be_valid
        end
        it 'allows a Category with title' do
          expect(Category.new(title: 'Horror')).to be_valid
        end
        it 'should be unique Category name' do
          Category.create(title: 'Horror')
          expect(Category.new(title: 'Horror')).to_not be_valid
          Category.find_by(title: 'Horror').destroy
        end
      end 
    end

    context 'Author' do
      it 'should be an Author class' do
        expect(Author.is_a?(Class)).to be_truthy
        expect(Author < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Author.new }
        it { is_expected.to respond_to(:firstname) }
        it { is_expected.to respond_to(:lastname) }
        it { is_expected.to respond_to(:biography) }
      end
      it 'should have defined database structure' do
        expect(Author.column_types["firstname"].type).to eq :string
        expect(Author.column_types["lastname"].type).to eq :string
        expect(Author.column_types["biography"].type).to eq :text
      end
      context 'Validators:' do
        it 'does not allow an Author without parameters' do
          expect(Author.new).to_not be_valid
        end
        it 'does not allow an Author without firstname' do
          expect(Author.new(lastname: 'Smith', biography: 'Lorem ipsum dolor.')).to_not be_valid
        end
        it 'does not allow an Author without lastname' do
          expect(Author.new(firstname: 'Smith', biography: 'Lorem ipsum dolor.')).to_not be_valid
        end
        it 'allows an Author with lastname and firstname only' do
          expect(Author.new(firstname: 'Me', lastname:"Gusta")).to be_valid
        end
        it 'allows an Author with firstname, lastname and bio' do
          expect(Author.new(firstname: 'Smith', biography: 'Lorem ipsum dolor.', lastname: "Alex")).to be_valid
        end
      end 
    end

    context 'Rating' do
      it 'should be an Rating class' do
        expect(Rating.is_a?(Class)).to be_truthy
        expect(Rating < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Rating.new }
        it { is_expected.to respond_to(:review_text) }
        it { is_expected.to respond_to(:rating) }
      end
      it 'should have defined database structure' do
        expect(Rating.column_types["review_text"].type).to eq :text
        expect(Rating.column_types["rating"].type).to eq :integer
      end
    end
    context 'Customer' do
      it 'should be an Customer class' do
        expect(Customer.is_a?(Class)).to be_truthy
        expect(Customer < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Customer.new }
        it { is_expected.to respond_to(:email) }
        it { is_expected.to respond_to(:password) }
        it { is_expected.to respond_to(:firstname) }
        it { is_expected.to respond_to(:lastname) }
      end
      it 'should have defined database structure' do
        expect(Customer.column_types["firstname"].type).to eq :string
        expect(Customer.column_types["lastname"].type).to eq :string
        expect(Customer.column_types["email"].type).to eq :string
        expect(Customer.column_types["password"].type).to eq :string
      end
      context 'Validators:' do
        it 'does not allow a Customer without parameters' do
          expect(Customer.new).to_not be_valid
        end
        it 'does not allow a Customer without firstname' do
          expect(Customer.new(lastname: 'Smith', email: 'me@me.me', password: 'secret')).to_not be_valid
        end
        it 'does not allow a Customer without lastname' do
          expect(Customer.new(firstname: 'Smith', email: 'me@me.me', password: 'secret')).to_not be_valid
        end
        it 'does not allow a Customer without email' do
          expect(Customer.new(firstname: 'Smith', lastname: 'Smith', password: 'secret')).to_not be_valid
        end
        it 'does not allow a Customer without password' do
          expect(Customer.new(firstname: 'Smith', email: 'me@me.me', lastname: 'Smm')).to_not be_valid
        end
        it 'allows a Customer with firstname, lastname, email and password' do
          expect(Customer.new(firstname: 'Smith', email: 'me@me.me', lastname: 'Smm', password: '123456')).to be_valid
        end
      end 
    end
    context 'Order' do
      it 'should be an Order class' do
        expect(Order.is_a?(Class)).to be_truthy
        expect(Order < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Order.new }
        it { is_expected.to respond_to(:total_price) }
        it { is_expected.to respond_to(:completed_date) }
        it { is_expected.to respond_to(:state) }
      end
      it 'should have defined database structure' do
        expect(Order.column_types["total_price"].type).to eq :decimal
        expect(Order.column_types["completed_date"].type).to eq :date
        expect(Order.column_types["state"].type).to eq :string
      end
      context 'Validators:' do

      end 
    end
    context 'OrderItem' do
      it 'should be an OrderItem class' do
        expect(OrderItem.is_a?(Class)).to be_truthy
        expect(OrderItem < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { OrderItem.new }
        it { is_expected.to respond_to(:price) }
        it { is_expected.to respond_to(:qty) }
      end
      it 'should have defined database structure' do
        expect(OrderItem.column_types["price"].type).to eq :decimal
        expect(OrderItem.column_types["qty"].type).to eq :integer
      end
      context 'Validators:' do

      end 
    end
    context 'Address' do
      it 'should be an Address class' do
        expect(Address.is_a?(Class)).to be_truthy
        expect(Address < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Address.new }
        it { is_expected.to respond_to(:address) }
        it { is_expected.to respond_to(:zipcode) }
        it { is_expected.to respond_to(:city) }
        it { is_expected.to respond_to(:phone) }
        it { is_expected.to respond_to(:country) }
      end
      it 'should have defined database structure' do
        expect(Address.column_types["address"].type).to eq :string
        expect(Address.column_types["zipcode"].type).to eq :string
        expect(Address.column_types["city"].type).to eq :string
        expect(Address.column_types["phone"].type).to eq :string
        expect(Address.column_types["country"].type).to eq :string
      end
      context 'Validators:' do

      end 
    end
    context 'Country' do
      it 'should be an Address class' do
        expect(Country.is_a?(Class)).to be_truthy
        expect(Country < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { Country.new }
        it { is_expected.to respond_to(:name) }
      end
      it 'should have defined database structure' do
        expect(Country.column_types["name"].type).to eq :string
      end
      context 'Validators:' do

      end 
    end
    context 'CreditCard' do
      it 'should be an CreditCard class' do
        expect(CreditCard.is_a?(Class)).to be_truthy
        expect(CreditCard < ActiveRecord::Base).to be_truthy
      end
      context 'should have defined properties' do
        subject(:author) { CreditCard.new }
        it { is_expected.to respond_to(:number) }
        it { is_expected.to respond_to(:cvv) }
        it { is_expected.to respond_to(:expiration_year) }
        it { is_expected.to respond_to(:expiration_month) }
        it { is_expected.to respond_to(:firstname) }
        it { is_expected.to respond_to(:lastname) }
      end
      it 'should have defined database structure' do
        expect(CreditCard.column_types["number"].type).to eq :string
        expect(CreditCard.column_types["cvv"].type).to eq :string
        expect(CreditCard.column_types["expiration_year"].type).to eq :integer
        expect(CreditCard.column_types["expiration_month"].type).to eq :integer
        expect(CreditCard.column_types["firstname"].type).to eq :string
        expect(CreditCard.column_types["lastname"].type).to eq :string
      end
      context 'Validators:' do

      end 
    end

  end