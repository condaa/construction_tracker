require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:tickets).with_foreign_key(:assigned_user_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }

    context 'the mail validations' do
      it { should validate_presence_of(:mail) }
      it { should validate_uniqueness_of(:mail) }
      it { should allow_value('good@example.com').for(:mail) }
      it { should_not allow_value('bad@.com').for(:mail) }
    end

    context 'when send_due_date_reminder is true' do
      before { allow(subject).to receive(:send_due_date_reminder).and_return(true) }
      it { should validate_presence_of(:due_date_reminder_time) }
      it { should validate_numericality_of(:due_date_reminder_interval).only_integer.is_greater_than_or_equal_to(0) }
    end

    context 'when send_due_date_reminder is false' do
      before { allow(subject).to receive(:send_due_date_reminder).and_return(false) }
      it { should_not validate_presence_of(:due_date_reminder_time) }
      it { should_not validate_presence_of(:due_date_reminder_interval) }
    end
  end

  describe 'scopes' do
    describe '.with_due_date_reminder' do
      let!(:user_with_due_date_reminder) { create(:user, send_due_date_reminder: true) }
      let!(:user_without_due_date_reminder) { create(:user, send_due_date_reminder: false) }

      it 'returns users with send_due_date_reminder enabled' do
        expect(User.with_due_date_reminder).to contain_exactly(user_with_due_date_reminder)
      end
    end
  end
end
