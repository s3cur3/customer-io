defmodule CustomerIo.App.And do
  @moduledoc """
  Provides struct and types for a And
  """

  @type t :: %__MODULE__{
          and: [CustomerIo.App.Audience.t() | CustomerIo.App.Segment.t() | map] | nil
        }

  defstruct [:and]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [and: [union: [{CustomerIo.App.Audience, :t}, {CustomerIo.App.Segment, :t}, :map]]]
  end
end
