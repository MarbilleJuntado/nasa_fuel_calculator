defmodule NASA.PlanetTest do
  use ExUnit.Case
  alias NASA.Planet

  test "returns known planets" do
    assert "earth" in Planet.known_planets()
    assert "moon" in Planet.known_planets()
    assert "mars" in Planet.known_planets()
  end

  test "returns correct gravity for known planets" do
    assert %Planet{gravity: g} = Planet.get("earth")
    assert Decimal.compare(g, Decimal.new("9.807")) == :eq

    assert %Planet{gravity: g} = Planet.get("MARS")
    assert Decimal.compare(g, Decimal.new("3.711")) == :eq
  end

  test "returns error for unknown planet" do
    assert {:error, :unknown_planet} = Planet.get("jupiter")
  end
end
