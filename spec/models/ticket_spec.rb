require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { should belong_to(:assigned_user).class_name('User') }
  end

  describe 'validations' do
    describe 'enums' do
      it { should define_enum_for(:status_id).with_values(backlog: 0, selected_to_do: 1, in_progress: 2, done: 3) }
      it { should validate_presence_of(:status_id) }
    end

    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:progress).allow_nil.only_integer.is_greater_than_or_equal_to(0).
      is_less_than_or_equal_to(100) 
    }
  end
end