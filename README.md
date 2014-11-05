A site to reproduce the functionality of reddit.com.

It's so I can really dig deep into rails. I want to make this site using TDD,
so I will write tests for all functionality before I write any code.

Completely unaffiliated with this project: https://github.com/schneems/reddit_on_rails

A note on errors:
If a particular view should be responsible for displaying an error, it will be saved in
`flash[:layout-name:]` and I've written a helper function in `application_helper.rb` to
intelligently display errors.
