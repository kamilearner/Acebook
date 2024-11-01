require_relative '../rails_helper.rb'

RSpec.describe 'Root Route', type: :routing do
  
  # GET '/'
  it 'leads to a correct controller and action' do
    assert_routing({ path: '/', method: :GET }, { controller: 'sessions', action: 'home' })
  end

  # POST '/'
  it 'does not exist' do
    expect(post: root_path).not_to be_routable
  end
end



RSpec.describe 'Login & Logout Route', type: :routing do
  
  # GET /login
  it 'leads to correct controller and action' do
    assert_routing({ path: '/login', method: :GET }, { controller: 'sessions', action: 'login' })
  end

  # POST /login
  it 'handles logging in of user' do
    assert_routing({ path: 'login', method: :POST }, { controller: 'sessions', action: 'create' })
  end

  # GET /logout
  it 'logs user out' do
    assert_routing({ path: '/logout', method: :GET }, { controller: 'sessions', action: 'destroy' })
  end
end



RSpec.describe 'Register Route', type: :routing do
  
  # GET /register
  it 'leads to correct controller and action' do
    assert_routing({ path: '/register', method: :GET }, { controller: 'users', action: 'register' })
  end

  # POST /register
  it 'handles registering of a new user' do
    assert_routing({ path: '/users', method: :POST }, { controller: 'users', action: 'create' })
  end
end



RSpec.describe 'User Homepage Route', type: :routing do
  
  # GET /users/:id
  it 'displays all posts of a logged in user' do
    #expect(get: '/users/1').to route_to(controller: 'users', action: 'show', id: '1')
    assert_routing({ path: '/users/1', method: :GET }, { controller: 'users', action: 'show', id: '1' })
  end
end



RSpec.describe 'User Friends Route', type: :routing do
  
  # GET /friends
  it 'displays all friends of a logged in user' do
    #expect(get: friends_path).to route_to(controller: 'users', action: 'index')
    assert_routing({ path: '/users', method: :get }, { controller: 'users', action: 'index' })
  end
end



RSpec.describe 'Delete Posts Route', type: :routing do

  # DELETE /posts/:id
  it 'deletes a post of a logged in user' do
    #expect(delete: '/posts/1').to route_to(controller: 'posts', action: 'destroy', id: '1')
    assert_routing({ path: '/posts/1', method: :delete }, { controller: 'posts', action: 'destroy', id: '1' })
  end
end