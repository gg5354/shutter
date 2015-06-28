users = [
  {
    first_name: 'Matt',
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
    first_name: 'Wesley',
    last_name: 'Pipes',
    email: 'wp@gmail.com',
    password: 'password'
  },
  {
    first_name: 'Not',
    last_name: 'Relationship',
    email: 'nf@yahoo.com',
    password: 'passw0rd123'
  },
  {
    first_name: 'Test',
    last_name: 'User',
    email: 'tuser@aol.com',
    password: 'password'
  }
]

users = users.map do |user|
  User.create! user
end

friends = [
  { user_1: users.last.id, user_2: users[1].id, status: Relationship::STATUS[:accepted] },
  { user_1: users[0].id, user_2: users.last.id, status: Relationship::STATUS[:accepted] },
  { user_1: users.last.id, user_2: users[2].id },
  { user_1: users[3].id, user_2: users.last.id }
]

friends.each do |friend|
  Relationship.create! friend
end

%w(Hong\ Kong Australia UK).each do |name|
  Album.create! name: name, user_id: users.last.id
end
