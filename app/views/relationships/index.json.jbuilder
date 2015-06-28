json.array! @relationships do |r|
  json.(r, :id, :user_1, :user_2)
  json.status Relationship::STATUS.invert[r.status]
end
