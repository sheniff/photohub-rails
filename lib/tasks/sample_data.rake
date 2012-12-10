namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_albums
    make_pictures
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Example User",
                        email: "example@railstutorial.org",
                        password: "foobar",
                        password_confirmation: "foobar")
  admin.toggle!(:admin)

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password)
  end
end

def make_albums
  users = User.all(limit: 6)
  2.times do |n|
    title = Faker::Lorem.sentence(5)
    description = Faker::Lorem.sentence(15)
    users.each { |user| user.albums.create!(title: title, description: description) }
  end
end

def make_pictures
  include ActionDispatch::TestProcess
  albums = Album.all
  10.times do |n|
    name = Faker::Lorem.sentence(5)
    albums.each do |album|
      album.pictures.create!(
        name: name,
        user_id: album.user.id,
        image: fixture_file_upload("#{::Rails.root}/spec/fixtures/images/test.jpg", 'image/jpeg')
      )
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users [2..50]
  followers      = users [3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
