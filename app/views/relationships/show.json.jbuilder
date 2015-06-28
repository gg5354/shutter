json.(@relationship, :id, :user_1, :user_2)
json.status Relationship::STATUS.invert[@relationship.status]
