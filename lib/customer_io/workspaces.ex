defmodule CustomerIo.Workspaces do
  @moduledoc """
  Provides API endpoint related to workspaces
  """

  @default_client CustomerIo.Client

  @doc """
  List workspaces

  Returns a list of workspaces in your account.
  """
  @spec list_workspaces(keyword) :: {:ok, map} | :error
  def list_workspaces(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Workspaces, :list_workspaces},
      url: "/v1/workspaces",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end
end
