defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    pling([], rem(number, 3))
    |> plang(rem(number, 5))
    |> plong(rem(number, 7))
    |> make_rain(number)
  end

  defp pling(raindrops, 0), do: ["Pling" | raindrops]
  defp pling(raindrops, _), do: raindrops
  defp plang(raindrops, 0), do: ["Plang" | raindrops]
  defp plang(raindrops, _), do: raindrops
  defp plong(raindrops, 0), do: ["Plong" | raindrops]
  defp plong(raindrops, _), do: raindrops

  defp make_rain([], number), 
    do: "#{number}"
  defp make_rain(raindrops, _), 
    do: raindrops |> Enum.reverse() |> Enum.join()
end
