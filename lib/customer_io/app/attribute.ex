defmodule CustomerIo.App.Attribute do
  @moduledoc """
  Provides struct and types for a Attribute
  """

  @type t :: %__MODULE__{
          field: String.t(),
          operator: String.t(),
          value: String.t() | nil,
          attribute: CustomerIo.App.Attribute.t() | nil
        }

  defstruct [:attribute, :field, :operator, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {:string, :generic},
      operator: {:enum, ["eq", "exists"]},
      value: {:string, :generic},
      attribute: {CustomerIo.App.Attribute, :t}
    ]
  end
end
