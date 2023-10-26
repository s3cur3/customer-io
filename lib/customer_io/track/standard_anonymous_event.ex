defmodule CustomerIo.Track.StandardAnonymousEvent do
  @moduledoc """
  Provides struct and type for a StandardAnonymousEvent
  """

  @type t :: %__MODULE__{
          anonymous_id: String.t() | nil,
          data: map | nil,
          id: String.t() | nil,
          name: String.t(),
          timestamp: integer | nil,
          type: String.t() | nil
        }

  defstruct [:anonymous_id, :data, :id, :name, :timestamp, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      anonymous_id: {:string, :generic},
      data: :map,
      id: {:string, :generic},
      name: {:string, :generic},
      timestamp: :integer,
      type: {:enum, ["event", "page", "screen"]}
    ]
  end
end
