defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @letter_scores %{
    "AEIOULNRST" => 1,
    "DG" => 2,
    "BCMP" => 3,
    "FHVWY" => 4,
    "K" => 5,
    "JX" => 8,
    "QZ" => 10
  }

  @spec score(String.t) :: non_neg_integer
  def score(word),
    do: do_score(word, build_score_map(), 0)

  defp do_score(<<>>, _, total), do: total

  defp do_score(<<hd::utf8, tl::binary>>, map, total),
    do: do_score(tl, map, total + score_letter(hd, map))

  defp score_letter(char, map) when char in ?a..?z or char in ?A..?Z,
    do: map[String.upcase(<<char>>)]

  defp score_letter(_, _), do: 0

  defp build_score_map() do
    Enum.reduce(@letter_scores, %{}, fn({letters, score}, map) -> 
      String.split(letters, "", trim: true) 
      |> Enum.reduce(map, fn(letter, m) -> 
        Map.put(m, letter, score) 
      end) 
    end)
  end

end
