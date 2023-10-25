defmodule CustomerIo.SubscriptionCenter do
  @moduledoc """
  Provides API endpoint related to subscription center
  """

  @default_client CustomerIo.Client

  @doc """
  List subscription topics

  Returns a list of subscription topics in your workspace. If there are no topics, it returns an empty array.
  """
  @spec get_topics(keyword) :: {:ok, map} | :error
  def get_topics(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.SubscriptionCenter, :get_topics},
      url: "/v1/subscription_topics",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
