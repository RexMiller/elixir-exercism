defmodule Acronym do
  @doc """
  Generate an acronym from a string.

  ## Examples
  iex> Acronym.abbreviate("This is a string")
  "TIAS"
  """
  def abbreviate(string) do
    string
    |> separate_mixed_case()
    |> split_on_spaces()
    |> get_first_letters()
    |> Enum.join()
    |> String.upcase()
  end

  defp separate_mixed_case(string),
    do: Regex.replace(~r/(\w)([A-Z])/, string, "\\1 \\2")

  defp split_on_spaces(string),
    do: String.split(string, ~r/[\s\p{Pd}]/, trim: true)

  defp get_first_letters(words),
    do: Enum.map(words, fn(<<letter::binary-size(1), _::binary>>) -> letter end)

end
