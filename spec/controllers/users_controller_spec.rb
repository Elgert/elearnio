require 'rails_helper'

describe UsersController do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }

  describe 'GET index' do
    context 'success' do
      before do
        user1
        user2
        user3
        get :index
      end

      it 'returns all users' do
        users = JSON.parse(response.body)
        expect(users.length).to be(3)
      end

      it_behaves_like 'http code', 200
    end
  end

  describe 'GET show' do
    let(:params) do
      {
        id: user1.public_id
      }
    end

    context 'not found' do
      before do
        params[:id] = 'giberish'
        get :show, params: params
      end

      it_behaves_like 'http code', 404
    end

    context 'success' do
      before do
        get :show, params: params
      end

      it 'returns user' do
        user = JSON.parse(response.body)

        attributes = %w[
          first_name
          last_name
          full_name
          email
        ]

        expect(user.keys).to match_array(attributes)
      end

      it_behaves_like 'http code', 200
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        user: {
          first_name: 'elgert',
          last_name: 'hajdini',
          email: 'ELGERT.hajdini@gmail.com'
        }
      }
    end

    context 'success' do
      before do
        post :create, params: params
      end

      it 'creates user' do
        user = User.find_by(email: params[:user][:email].downcase)
        expect(user.first_name).to eq(params[:user][:first_name])
        expect(user.last_name).to eq(params[:user][:last_name])
        expect(user.email).to eq(params[:user][:email].downcase)
      end

      it_behaves_like 'http code', 201
    end

    context 'failure because of missing email' do
      before do
        params[:user][:email] = nil
        post :create, params: params
      end

      it 'fails to create a user record' do
        expect(User.all.count).to eq(0)
      end

      it_behaves_like 'http code', 422 # unprocessable_entity
    end
  end

  describe 'PUT update' do
    let(:params) do
      {
        id: user1.public_id,
        user: {
          "first_name": "another",
          "last_name": "other"
        }
      }
    end

    context 'not found' do
      before do
        user1
        params[:id] = 'giberish'
        put :update, params: params
      end

      it_behaves_like 'http code', 404
    end

    context 'success' do
      before do
        put :update, params: params
        user1.reload
      end

      it 'updates user name and surname' do
        aggregate_failures do
          expect(user1.first_name).to eq('another')
          expect(user1.last_name).to eq('other')
        end
      end

      it_behaves_like 'http code', 200
    end
  end

  describe 'DELETE destroy' do
    let(:params) do
      {
        id: user1.public_id
      }
    end

    context 'not found' do
      before do
        user1
        params[:id] = 'giberish'
        delete :destroy, params: params
      end

      it_behaves_like 'http code', 404
    end

    context 'success' do
      before do
        delete :destroy, params: params
      end

      it 'deletes the user' do
        expect(User.exists?(user1.id)).to be false
      end

      it_behaves_like 'http code', 200
    end
  end

  describe 'user enrollments' do
    let(:params) do
      {
        id: user1.public_id
      }
    end
    let(:enrollments) do
      10.times do
        FactoryBot.create(:enrollment, user: user1)
      end
    end

    context 'not found' do
      before do
        params[:id] = 'giberish'
        get :user_enrollments, params: params
      end

      it_behaves_like 'http code', 404
    end

    context 'success' do
      before do
        enrollments
        get :user_enrollments, params: params
      end

      it 'returns enrollments' do
        user_enrollments = JSON.parse(response.body)
        expect(user_enrollments.count).to eq(10)
      end

      it_behaves_like 'http code', 200
    end
  end

  describe 'authored courses' do
    let(:params) do
      {
        id: user1.public_id
      }
    end
    let(:courses) do
      5.times do
        FactoryBot.create(:course, user: user1)
      end
    end

    context 'not found' do
      before do
        params[:id] = 'giberish'
        get :authored_courses, params: params
      end

      it_behaves_like 'http code', 404
    end

    context 'success' do
      before do
        courses
        get :authored_courses, params: params
      end

      it 'returns courses created by user' do
        authored_courses = JSON.parse(response.body)
        expect(authored_courses.count).to eq(5)
      end

      it_behaves_like 'http code', 200
    end
  end
end
