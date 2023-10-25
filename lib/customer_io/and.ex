defmodule CustomerIo.And do
  @moduledoc """
  Provides struct and types for a And
  """

  @type t :: %__MODULE__{and: [CustomerIo.Audience.t() | CustomerIo.Segment.t() | map] | nil}

  defstruct [:and]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [and: [union: [{CustomerIo.Audience, :t}, {CustomerIo.Segment, :t}, :map]]]
  end
end
