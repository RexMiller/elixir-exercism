defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string), do: do_encode(string, "", 0)

  defp do_encode(<<>>, encoded, _), do: encoded

  defp do_encode(<<hd::utf8, tl::binary>>, encoded, count) do
    cond do
      hd == ?\s -> do_encode(tl, "#{encoded} ", 0)
      contiguious?(hd, tl) -> do_encode(tl, encoded, count + 1)
      true -> do_encode(tl, encode_segment(hd, encoded, count), 0)
    end
  end

  defp contiguious?(hd, <<next::utf8, _::binary>>) when hd == next, do: true
  defp contiguious?(_, _), do: false

  defp encode_segment(hd, encoded, 0), do: "#{encoded}#{<<hd>>}"
  defp encode_segment(hd, encoded, count), do: "#{encoded}#{count + 1}#{<<hd>>}"

  # @spec decode(String.t) :: String.t
  # def decode(string) do

  # end
end
