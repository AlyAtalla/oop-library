require_relative 'app'
require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require 'rspec'

describe App do
  let(:app) { App.new }
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
  let(:student) { Student.new('Class A', 20, 'John Doe', parent_permission: true) }
  let(:teacher) { Teacher.new('Math', 30, 'Alice Johnson') }

  before do
    app.books = [book]
    app.people = [student, teacher]
  end

  describe '#all_books' do
    it 'lists all books' do
      expect { app.all_books }.to output(/Title: "The Great Gatsby", Author: F. Scott Fitzgerald/).to_stdout
    end
  end

  describe '#all_people' do
    it 'lists all people' do
      expect { app.all_people }.to output(/\[Student\] Name: John Doe, ID: \d+, Age: 20/).to_stdout
      expect { app.all_people }.to output(/\[Teacher\] Name: Alice Johnson, ID: \d+, Age: 30/).to_stdout
    end
  end

  describe '#create_person' do
    context 'when creating a student' do
      before do
        allow(app).to receive(:gets).and_return('1', '21', 'Jane', 'Y')
      end

      it 'creates a student' do
        expect { app.create_person }.to change { app.people.length }.by(1)
      end
    end

    context 'when creating a teacher' do
      before do
        allow(app).to receive(:gets).and_return('2', 'Math', 'Alice')
      end

      it 'creates a teacher' do
        expect { app.create_person }.to change { app.people.length }.by(1)
      end
    end

    context 'when choosing an invalid option' do
      before do
        allow(app).to receive(:gets).and_return('3')
      end

      it 'outputs an error message' do
        expect { app.create_person }.to output(/Sorry, you choose the wrong option/).to_stdout
      end
    end
  end

  describe '#create_book' do
    before do
      allow(app).to receive(:gets).and_return('Lord of the Rings', 'J.R.R. Tolkien')
    end

    it 'creates a book' do
      expect { app.create_book }.to change { app.books.length }.by(1)
    end
  end

  describe '#create_rental' do
    context 'when creating a rental' do
      before do
        allow(app).to receive(:gets).and_return('0', '0', '2023-10-09')
      end

      it 'creates a rental' do
        expect { app.create_rental }.to change { app.rentals.length }.by(1)
      end
    end
  end
end
