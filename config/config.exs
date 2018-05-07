# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
# .  config :demo_aws_cognito, key: :value
#
# and access this configuration in your application as:
#
# .  Application.get_env(:demo_aws_cognito, :key)
#
# You can also configure.3rd-party app:
#
# .  config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
# .  import_config "#{Mix.env}.exs"

config :demo_aws_cognito,
  access_key_id: System.get_env("ACCESS_KEY_ID"),
  secret_access_key: System.get_env("SECRET_ACCESS_KEY"),
  region: System.get_env("REGION"),
  endpoint: System.get_env("ENDPOINT"),
  client_id: System.get_env("CLIENT_ID"),
  user_pool_id: System.get_env("USER_POOL_ID")
