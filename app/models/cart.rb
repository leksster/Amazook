class Cart

  attr_accessor :session

  def initialize(cart_session)
    @session = cart_session
  end

  def subtotal
    subtotal = 0
    unless @session.nil?
      @session.each do |k, v|
        subtotal += Book.find(k).price * v
      end
      subtotal
    end
  end

  def books
    unless @session.nil?
      Book.find(@session.keys)
    end
  end

  def order_items
    items = []
    books.each do |book|
      items << OrderItem.new(price: book.price, qty: @session[book.id.to_s], book: book)
    end
    items
  end

  def build_order_for(user)
    order = user.orders.new(total_price: self.subtotal, completed_date: Time.now)
    order.order_items << self.order_items
    order
  end

  def add_book(book_id, qty)
    @session[book_id].nil? ? @session[book_id] = qty : @session[book_id] += qty
  end

  def remove_book(book_id)
    @session.delete(book_id)
  end

  def update_books(params)
    @session.each do |k, v|
      @session[k] = params[k].to_i
    end
  end
end