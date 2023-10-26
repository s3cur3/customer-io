defmodule CustomerIo.App.Or do
  @moduledoc """
  Provides struct and types for a Or
  """

  @type t :: %__MODULE__{
          or:
            [
              CustomerIo.App.Attribute.t()
              | CustomerIo.App.Audience.t()
              | CustomerIo.App.Segment.t()
              | map
            ]
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
          {CustomerIo.App.Attribute, :t},
          {CustomerIo.App.Audience, :t},
          {CustomerIo.App.Segment, :t},
          :map
        ]
      ]
    ]
  end
end
