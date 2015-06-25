namespace :db do
  namespace :seed do
    desc "Seed test db"
    task test: :environment do
      users = [
        {first_name: 'test1', last_name: 'user1', email: 'testing123@aol.com', password: 'password'},
        {first_name: 'user', last_name: 'exists', email: 'existinguser@aol.com', password: 'password'}
      ]

      users.each do |user|
        User.create! user
      end
    end
  end
end
