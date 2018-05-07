defmodule DemoAwsCognito do
  @moduledoc """
  Documentation for DemoAwsCognito.
  """

  alias AWS.Cognito.IdentityProvider

  @doc """
  create new user.
  """
  def create_user(username, email) do
    {client, user_pool_id, client_id} = create_client()

    input = %{
      UserPoolId: user_pool_id,
      ClientId: client_id,
      Username: username,
      UserAttributes: [
        %{
          Name: "email",
          Value: email
        }
      ]
    }

    client
    |> IdentityProvider.admin_create_user(input)
  end

  @doc """
  login user
  """
  def login(username, password) do
    {client, user_pool_id, client_id} = create_client()

    input = %{
      UserPoolId: user_pool_id,
      ClientId: client_id,
      AuthFlow: "ADMIN_NO_SRP_AUTH",
      AuthParameters: %{
        USERNAME: username,
        PASSWORD: password
      }
    }

    client
    |> IdentityProvider.admin_initiate_auth(input)
  end

  @doc """
  first authentication after creating a new user.
  """
  def initial_login(username, password, new_password) do
    {client, user_pool_id, client_id} = create_client()

    session =
      login(username, password)
      |> get_session

    input = %{
      UserPoolId: user_pool_id,
      ClientId: client_id,
      ChallengeName: "NEW_PASSWORD_REQUIRED",
      ChallengeResponses: %{
        USERNAME: username,
        NEW_PASSWORD: new_password
      },
      Session: session
    }

    client
    |> IdentityProvider.admin_respond_to_auth_challenge(input)
  end

  @doc """
  get user by valid token.
  """
  def get_user(access_token) do
    {client, _, _} = create_client()

    input = %{
      AccessToken: access_token
    }

    client
    |> IdentityProvider.get_user(input)
  end

  @doc """
  get list of all users
  """
  def get_users do
    {client, user_pool_id, client_id} = create_client()

    input = %{
      UserPoolId: user_pool_id,
      ClientId: client_id
    }

    client
    |> IdentityProvider.list_users(input)
  end

  @doc """
  logout user
  """
  def logout(access_token) do
    {client, _, _} = create_client()

    input = %{
      AccessToken: access_token
    }

    client
    |> IdentityProvider.global_sign_out(input)
  end

  @doc """
  delete user
  """
  def delete_user(username) do
    {client, user_pool_id, _} = create_client()

    input = %{
      UserPoolId: user_pool_id,
      Username: username
    }

    client
    |> IdentityProvider.admin_delete_user(input)
  end

  defp get_session({:ok, %{"Session" => session}, _}), do: session

  defp create_client do
    client = %AWS.Client{
      access_key_id: Application.get_env(:demo_aws_cognito, :access_key_id),
      secret_access_key: Application.get_env(:demo_aws_cognito, :secret_access_key),
      region: Application.get_env(:demo_aws_cognito, :region),
      endpoint: Application.get_env(:demo_aws_cognito, :endpoint)
    }

    {client, Application.get_env(:demo_aws_cognito, :user_pool_id),
     Application.get_env(:demo_aws_cognito, :client_id)}
  end
end
