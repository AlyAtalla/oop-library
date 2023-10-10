require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

class App
  def initialize
    @books = []
    @students = []
    @teachers = []
    @people = []
    @rentals = []

    load_data # Load data when the app starts
  end

  def list_books
    if @books.empty?
      puts 'No books found.'
    else
      @books.each_with_index do |book, index|
        puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
      end
    end
  end

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

  def list_student
    if @students.empty?
      puts 'No students found.'
    else
      @students.each_with_index do |student, index|
        puts "#{index}) [#{student.class}] ID: #{student.id}, Name: #{student.name},
         Age: #{student.age}, Classroom: #{student.classroom}"
      end
    end
  end

  def list_teacher
    if @teachers.empty?
      puts 'No teachers found.'
    else
      @teachers.each_with_index do |teacher, index|
        puts "#{index}) [#{teacher.class}] ID: #{teacher.id}, Name: #{teacher.name},
         Age: #{teacher.age}, Specialization: #{teacher.specialization}"
      end
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

  def create_student
    print 'Classroom: '
    student_classroom = gets.chomp
    print 'Age: '
    student_age = gets.chomp.to_i
    print 'Name: '
    student_name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp
    student = Student.new(student_classroom, student_age, student_name, parent_permission: parent_permission)
    @students << student
    @people << student
    puts 'Student created successfully'
  end

  def create_teacher
    print 'Age: '
    teacher_age = gets.chomp.to_i
    print 'Name: '
    teacher_name = gets.chomp
    print 'Specialization: '
    teacher_specialization = gets.chomp
    teacher = Teacher.new(teacher_specialization, teacher_age, teacher_name)
    @teachers << teacher
    @people << teacher
    puts 'Teacher created successfully'
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

  def display_people(people)
    if people.empty?
      puts 'No people found.'
    else
      people.each_with_index do |person, index|
        puts "#{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      end
    end
  end

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
  def save_data
    save_to_json('books.json', @books)
    save_to_json('students.json', @students)
    save_to_json('teachers.json', @teachers)
    save_to_json('people.json', @people)
    save_to_json('rentals.json', @rentals)
  end
  def save_to_json(filename, data)
    File.open(filename, 'w') do |file|
      file.puts JSON.generate(data)
    end
  end
  def load_data
    load_from_json('books.json', @books)
    load_from_json('students.json', @students)
    load_from_json('teachers.json', @teachers)
    load_from_json('people.json', @people)
    load_from_json('rentals.json', @rentals)
  end
  def load_from_json(filename, target_array)
    return unless File.exist?(filename)
    File.open(filename, 'r') do |file|
      data = JSON.parse(file.read)
      target_array.replace(data)
    end
  end
  def exit_app
    save_data # Save data when the app exits
    puts 'Thank you for using this app!'
    exit
  end
end