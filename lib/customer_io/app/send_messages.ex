defmodule CustomerIo.App.SendMessages do
  @moduledoc """
  Provides API endpoints related to send messages
  """

  @default_client CustomerIo.App.Client

  @doc """
  Send a transactional email

  Send a transactional email. You can send a message using a `transactional_message_id` or send your own `body`, `subject`, and `from` values at send time. The `transactional_message_id` can be either the numerical ID for the template or the *Trigger Name* that you assigned the template.

  If you want to send your own `body`, `subject`, and `from` values to populate your message at send time, we recommend that you pass a `transactional_message_id` anyway; the values you pass in the request will override the template.

  You can find your `transactional_message_id` from the code sample in the **Overview** tab for your transactional message in the user interface, or you can look up a list of your transactional messages through the [App API](#tag/Transactional).

  Customer.io attributes metrics to a `transactional_message_id`; if you don't provide a `transactional_message_id`, we attribute metrics to `"transactional_message_id": 1`. You can create empty transactional messages in the UI and override the `body`, `subject`, and `from` values at send time. This provides flexibility in your integration and lets you organize metrics (rather than gathering metrics for all of your transactional messages against a single ID).

  """
  @spec send_email(CustomerIo.App.WithTemplate.t() | CustomerIo.App.WithoutTemplate.t(), keyword) ::
          {:ok, map} | {:error, map}
  def send_email(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.SendMessages, :send_email},
      url: "/v1/send/email",
      body: body,
      method: :post,
      request: [
        {"application/json",
         {:union, [{CustomerIo.App.WithTemplate, :t}, {CustomerIo.App.WithoutTemplate, :t}]}}
      ],
      response: [{200, :map}, {400, :map}],
      opts: opts
    })
  end

  @doc """
  Send a transactional push

  Send a transactional push. You send a message using a `transactional_message_id` for a transactional push message template composed in the user interface. You can optionally override any of the template values at send time. The `transactional_message_id` can be either the numerical ID for the template or the *Trigger Name* that you assigned the template.

  You can find your `transactional_message_id` from the code sample in the **Overview** tab for your transactional message in the user interface, or you can look up a list of your transactional messages through the [App API](#tag/Transactional).

  """
  @spec send_push(map, keyword) :: {:ok, map} | {:error, map}
  def send_push(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.SendMessages, :send_push},
      url: "/v1/send/push",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :map}],
      opts: opts
    })
  end

  @doc """
  Trigger a broadcast

  Manually trigger a broadcast, and provide data to populate messages in your trigger. The shape of the request changes based on the type of audience you broadcast to: a segment, a list of emails, a list of customer IDs, a map of users, or a data file. You can reference properties in the `data` object from this request using liquid—`{{trigger.<property_in_data_obj>}}`.

  If your broadcast produces a `422` error, you can [get more information about the errors](#operation/broadcastErrors) to see what went wrong.

  **This endpoint is rate-limited to one request every 10 seconds.** After exceeding this, you'll receive a status of 429. Broadcasts are optimized to send messages to a large audience and not for one-to-one interactions. Use our [transactional API](#send-email) or event-triggered campaigns to respond to your audience on an individual, one-to-one basis.

  """
  @spec trigger_broadcast(
          integer,
          CustomerIo.App.CustomRecipients.t()
          | CustomerIo.App.DataFileUrl.t()
          | CustomerIo.App.DefaultAudience.t()
          | CustomerIo.App.Emails.t()
          | CustomerIo.App.Ids.t()
          | CustomerIo.App.UserMaps.t(),
          keyword
        ) :: {:ok, map} | {:error, map}
  def trigger_broadcast(broadcast_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id, body: body],
      call: {CustomerIo.App.SendMessages, :trigger_broadcast},
      url: "/v1/campaigns/#{broadcast_id}/triggers",
      body: body,
      method: :post,
      request: [
        {"application/json",
         {:union,
          [
            {CustomerIo.App.CustomRecipients, :t},
            {CustomerIo.App.DataFileUrl, :t},
            {CustomerIo.App.DefaultAudience, :t},
            {CustomerIo.App.Emails, :t},
            {CustomerIo.App.Ids, :t},
            {CustomerIo.App.UserMaps, :t}
          ]}}
      ],
      response: [{200, :map}, {401, :null}, {404, :null}, {422, :map}],
      opts: opts
    })
  end
end
