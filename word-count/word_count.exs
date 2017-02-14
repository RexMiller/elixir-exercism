defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.replace("_", " ")
    |> String.downcase()
    |> scan_words()
    |> count_words()
  end

  defp scan_words(sentence) do
    Regex.scan(~r/(*UTF8)[\w-]+/, sentence)
    |> Enum.flat_map(&(&1))
  end

  defp count_words(words),
    do: Enum.reduce(words, %{}, &update_count/2)

  defp update_count(word, map),
    do: Map.update(map, word, 1, &(&1 + 1))

end
