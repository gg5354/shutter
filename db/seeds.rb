users = [
  {
    first_name: 'Mark',
    last_name: 'Daemon',
    email: 'mdaemon@aol.com',
    password: 'password123'
  },
  {
    first_name: 'Okra',
    last_name: 'Winfrey',
    email: 'owinfrey@me.com',
    password: 'pa55word123'
  },
  {
    first_name: 'Not',
    last_name: 'Friend',
    email: 'nf@yahoo.com',
    password: 'passw0rd123'
  }
]

users = users.map do |user|
  User.create! user
end

Friend.create! user_1: users[0].id, user_2: users[1].id
%w(Hong\ Kong Australia UK).each do |name|
  Album.create! name: name, user_id: users[0].id
end
