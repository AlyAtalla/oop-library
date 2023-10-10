require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

# Module for managing books
module BookManagement
  def list_books
    if @books.empty?
      puts 'No books found.'
    else
      @books.each_with_index do |book, index|
        puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
      end
    end
  end

  def create_book
    print 'Title: '
    book_title = gets.chomp
    print 'Author: '
    book_author = gets.chomp
    book = Book.new(book_title, book_author)
    @books << book
    puts 'Book created successfully'
  end

  def save_books
    save_to_json('books.json', @books)
  end

  def load_books
    load_from_json('books.json', @books)
  end
end

# Module for managing people (students and teachers)
module PeopleManagement
  def list_people
    print 'Do you want to create a list of students (1) or teachers (2)? [Input the number]: '
    list_person = gets.chomp.to_i
    case list_person
    when 1
      list_student
    when 2
      list_teacher
    else
      puts "\nInvalid input!!\n\n"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    select_person = gets.chomp.to_i
    case select_person
    when 1
      create_student
    when 2
      create_teacher
    else
      puts "\nInvalid input\n\n"
      create_person
    end
  end

  def display_people(people)
    if people.empty?
      puts 'No people found.'
    else
      people.each_with_index do |person, index|
        puts "#{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      end
    end
  end

  def save_people
    save_to_json('people.json', @people)
  end

  def load_people
    load_from_json('people.json', @people)
  end
end

# Module for managing rentals
module RentalManagement
  def create_rental
    if @books.empty? || (@teachers.empty? && @students.empty?)
      puts 'Lists are empty'
    else
      puts 'Select a book from the following list by number'
      list_books
      book_number = gets.chomp.to_i
      book_name = @books[book_number]
      puts 'Select a person from the following list by number (not id)'
      display_people(@people)
      person_number = gets.chomp.to_i
      person_name = @people[person_number]
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(book_name, person_name, date)
      @rentals << rental
      puts 'Rental created successfully'
    end
  end

  def list_rentals(person_id)
    if @rentals.empty?
      puts 'No rentals found.'
    else
      @rentals.each do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
        end
      end
    end
  end

  def save_rentals
    save_to_json('rentals.json', @rentals)
  end

  def load_rentals
    load_from_json('rentals.json', @rentals)
  end
end

class Library
  include BookManagement
  include PeopleManagement
  include RentalManagement

  def initialize
    @books = []
    @students = []
    @teachers = []
    @people = []
    @rentals = []
    load_data
  end

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  def save_to_json(filename, data)
    File.open(filename, 'w') do |file|
      file.puts JSON.generate(data)
    end
  end

  def load_from_json(filename, target_array)
    return unless File.exist?(filename)

    File.open(filename, 'r') do |file|
      data = JSON.parse(file.read)
      target_array.replace(data)
    end
  end
end

class App
  def initialize
    @library = Library.new
    @user_interface = UserInterface.new(@library)
  end

  def run
    puts "Welcome to School library App!\n\n"

    loop do
      @user_interface.display_options
      print 'Your option: '
      option = @user_interface.user_option
      @user_interface.process_option(option)
    end
  end
end

class UserInterface
  def initialize(library)
    @library = library
  end

  def display_options
    puts 'Please choose an option by entering a number:'
    puts '1 - List of all books'
    puts '2 - List of all people'
    puts '3 - Add a person'
    puts '4 - Create a book'
    puts '5 - Add a rental'
    puts '6 - List of all rental for a given ID'
    puts '7 - Exit'
  end

  def user_option
    user_choice = gets.chomp.to_i
    user_choice.positive? && user_choice <= 7 ? user_choice : 'Invalid'
  end

  def process_option(option)
    case option
    when 1
      @library.list_books
    when 2
      @library.list_people
    when 3
      @library.create_person
    when 4
      @library.create_book
    when 5
      @library.create_rental
    when 6
      print 'ID of person: '
      person_id = gets.chomp.to_i
      @library.list_rentals(person_id)
    else
      @library.save_data # Save data when the app exits
      puts 'Thank you for using this app!'
      exit
    end
  end
end

# Main program execution
app = App.new
app.run
