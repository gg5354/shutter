attrs = @status == 'accepted' ? %i(id first_name last_name email) : %i(id email)
json.array! @friends, *attrs
