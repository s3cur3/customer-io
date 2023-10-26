defmodule CustomerIo.Track.Forms do
  @moduledoc """
  Provides API endpoint related to forms
  """

  @default_client CustomerIo.Track.Client

  @doc """
  Submit a form

  Submit a form response. If Customer.io does not recognize the `form_id` we create a new form connection (found on the *Data & Integrations* > *Integrations* > *Forms* page). Form submissions with the same ID are treated as submissions from the same form.

  The `data` object _must_ contain at least one of `id` or `email` (depending on the identifiers supported in your workspace)—or a field that is mapped to one of these identifiers—to identify the form respondent. If the person who submitted the form does not already exist, we create them (like an [identify](#operation/identify) request).

  Additional keys in the `data` object represent form fields and values from the form that a person submitted. By default, we map form fields in your request directly to attributes, e.g. if you have a form field called `first_name`, we map that field to the `first_name` attribute.

  **NOTES**: 
    * You cannot disable fields that you send to this API. If you send a field (as `data`) to this API, we'll include it in the form submission.
    * If an identifier in your form is called something like `email_address` rather than `email` in your initial request, you'll receive a `400`, but we'll still add your form on the **Data & Integrations** > **Integrations** > **Forms** page. You can then re-map your `email_address` field to `email`, and your form will begin working normally.
    * Customer.io reserves `form_id`, `form_name`, `form_type`, `form_url`, and `form_url_param` keys. If your request includes these keys, Customer.io ignores them.

  """
  @spec submit_form(String.t(), map, keyword) :: :ok | {:error, map}
  def submit_form(form_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [form_id: form_id, body: body],
      call: {CustomerIo.Track.Forms, :submit_form},
      url: "/api/v1/forms/#{form_id}/submit",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, :null}, {400, :map}, {500, :null}],
      opts: opts
    })
  end
end
