defmodule CustomerIo.App.Webhook do
  @moduledoc """
  Provides struct and types for a Webhook
  """

  @type t :: %__MODULE__{
          body: String.t() | nil,
          campaign_id: integer | nil,
          created: integer | nil,
          deduplicate_id: String.t() | nil,
          headers: [map] | nil,
          id: integer | nil,
          layout: String.t() | nil,
          method: String.t() | nil,
          name: String.t() | nil,
          parent_action_id: integer | nil,
          sending_state: String.t() | nil,
          type: String.t() | nil,
          updated: integer | nil,
          url: String.t() | nil
        }

  defstruct [
    :body,
    :campaign_id,
    :created,
    :deduplicate_id,
    :headers,
    :id,
    :layout,
    :method,
    :name,
    :parent_action_id,
    :sending_state,
    :type,
    :updated,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      body: {:string, :generic},
      campaign_id: :integer,
      created: :integer,
      deduplicate_id: {:string, :generic},
      headers: [:map],
      id: :integer,
      layout: {:string, :generic},
      method: {:enum, ["get", "post", "put", "delete", "patch"]},
      name: {:string, :generic},
      parent_action_id: :integer,
      sending_state: {:enum, ["automatic", "draft", "off"]},
      type: {:const, "webhook"},
      updated: :integer,
      url: {:string, :generic}
    ]
  end
end
