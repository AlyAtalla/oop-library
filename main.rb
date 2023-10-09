# main.rb
require_relative 'app'

class LibraryApp
  def initialize
    @app = App.new
    @menu_options = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals,
      7 => :exit_app
    }
  end

  def run
    display_welcome_message

    loop do
      display_options
      option = user_option
      process_option(option)
    end
  end

  private

  def display_welcome_message
    puts "Welcome to School library App!\n\n"
  end

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

  def process_option(option)
    action = @menu_options[option]
    if action
      @app.send(action)
    else
      puts 'Invalid option, please type a correct number!'
    end
  end

  def exit_app
    puts 'Thank you for using this app!'
    exit
  end
end

LibraryApp.new.run
