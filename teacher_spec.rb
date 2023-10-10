require_relative 'teacher'
require 'rspec'

describe Teacher do
  let(:teacher) { Teacher.new('Math', 30, 'Test Teacher') }

  describe '#initialize' do
    it 'creates a new teacher with specialization, age, name, and parent_permission' do
      expect(teacher.specialization).to eq('Math')
      expect(teacher.age).to eq(30)
      expect(teacher.name).to eq('Test Teacher')
      expect(teacher.instance_variable_get(:@parent_permission)).to be_truthy
    end
  end

  describe '#can_use_services?' do
    it 'returns true, as teachers can use services' do
      expect(teacher.can_use_services?).to be_truthy
    end
  end
end
