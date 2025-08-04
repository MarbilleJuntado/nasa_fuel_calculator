defmodule NASA.MissionTest do
  use ExUnit.Case
  alias NASA.{Mission, Planet}

  test "creates mission with valid steps" do
    steps = [{:launch, "earth"}, {:land, "moon"}]
    assert {:ok, %Mission{mass: 1000, steps: mission_steps}} = Mission.new(1000, steps)

    assert Enum.all?(mission_steps, fn
             {_action, %Planet{}} -> true
             _ -> false
           end)
  end

  test "fails on invalid action" do
    assert {:error, :invalid_step} = Mission.new(1000, [{:fly, "earth"}])
  end

  test "fails on unknown planet" do
    assert {:error, {:unknown_planet, "venus"}} = Mission.new(1000, [{:launch, "venus"}])
  end
end
