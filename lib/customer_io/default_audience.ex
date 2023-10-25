defmodule CustomerIo.DefaultAudience do
  @moduledoc """
  Provides struct and types for a DefaultAudience
  """

  @type t :: %__MODULE__{
          data: map | nil,
          email_add_duplicates: boolean | nil,
          email_ignore_missing: boolean | nil,
          id_ignore_missing: boolean | nil
        }

  defstruct [:data, :email_add_duplicates, :email_ignore_missing, :id_ignore_missing]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      data: :map,
      email_add_duplicates: :boolean,
      email_ignore_missing: :boolean,
      id_ignore_missing: :boolean
    ]
  end
end
