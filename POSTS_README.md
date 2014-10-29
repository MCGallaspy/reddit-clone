Here's the plan for post types:

There are two types of posts, self posts and link posts. They have certain attributes in common:
* upvotes
* downvotes
* children (top level comments)
* title
* user (who it was posted by)
* subreddit (when implemented)

But they have a key difference: a link post content is a link, and a self post content is text.
They should be rendered differently and in general handled differently (i.e. with karma).

One way to handle it is to create two columns and a flag:
* self_text
* link
* is_self_post

self_text and link columns will be mutually exclusive conditioned on the is_self_post flag... 
at least one of them must be nil.

A note about comments and comment trees: Each comment can have many children comments, and
also has a parent comment or post.

* upvotes
* downvotes
* content
* parent (comment or post)
* children (comments)
* user
