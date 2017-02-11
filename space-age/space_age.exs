defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune


  @earth_orbit 31557600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    planet 
    |> get_orbital_offset() 
    |> calculate_age(seconds)
  end

  def get_orbital_offset(planet), 
    do: orbital_offsets()[planet]

  def calculate_age(offset, seconds),
    do: seconds/(@earth_orbit * offset)

  def orbital_offsets() do
    %{
      :earth => 1,
      :mercury => 0.2408467,
      :venus => 0.61519726,
      :mars => 1.8808158,
      :jupiter => 11.862615,
      :saturn => 29.447498,
      :uranus => 84.016846,
      :neptune => 164.79132,
    }
  end

end
