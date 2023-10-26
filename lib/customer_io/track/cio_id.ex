defmodule CustomerIo.Track.CioId do
  @moduledoc """
  Provides struct and types for a CioId
  """

  @type t :: %__MODULE__{cio_id: String.t() | nil}

  defstruct [:cio_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cio_id: {:string, :generic}]
  end
end
