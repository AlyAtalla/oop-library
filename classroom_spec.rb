require_relative 'classroom'
require_relative 'student'
require 'rspec'

describe Classroom do
  let(:classroom) { Classroom.new('Math Class') }
  let(:student) { Student.new(classroom, 'Test Student') }

  describe '#initialize' do
    it 'creates a new classroom with a label' do
      expect(classroom.label).to eq('Math Class')
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      classroom.add_student(student)
      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
