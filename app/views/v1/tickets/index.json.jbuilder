json.array! @tickets do |t|
  json.extract! t, :id, :title, :closed_at, :created_at,
    :updated_at, :author_id, :author_username, :author_is_waiting
end
