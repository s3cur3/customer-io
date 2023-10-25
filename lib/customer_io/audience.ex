defmodule CustomerIo.Audience do
  @moduledoc """
  Provides struct and types for a Audience
  """

  @type t :: %__MODULE__{attribute: CustomerIo.Attribute.t() | nil}

  defstruct [:attribute]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [attribute: {CustomerIo.Attribute, :t}]
  end
end
