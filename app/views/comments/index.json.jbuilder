json.array!(@comments) do |comment|
  json.extract! comment, :id, :upvotes, :downvotes, :parent_id, :parent_type, :user_id, :content
  json.url comment_url(comment, format: :json)
end
