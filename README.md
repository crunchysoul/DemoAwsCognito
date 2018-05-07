# DemoAwsCognito
Amazon AWS Cognito + Elixir setup demo/starter kit

## Functions
```
# POST create a new user by username, email
DemoAwsCognito.create_user(username, email)

# POST login a user by username, password
DemoAwsCognito.login(username, password)

# POST first login a user by username, initial password send via confirmation email, new password
DemoAwsCognito.initial_login(username, email)

# GET get a user by access_token
DemoAwsCognito.get_user(access_token)

# DELETE logout a user by access_token
DemoAwsCognito.logout(access_token)

# GET get all users(can apply filters)
DemoAwsCognito.get_users()

# DELETE delete a user by username
DemoAwsCognito.delete(username)
```


## Setup
```elixir
mix deps.get        # 1. get dependencies
source config/.env  # 2. source environment variables before running 
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/demo_aws_cognito](https://hexdocs.pm/demo_aws_cognito).

