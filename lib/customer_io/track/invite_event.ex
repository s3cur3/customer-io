defmodule CustomerIo.Track.InviteEvent do
  @moduledoc """
  Provides struct and type for a InviteEvent
  """

  @type t :: %__MODULE__{
          data: map,
          name: String.t(),
          timestamp: integer | nil,
          type: String.t() | nil
        }

  defstruct [:data, :name, :timestamp, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: :map, name: {:string, :generic}, timestamp: :integer, type: {:string, :generic}]
  end
end
