#spec/models/enrollment_spec.rb
require 'rails_helper'

RSpec.describe Enrollment, type: :model do

  describe '#is_past_application_deadline' do
    let(:coding_class) { CodingClass.create(title: 'Test Class') }
    let(:trimester) { Trimester.create(year: '2025', term: 'Winter', start_date: '2025-01-01', end_date: '2025-04-30', application_deadline: '2024-12-15') }
    let(:course) { Course.create(coding_class: coding_class, trimester: trimester) }
    let(:student) { Student.create(first_name: 'Test', last_name: 'Test') }
    let(:enrollment) { Enrollment.create(course: course, student_id: student) }
    context 'when created after the application deadline' do
      before do
        enrollment.created_at = Time.parse('2025-01-02')
      end

      it 'returns true' do
        expect(enrollment.is_past_application_deadline).to be true
      end
    end

    context 'when created before the application deadline' do
      before do
        enrollment.created_at = Time.parse('2024-12-14')
      end

      it 'returns false' do
        expect(enrollment.is_past_application_deadline).to be false
      end
    end

    context 'when there is no application deadline' do
      before do
        course.trimester.application_deadline = nil
        enrollment.created_at = Time.now
      end

      it 'returns false' do
        expect(enrollment.is_past_application_deadline).to be false
      end
    end
  end
end