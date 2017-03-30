# API

An API for Charlotte Junior Devs.

## Data Attributes
```ruby
user = {:id=>1, :first_name=>"bob", :last_name=>"jones", :email=>"foo@bar.com", :info=>{:github_handle=>"username", :skills=>[]}}
points = {:id=>1, :value=>1234, :user_id=>1, :created_at=>"2017-04-01 09:42:21"}
event = {:type=>"pull-request", :action=>"created", actor_id: 1, :info=>{ :sender=>"github-webhook" }}
```

## REST interface

### Users
```
GET /users
POST /users
GET /:username
PUT /:username
```

### Points

```
GET /:username/:points
POST /:username/:points

```
> Not having an update/delete action will create a points timeline

```
GET /:username/:points/:category
POST /:username/:points/:category

```

### Events

```
GET /:username/events
GET /:username/events
POST /:username/events

```

### Recommendations
(elasticsearch driven)

```
GET /recommendations
GET /recommendations/:category

```


## Handling Events
```ruby
# (pseudo-code)
# ...

# Events Controller
def create
  result = EventHandler.call(params: params)

  if result.success?
    render json: result.event, status: :created
  else
    render json: result.errors, status: :unprocessable_entity
  end
end

class EventHandler
  def self.call(context = {})
    event = context.event # => { id: 1, type: "pull-request", action: "created", actor_id: 1 }
    category = "#{event[:action]}-#{event[:type]}".pluralize # => "created-pull-requests"

    RecordEvent.call(event: event, category: category)
    AwardCategoryPoints.call(category: category, user_id: event.actor_id) # Add a new points record to user
  end
end
```
