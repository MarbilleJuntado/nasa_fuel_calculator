defmodule NASA.Planet do
  @moduledoc "Supported planets and their gravity"

  defstruct [:name, :gravity]

  # Yes, the moon is not a planet, but for simplicity, let's call it a planet in name only
  @known %{
    "earth" => Decimal.new("9.807"),
    "moon" => Decimal.new("1.62"),
    "mars" => Decimal.new("3.711")
  }

  def known_planets, do: Map.keys(@known)

  def get(name) when is_binary(name) do
    gravity = Map.get(@known, String.downcase(name))
    if gravity, do: %__MODULE__{name: name, gravity: gravity}, else: {:error, :unknown_planet}
  end
end
