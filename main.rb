require_relative 'app'

class LibraryApp
  def initialize
    @app = App.new
  end

  def run
    puts "Welcome to School library App!\n\n"

    loop do
      display_options
      print 'Your option: '
      option = user_option

      case option
      when 1
        @app.list_books
      when 2
        @app.list_people
      when 3
        @app.create_person
      when 4
        @app.create_book
      when 5
        @app.create_rental
      when 6
        print 'Enter person ID: '
        person_id = gets.chomp.to_i
        @app.list_rentals(person_id)
      when 7
        exit_app
      else
        puts 'Invalid option, please type a correct number!'
      end
    end
  end

  private

  def display_options
    puts <<~OPTIONS
      Please choose an option by entering a number:
      1 - List of all books
      2 - List of all people
      3 - Add a person
      4 - Create a book
      5 - Add a rental
      6 - List of all rental for given id
      7 - Exit
    OPTIONS
  end

  def user_option
    user_choice = gets.chomp.to_i
    user_choice.between?(1, 7) ? user_choice : 'Invalid'
  end

  def exit_app
    puts 'Thank you for using this app!'
    exit
  end
end

LibraryApp.new.run
