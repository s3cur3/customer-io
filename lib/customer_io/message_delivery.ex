defmodule CustomerIo.MessageDelivery do
  @moduledoc """
  Provides struct and types for a MessageDelivery
  """

  @type t :: %__MODULE__{
          delivered: integer | nil,
          delivery_id: String.t() | nil,
          opened: boolean | nil
        }

  defstruct [:delivered, :delivery_id, :opened]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [delivered: :integer, delivery_id: {:string, :generic}, opened: :boolean]
  end
end
