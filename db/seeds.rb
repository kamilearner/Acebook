# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Comment.destroy_all
Post.destroy_all
User.destroy_all

users = User.create!([
  { username: "Kamilya", password: "test123" },
  { username: "Khari", password: "test123" },
  { username: "Chiara", password: "test123"},
  { username: "Mauro", password: "test123"}
])

posts = Post.create!([
  { user_id: users[0].id , message: "what a nice day"},
  { user_id: users[0].id , message: "I am going on holiday"},
  { user_id: users[1].id , message: "Coming back from holiday"},
  { user_id: users[1].id , message: "Can't wait to go on holiday"},
  { user_id: users[2].id , message: "going back to work"},
  { user_id: users[2].id , message: "I need a nap"},
  { user_id: users[3].id , message: "Let's go to the beach"},
  { user_id: users[3].id , message: "Working from home"},
  { user_id: users[3].id , message: "new post"}
])



# ATTACH IMAGES TO POSTS USING ACTIVE STORAGE 
posts[0].image.attach(io: File.open(Rails.root.join('db/images/post0.jpg')), filename: 'post0.jpg')
posts[1].image.attach(io: File.open(Rails.root.join('db/images/post1.jpg')), filename: 'post1.jpg')
posts[2].image.attach(io: File.open(Rails.root.join('db/images/post2.jpg')), filename: 'post2.jpg')
posts[3].image.attach(io: File.open(Rails.root.join('db/images/post3.jpg')), filename: 'post3.jpg')
posts[4].image.attach(io: File.open(Rails.root.join('db/images/post4.jpg')), filename: 'post4.jpg')
posts[5].image.attach(io: File.open(Rails.root.join('db/images/post5.jpg')), filename: 'post5.jpg')
posts[6].image.attach(io: File.open(Rails.root.join('db/images/post6.jpg')), filename: 'post6.jpg')
posts[7].image.attach(io: File.open(Rails.root.join('db/images/post7.jpg')), filename: 'post7.jpg')
posts[8].image.attach(io: File.open(Rails.root.join('db/images/post8.jpg')), filename: 'post8.jpg')

Comment.create!([
  { post_id: posts[0].id, user_id: users[0].id, message_comment: "Where are you?" },
  { post_id: posts[0].id, user_id: users[0].id, message_comment: "How are you doing?" },
  { post_id: posts[1].id, user_id: users[1].id, message_comment: "Nice!" },
  { post_id: posts[1].id, user_id: users[1].id, message_comment: "Whish i was there" },
  { post_id: posts[2].id, user_id: users[2].id, message_comment: "well done" },
  { post_id: posts[2].id, user_id: users[2].id, message_comment: "Hi!" },
  { post_id: posts[3].id, user_id: users[3].id, message_comment: "Hello" },
  { post_id: posts[3].id, user_id: users[3].id, message_comment: "Thanks" },
  { post_id: posts[4].id, user_id: users[3].id, message_comment: "Ok" },
  { post_id: posts[4].id, user_id: users[0].id, message_comment: "Wow" },
  { post_id: posts[5].id, user_id: users[1].id, message_comment: "Awesome" },
  { post_id: posts[5].id, user_id: users[0].id, message_comment: "Very nice" },
  { post_id: posts[6].id, user_id: users[0].id, message_comment: "okay" },
  { post_id: posts[6].id, user_id: users[1].id, message_comment: "Coming" },
  { post_id: posts[7].id, user_id: users[2].id, message_comment: "Very nice" },
  { post_id: posts[7].id, user_id: users[3].id, message_comment: "cool" },
])

p "Created #{User.count} Users, #{Post.count} Post and #{Comment.count} comments"