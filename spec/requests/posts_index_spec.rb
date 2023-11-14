# requests/posts_index_spec.rb

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns correct response status and template for /users/:user_id/posts' do
      user = User.create(name: 'Name', posts_counter: 0)
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('<div class="card mb-3">')
      expect(response.body).to include('<h5 class="card-title">Name</h5>')
    end

    it 'displays message when there are no posts' do
      user = User.create(name: 'Name', posts_counter: 0)
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('<p style="color:blue">There are currently no posts for this user in the system.</p>')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns correct response status and template for /users/:user_id/posts/:id' do
      user = User.create(name: 'Name', posts_counter: 0)
      post = Post.create(title: 'Post Title', author_id: user.id, comments_counter: 0, likes_counter: 0)
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('<div class="post-container w-[60%] mx-auto bg-white rounded-md shadow-md p-6 my-8">')
      expect(response.body).to include('<h1 class="font-semibold text-2xl mb-2">Post Title By <span>Name</span></h1>')
    end
  end
end
