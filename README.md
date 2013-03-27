# life_signs

[![Build Status](https://travis-ci.org/calebthompson/life\_signs.png?branch=master)](https://travis-ci.org/calebthompson/life\_signs)
[![Code Climate](https://codeclimate.com/github/calebthompson/life\_signs.png)](https://codeclimate.com/github/calebthompson/life\_signs)

Create activity streams in your application which can be easily filtered by
who or what created the activity or by the type of content.

                                                           BUZZ
                                                     (into communicator)
                                              No read-out yet if the air is
                                              breathable... and there seems to be
                                              no sign of intelligent life
                                              anywhere --

## Installation

Add life\_signs to your application&rsquo;s Gemfile and run `bundle install`.

```ruby
gem 'life_signs'
```

Make sure the development database exists. Then, run the generator:

```
rails g life_signs:install
```

The generator creates an Activity model which includes `LifeSigns::Activity` and
has polymorphic relations to `content` and `actor`.

## Usage

The `Activity` model is a glorified scope, so there should never be any need for
`content` to know about `Activity`. For this reason, we push the logic for
creating activities into the controller, with its cousins email generation and
notification creation.

In your controller, create activities along with your content.

```ruby
class TweetsController < ActionController::Base
  respond_to :html

  def create
    @tweet = create_tweet
    respond_with @tweet
  end

  private

  def create_tweet
    tweet = Tweet.new(tweet_params)
    create_activity(tweet)
    tweet
  end

  def tweet_params
    params.
      require(:tweet).
      permit(:body).
      merge(user: current_user)
  end

  def create_activity(tweet)
    Activity.create(actor: current_user, content: tweet)
  end
end
```

Sometimes, the `actor` won&rsquo;t be a user, but some other
&ldquo;subscribable&rdquo; model such as a Forum:

```ruby
class PostsController < ActionController::Base
  respond_to :html

  def create
    @post = create_post
    respond_with @post
  end

  private

  def create_post
    post = Post.new(post_params)
    create_activity(post)
    post
  end

  def post_params
    params.
      require(:post).
      permit(:body).
      merge(forum: forum, user: current_user)
  end

  def create_activity(post)
    Activity.create(actor: current_user, content: tweet)
  end

  def forum
    Forum.find(params[:forum_id])
  end
end
```

Then scope the Activities by what actors you want:

```ruby
def show
  @activities = Activity.actors(forum: subscribed_forums, user: friends)
end

def subscribed_forums
  current_user.subscribed_forum_ids
end

def friends
  current_user.friend_ids
end
```

And render the activities in your application:

`app/views/activities/_activity`
```haml
= content_tag_for(:li, activity) do
  = render activity.content
```

`app/views/activities/index`
```haml
= render @activities
```
