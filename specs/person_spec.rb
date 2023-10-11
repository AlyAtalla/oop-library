require_relative 'person'
require 'rspec'

describe Person do
  let(:person) { Person.new(18, 'Test Person') }

  describe '#initialize' do
    it 'creates a new person with age, name, and parent_permission' do
      expect(person.name).to eq('Test Person')
      expect(person.age).to eq(18)
      expect(person.instance_variable_get(:@parent_permission)).to be_truthy
    end

    it 'initializes an empty rentals array' do
      expect(person.rentals).to be_empty
    end

    it 'generates a random id' do
      expect(person.instance_variable_get(:@id)).to be_a(Integer)
    end
  end

  describe '#add_rental' do
    it 'creates a new Rental instance and adds it to rentals array' do
      book = double('Book')
      date = '2023-10-09'
      rental = person.add_rental(book, date)

      expect(rental).to be_a(Rental)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(rental.date).to eq(date)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#can_use_services?' do
    context 'when person is of age' do
      it 'returns true' do
        person.age = 20
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is not of age but has parent permission' do
      it 'returns true' do
        person.age = 15
        person.instance_variable_set(:@parent_permission, true)
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is not of age and does not have parent permission' do
      it 'returns false' do
        person.age = 15
        person.instance_variable_set(:@parent_permission, false)
        expect(person.can_use_services?).to be_falsey
      end
    end
  end
end
