defmodule CustomerIo.Track.Delivery do
  @moduledoc """
  Provides struct and types for a Delivery
  """

  @type t :: %__MODULE__{
          action: String.t(),
          attributes: map,
          identifiers: map,
          name: String.t(),
          type: String.t()
        }

  defstruct [:action, :attributes, :identifiers, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {:const, "event"},
      attributes: :map,
      identifiers: :map,
      name: {:enum, ["opened", "converted", "delivered"]},
      type: {:const, "delivery"}
    ]
  end
end
