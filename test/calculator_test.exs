defmodule NASA.CalculatorTest do
  use ExUnit.Case
  alias NASA.Calculator
  alias Decimal, as: D

  test "calculates fuel recursively for landing on Earth" do
    mass = D.new(28801)
    gravity = D.new("9.807")
    expected = D.new(13447)

    result = Calculator.fuel_required(mass, :land, gravity)
    assert D.compare(result, expected) == :eq
  end

  test "calculates fuel for launch from Moon" do
    fuel = Calculator.fuel_required(D.new(1000), :launch, D.new("1.62"))
    assert D.compare(fuel, D.new(35)) == :eq
  end
end
