require_relative 'student'
require 'rspec'

describe Student do
  let(:classroom) { double('Classroom', students: []) }
  let(:student) { Student.new(classroom, 'Test Student', 18) }

  describe '#initialize' do
    it 'creates a new student with classroom, name, age, and parent_permission' do
      expect(student.classroom).to eq(classroom)
      expect(student.name).to eq('Test Student')
      expect(student.age).to eq(18)
      expect(student.instance_variable_get(:@parent_permission)).to be_truthy
    end

    it 'adds the student to the classroom' do
      expect(classroom.students).to include(student)
    end
  end

  describe '#play_hoocky' do
    it 'returns a shrug emoticon' do
      expect(student.play_hoocky).to eq('¯(ツ)/¯')
    end
  end
end
