defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples
  iex> DNA.count('AATAA', ?A)
  4
  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    validate_nucleotide(nucleotide)
    validate_strand(strand)
    Enum.count(strand, &(&1 == nucleotide))
  end

  defp validate_nucleotide(nucleotide) do
    if not nucleotide in @nucleotides,
      do: raise ArgumentError
  end

  defp validate_strand(strand) do
    Enum.each(strand, &validate_nucleotide/1)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples
  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    validate_strand(strand)
    histogram = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    Enum.reduce(strand, histogram, &update_histogram/2)
  end

  defp update_histogram(char, histogram) do
    Map.update!(histogram, char, &(&1 + 1))
  end

end
