defmodule CustomerIo.EmailOrId do
  @moduledoc """
  Provides struct and type for a EmailOrId
  """

  @type t :: %__MODULE__{
          identifiers: [map] | nil,
          ids: [String.t()] | nil,
          next: String.t() | nil
        }

  defstruct [:identifiers, :ids, :next]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [identifiers: [:map], ids: [string: :generic], next: {:string, :generic}]
  end
end
