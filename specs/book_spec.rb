require_relative 'book'
require 'rspec'

describe Book do
  let(:book) { Book.new('Test Book', 'Test Author') }

  describe '#initialize' do
    it 'creates a new book with title and author' do
      expect(book.title).to eq('Test Book')
      expect(book.author).to eq('Test Author')
    end

    it 'initializes an empty rentals array' do
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'creates a new Rental instance and adds it to rentals array' do
      person = double('Person')
      date = '2023-10-09'
      rental = book.add_rental(person, date)

      expect(rental).to be_a(Rental)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(rental.date).to eq(date)
      expect(book.rentals).to include(rental)
    end
  end
end
