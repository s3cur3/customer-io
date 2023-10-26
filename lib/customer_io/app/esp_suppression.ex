defmodule CustomerIo.App.EspSuppression do
  @moduledoc """
  Provides API endpoints related to esp suppression
  """

  @default_client CustomerIo.App.Client

  @doc """
  Un-suppress an ESP-suppressed address

  Remove an address from the ESP's suppression list.
  """
  @spec delete_suppression(String.t(), String.t(), keyword) :: :ok | :error
  def delete_suppression(suppression_type, email_address, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [suppression_type: suppression_type, email_address: email_address],
      call: {CustomerIo.App.EspSuppression, :delete_suppression},
      url: "/v1/esp/suppression/#{suppression_type}/#{email_address}",
      method: :delete,
      response: [{204, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Look up an ESP-suppressed address

  Look up an email address to learn if, and why, it was suppressed by the email service provider (ESP).
  """
  @spec get_suppression(String.t(), keyword) :: {:ok, map} | :error
  def get_suppression(email_address, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [email_address: email_address],
      call: {CustomerIo.App.EspSuppression, :get_suppression},
      url: "/v1/esp/search_suppression/#{email_address}",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get ESP-suppressed emails by type

  Find addresses suppressed by the Email Service Provider (ESP) for a particular reason—bounces, blocks, spam reports, or invalid email addresses.

  You can get up to 1000 addresses per request. Use the `offset` parameter to get addresses beyond the first 1000.


  ## Options

    * `limit`: The maximum number of results you want to retrieve per page.
    * `offset`: The number of records to skip before retrieving results.

  """
  @spec get_suppression_by_type(String.t(), keyword) :: {:ok, map} | :error
  def get_suppression_by_type(suppression_type, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :offset])

    client.request(%{
      args: [suppression_type: suppression_type],
      call: {CustomerIo.App.EspSuppression, :get_suppression_by_type},
      url: "/v1/esp/suppression/#{suppression_type}",
      method: :get,
      query: query,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Suppress an email at the ESP

  Suppress an email address at the email service provider (ESP). Addresses suppressed this way are only suppressed through the ESP; these adresses are _not_ suppressed in Customer.io, so the person can remain in your workspace (though emails to the address would be blocked at the ESP).
  """
  @spec post_suppression(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def post_suppression(suppression_type, email_address, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [suppression_type: suppression_type, email_address: email_address],
      call: {CustomerIo.App.EspSuppression, :post_suppression},
      url: "/v1/esp/suppression/#{suppression_type}/#{email_address}",
      method: :post,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
