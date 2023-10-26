defmodule CustomerIo.Track do
  @moduledoc """
  High-level wrappers for common functionality.
  """
  alias CustomerIo.Track.TrackCustomers

  @type user_id :: String.t() | integer()

  @doc """
  Identifies (or syncs) a user to Customer.io.

  If the user did not previously exist, they will be created in
  Customer.io's People section. If they *did* exist, any new attributes
  will be added to their profile.

  User attributes to sync often include:

  - `email`
  - `name` (or `first_name`/`last_name` pair)
  - `created_at` (the Unix timestamp at which the user signed up in _your_ app)
  - `is_admin` or similar

  ## Examples

      iex> user = %User{id: 123, email: "jdoe@hotmail.com", name: "J. Doe"}
      iex> CustomerIo.Track.identify(user, %{email: user.email, name: user.name})
  """
  @spec identify(user_id() | %{id: user_id()}, map(), Keyword.t()) :: :ok | :error
  def identify(user_struct_or_id, user_attributes \\ %{}, opts \\ [])
  def identify(%{id: user_id}, user_attrs, opts), do: identify(user_id, user_attrs, opts)

  def identify(user_id, user_attrs, opts) when is_binary(user_id) or is_integer(user_id) do
    TrackCustomers.identify(to_string(user_id), user_attrs, opts)
  end
end
