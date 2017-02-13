defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/\W/, " ")
    |> String.split(~r/\s+/, trim: true)
    |> count_words()
  end

  def count_words(words),
    do: Enum.reduce(words, %{}, &update_count/2)

  def update_count(word, map),
    do: Map.update(map, word, 1, &(&1 + 1))

end
