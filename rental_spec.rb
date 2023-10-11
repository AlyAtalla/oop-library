#  require_relative 'rental'
# require_relative 'book'
# require_relative 'person'
# require 'rspec'
# describe Rental do
#   let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
#   let(:person) { Person.new(25, 'John Doe', parent_permission: true) }
#   let(:date) { '2023-10-09' }
#   subject(:rental) { Rental.new(book, person, date) }
#   describe '#initialize' do
#     it 'creates a rental with a book, person, and date' do
#       expect(rental.book).to eq(book)
#       expect(rental.person).to eq(person)
#       expect(rental.date).to eq(date)
#     end
#     it 'associates the rental with the book' do
#       expect(book.rentals).to include(rental)
#     end
#     it 'associates the rental with the person' do
#       expect(person.rentals).to include(rental)
#     end
#   end
# end
