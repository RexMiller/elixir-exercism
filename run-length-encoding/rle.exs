defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  @space ?\s
  @digits ?0..?9

  @spec encode(String.t) :: String.t
  def encode(string), do: do_encode(string, "", 0)

  defp do_encode(<<>>, encoded, _), do: encoded

  defp do_encode(<<hd::utf8, tl::binary>>, encoded, count) do
    (fn       
      (current_char, <<next_char::utf8, _::binary>>)
        when current_char == next_char and current_char != @space -> 
          do_encode(tl, encoded, count + 1)
      
      (_, _) -> do_encode(tl, append_encoded(hd, encoded, count), 0)
    end).(hd, tl)
  end

  defp append_encoded(char, encoded, 0), do: "#{encoded}#{<<char>>}"
  defp append_encoded(char, encoded, count), do: "#{encoded}#{count + 1}#{<<char>>}"


  @spec decode(String.t) :: String.t
  def decode(string), do: do_decode(string, "", "")
  
  defp do_decode(<<>>, decoded, _), do: decoded

  defp do_decode(<<hd::utf8, tl::binary>>, decoded, count_str) do
    (fn      
      (current_char) when current_char in @digits -> 
          do_decode(tl, decoded, "#{count_str}#{<<current_char>>}")

      (current_char) ->
          do_decode(tl, decoded <> append_decoded(current_char, count_str), "")
    end).(hd)
  end

  defp append_decoded(char, ""), do: <<char>>
  defp append_decoded(char, count_str), do: String.duplicate(<<char>>, String.to_integer(count_str))

end