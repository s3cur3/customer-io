defmodule CustomerIo.Track.StandardEvent do
  @moduledoc """
  Provides struct and type for a StandardEvent
  """

  @type t :: %__MODULE__{
          data: map | nil,
          id: String.t() | nil,
          name: String.t(),
          timestamp: integer | nil,
          type: String.t() | nil
        }

  defstruct [:data, :id, :name, :timestamp, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      data: :map,
      id: {:string, :generic},
      name: {:string, :generic},
      timestamp: :integer,
      type: {:const, "event"}
    ]
  end
end
