require 'rails_helper'

RSpec.describe 'Post index ' do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer')
    @post1 = Post.create(author_id: @user.id, title: 'Rails Journey', text: 'Exploring the world.',
                         likes_counter: 2, comments_counter: 1)
    @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'Another day, another hello.',
                         likes_counter: 0, comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         likes_counter: 1, comments_counter: 2)
    @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    visit user_posts_path(@user.id)
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
  end

  it 'can see the user name' do
    expect(page).to have_content('John Doe')
  end
  it 'can see the number of comments on a post' do
    expect(page).to have_content('Comment: 2')
  end

  it 'can see the number of posts user has written' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'can see a post title' do
    expect(page).to have_content('Rails Journey')
  end

  it 'can see some of post body' do
    expect(page).to have_content('Exploring the world.')
  end

  it 'can see first comment on post ' do
    expect(page).to have_content('Great post!')
  end

  it 'can see how many likes a post has' do
    expect(page).to have_content('Likes: 2')
  end

  it 'can see pagination if there are more posts than fit on the view' do
    expect(page).to have_selector('nav.pagination')
  end

  it "When I click on a post, it redirects me to that post's show page." do
    click_on 'Rails Journey'
    expect(page).to have_content('Exploring the world.')
  end
end
