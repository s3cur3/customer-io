defmodule CustomerIo.App.DataByUrl do
  @moduledoc """
  Provides struct and types for a DataByUrl
  """

  @type t :: %__MODULE__{name: String.t() | nil, url: String.t() | nil}

  defstruct [:name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: {:string, :generic}, url: {:string, :generic}]
  end
end
