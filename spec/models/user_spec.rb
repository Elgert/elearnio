require 'rails_helper'

describe 'User' do
  let(:user) { FactoryBot.create(:user) }

  subject { user }

  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:email) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }

  it { should have_many(:courses) }
  it { should have_many(:enrollments) }

  it 'transfers the users courses to another author on delete' do
    user = FactoryBot.create(:user)
    another_user = FactoryBot.create(:user)
    course1 = FactoryBot.create(:course, author_id: user.id)
    course2 = FactoryBot.create(:course, author_id: user.id)

    user.destroy
    course1.reload
    course2.reload

    aggregate_failures do
      expect(course1.author_id).to_not be(user.id)
      expect(course1.author_id).to be(another_user.id)
      expect(course2.author_id).to_not be(user.id)
      expect(course2.author_id).to be(another_user.id)
    end
  end
end
