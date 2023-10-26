defmodule CustomerIo.Track.Email do
  @moduledoc """
  Provides struct and types for a Email
  """

  @type t :: %__MODULE__{email: String.t() | nil}

  defstruct [:email]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: {:string, :generic}]
  end
end
