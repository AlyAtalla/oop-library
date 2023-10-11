require './nameable'

RSpec.describe Nameable do
  it 'raises a NotImplementedError when #correct_name is called' do
    nameable = Nameable.new
    expect { nameable.correct_name }.to raise_error(NotImplementedError, /has not implemented method 'correct_name'/)
  end
end
