json.array!(@posts) do |post|
  json.extract! post, :id, :upvotes, :downvotes, :title, :user_id, :self_text, :link, :is_self_post
  json.url post_url(post, format: :json)
end
