# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :each do
    @user = User.create(name: 'sami dan', photo: 'https://example.com/john-doe.jpg', bio: 'Developer')
    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'This is the content of my first post.')
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development.')
    @post3 = Post.create(author_id: @user.id, title: 'Learning Ruby', text: 'Exploring the beauty of Ruby language.')
    visit user_path(@user.id)
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
  end

  it 'see the user profile name' do
    expect(page).to have_content 'sami dan'
  end

  it 'see the number of posts user has written' do
    expect(page).to have_content 'Number of posts: 3'
  end

  it 'see the user bio' do
    expect(page).to have_content 'Developer'
  end

  it 'see the user first three posts' do
    expect(page).to have_content('This is the content of my first post.')
    expect(page).to have_content('Excited about Rails development.')
    expect(page).to have_content('Exploring the beauty of Ruby language.')
  end

  it 'see the button that lets me view all users posts' do
    expect(page).to have_link('See all Posts', href: user_posts_path(user_id: @user.id))
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'My First Post'
    expect(page).to have_content 'This is the content of my first post.'
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    click_on 'See all Posts'
    expect(page).to have_content('My First Post')
    expect(page).to have_content('Rails Rocks')
    expect(page).to have_content('Learning Ruby')
  end
end
