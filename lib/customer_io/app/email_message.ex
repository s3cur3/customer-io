defmodule CustomerIo.App.EmailMessage do
  @moduledoc """
  Provides struct and types for a EmailMessage
  """

  @type t :: %__MODULE__{
          bcc: String.t() | nil,
          body: String.t() | nil,
          body_amp: String.t() | nil,
          campaign_id: integer | nil,
          created: integer | nil,
          deduplicate_id: String.t() | nil,
          fake_bcc: boolean | nil,
          from: String.t() | nil,
          from_id: integer | nil,
          headers: [map] | nil,
          id: integer | nil,
          language: String.t() | nil,
          layout: String.t() | nil,
          name: String.t() | nil,
          parent_action_id: integer | nil,
          preheader_text: String.t() | nil,
          preprocessor: String.t() | nil,
          recipient: String.t() | nil,
          reply_to: String.t() | nil,
          reply_to_id: integer | nil,
          sending_state: String.t() | nil,
          subject: String.t() | nil,
          type: String.t() | nil,
          updated: integer | nil
        }

  defstruct [
    :bcc,
    :body,
    :body_amp,
    :campaign_id,
    :created,
    :deduplicate_id,
    :fake_bcc,
    :from,
    :from_id,
    :headers,
    :id,
    :language,
    :layout,
    :name,
    :parent_action_id,
    :preheader_text,
    :preprocessor,
    :recipient,
    :reply_to,
    :reply_to_id,
    :sending_state,
    :subject,
    :type,
    :updated
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bcc: {:string, :generic},
      body: {:string, :generic},
      body_amp: {:string, :generic},
      campaign_id: :integer,
      created: :integer,
      deduplicate_id: {:string, :generic},
      fake_bcc: :boolean,
      from: {:string, :generic},
      from_id: :integer,
      headers: [:map],
      id: :integer,
      language: {:string, :generic},
      layout: {:string, :generic},
      name: {:string, :generic},
      parent_action_id: :integer,
      preheader_text: {:string, :generic},
      preprocessor: {:const, "premailer"},
      recipient: {:string, :generic},
      reply_to: {:string, :generic},
      reply_to_id: :integer,
      sending_state: {:enum, ["automatic", "draft", "off"]},
      subject: {:string, :generic},
      type: {:enum, ["email", "in-app", "push", "twilio", "slack", "urban_airship"]},
      updated: :integer
    ]
  end
end
