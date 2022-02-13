require 'rails_helper'

describe 'User' do
  let(:user) { FactoryBot.build(:user) }

  subject { user }

  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:email) }

  it { should have_many(:courses) }
  it { should have_many(:enrollments) }
end
