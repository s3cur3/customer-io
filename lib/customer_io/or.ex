defmodule CustomerIo.Or do
  @moduledoc """
  Provides struct and types for a Or
  """

  @type t :: %__MODULE__{
          or:
            [CustomerIo.Attribute.t() | CustomerIo.Audience.t() | CustomerIo.Segment.t() | map]
            | nil
        }

  defstruct [:or]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      or: [
        union: [
          {CustomerIo.Attribute, :t},
          {CustomerIo.Audience, :t},
          {CustomerIo.Segment, :t},
          :map
        ]
      ]
    ]
  end
end
