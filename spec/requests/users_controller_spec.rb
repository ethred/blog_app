# spec/requests/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('There are no users currently in the system.')
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Example User', photo: 'example.jpg', bio: 'Example Bio', posts_counter: 0) }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('Number of posts: 0')
      expect(response.body).to include('Example Bio')
      expect(response.body).to include('There are currently no posts for this user in the system.')
    end
  end
end
