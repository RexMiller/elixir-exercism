defmodule Bob do

  @type sentance_type :: :silence | :question | :shout | :normal_talk

  @responses %{
    silence: "Fine. Be that way!",
    question: "Sure.",
    shout: "Whoa, chill out!",
    normal_talk: "Whatever."
  }

  def hey(input) do
    cond do
      is_silence(input) -> respond_to(:silence)
      is_question(input) -> respond_to(:question)
      is_non_alpha(input) -> respond_to(:normal_talk)
      is_shouting(input) -> respond_to(:shout)
      is_anything_else(input) -> respond_to(:normal_talk)
    end
  end

  @spec respond_to(sentance_type) :: String.t()
  defp respond_to(sentance_type),
    do: @responses[sentance_type]

  defp is_silence(input),
    do: Regex.match?(~r/^\s*$/, input)

  defp is_question(input),
    do: String.ends_with?(input, "?")

  defp is_non_alpha(input),
    do: Regex.match?(~r/^[\d\W]*$/, input)

  defp is_shouting(input),
    do: String.upcase(input) == input

  defp is_anything_else(_),
    do: true

end
