defmodule CustomerIo.App.Customers do
  @moduledoc """
  Provides API endpoints related to customers
  """

  @default_client CustomerIo.App.Client

  @doc """
  List customers, attributes, and devices

  Return attributes and devices for up to 100 customers by ID. If an ID in the request does not exist, the response omits it.
  """
  @spec get_people_by_id(map, keyword) :: {:ok, map} | :error
  def get_people_by_id(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.Customers, :get_people_by_id},
      url: "/v1/customers/attributes",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get customers by email

  Return a list of people in your workspace matching an email address.


  ## Options

    * `email`: The email address you want to search for.

  """
  @spec get_people_email(keyword) :: {:ok, map} | :error
  def get_people_email(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:email])

    client.request(%{
      args: [],
      call: {CustomerIo.App.Customers, :get_people_email},
      url: "/v1/customers",
      method: :get,
      query: query,
      response: [{200, :map}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Search for customers

  Provide a filter to search for people in your workspace. Your filter can filter people by segment (using the Segment ID) and attribute values; when you filter by attributes, you can use `eq` (matching an attribute value) or `exists` (matching when a person has the attribute). Use the `and` array, `or` array, and `not` object to create a complex filter. The `not` selector is an object that takes a single filter.

  Returns arrays of `identifiers` and `ids`. In general, you should rely on the newer `identifiers` array, which contains more complete information about each person captured by the filter in your request, than the `ids` array, which only contains `id` values.

  You can return up to 1000 people per request. If you want to return a larger set of people in a single request, you may want to use the [`/exports`](#tag/Exports) API instead.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.

  """
  @spec get_people_filter(map, keyword) :: {:ok, map} | :error
  def get_people_filter(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :start])

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.Customers, :get_people_filter},
      url: "/v1/customers",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{200, :map}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a customer's activities

  Return a list of activities performed by, or for, a customer. Activities are things like attribute changes and message sends.

  ## Options

    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.
    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `type`: The type of activity you want to search for.
    * `name`: For `event` and `attribute_update` types, you can search by event or attribute name respectively.

  """
  @spec get_person_activities(String.t(), keyword) :: {:ok, map} | :error
  def get_person_activities(customer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type, :limit, :name, :start, :type])

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_activities},
      url: "/v1/customers/#{customer_id}/activities",
      method: :get,
      query: query,
      response: [{200, :map}, {400, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a customer's attributes

  Return a list of attributes for a customer profile. You can use attributes to fashion segments or as liquid merge fields in your messages.

  ## Options

    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.

  """
  @spec get_person_attributes(String.t(), keyword) :: {:ok, map} | :error
  def get_person_attributes(customer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type])

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_attributes},
      url: "/v1/customers/#{customer_id}/attributes",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup messages sent to a customer

  Returns information about the deliveries sent to a person. Provide query parameters to refine the data you want to return.

  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return the most recent 6 months of messages. If your `start_ts` and `end_ts` range is more than 6 months, we'll return 6 months of data from the most recent timestamp in your request.


  ## Options

    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.
    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec get_person_messages(String.t(), keyword) :: {:ok, map} | :error
  def get_person_messages(customer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:end_ts, :id_type, :limit, :start, :start_ts])

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_messages},
      url: "/v1/customers/#{customer_id}/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a customer's relationships

  Return a list of objects that a person is related to.
  """
  @spec get_person_relationships(String.t(), keyword) :: {:ok, map} | :error
  def get_person_relationships(customer_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_relationships},
      url: "/v1/customers/#{customer_id}/relationships",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a customer's segments

  Returns a list of segments that a customer profile belongs to.

  ## Options

    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.

  """
  @spec get_person_segments(String.t(), keyword) :: {:ok, map} | :error
  def get_person_segments(customer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type])

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_segments},
      url: "/v1/customers/#{customer_id}/segments",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a customer's subscription preferences

  Returns a list of subscription preferences for a person, including the custom header of the subscription preferences page, topic names, and topic descriptions. Returns translated data when you send a language in the query.

  ## Options

    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.
    * `language`: A [language tag](/docs/journeys/unsubscribes/#currently-supported-languages) you want the content translated in. If none is provided, the content will be sent in the default lanauge of your subscription center.

  """
  @spec get_person_subscription_preferences(String.t(), keyword) :: {:ok, map} | {:error, map}
  def get_person_subscription_preferences(customer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type, :language])

    client.request(%{
      args: [customer_id: customer_id],
      call: {CustomerIo.App.Customers, :get_person_subscription_preferences},
      url: "/v1/customers/#{customer_id}/subscription_preferences",
      method: :get,
      query: query,
      response: [{200, :map}, {400, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end
end
