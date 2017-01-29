json.array! @tickets do |t|
  json.extract! t, :id, :title, :closed_at, :created_at, :updated_at, :author_id
  json.author_username t.author.username
end
