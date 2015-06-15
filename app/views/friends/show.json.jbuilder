friends = [@user1, @user2]

json.array! friends do |friend|
  json.(friend, :user_1, :user_2)
  json.status Friend::STATUS.invert[friend.status]
end
