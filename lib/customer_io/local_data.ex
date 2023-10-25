defmodule CustomerIo.LocalData do
  @moduledoc """
  Provides struct and types for a LocalData
  """

  @type t :: %__MODULE__{data: [map] | nil, name: String.t() | nil}

  defstruct [:data, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: [:map], name: {:string, :generic}]
  end
end
