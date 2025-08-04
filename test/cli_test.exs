defmodule NASA.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias NASA.CLI

  @tag :cli
  test "prints total fuel for Apollo 11 mission" do
    args = ["28801", "launch:earth", "land:moon", "launch:moon", "land:earth"]

    output =
      capture_io(fn ->
        CLI.main(args)
      end)

    assert output =~ "Total fuel needed: 51898"
  end

  @tag :cli
  test "prints total fuel for Mars mission" do
    args = ["14606", "launch:earth", "land:mars", "launch:mars", "land:earth"]

    output =
      capture_io(fn ->
        CLI.main(args)
      end)

    assert output =~ "Total fuel needed: 33388"
  end

  @tag :cli
  test "prints total fuel for long mission with Moon and Mars" do
    args = [
      "75432",
      "launch:earth",
      "land:moon",
      "launch:moon",
      "land:mars",
      "launch:mars",
      "land:earth"
    ]

    output =
      capture_io(fn ->
        CLI.main(args)
      end)

    assert output =~ "Total fuel needed: 212161"
  end

  @tag :cli
  test "prints error on unknown planet" do
    args = ["12345", "launch:venus"]

    output =
      capture_io(fn ->
        CLI.main(args)
      end)

    assert output =~ "Unknown planet: venus"
  end

  @tag :cli
  test "prints usage on invalid input" do
    output =
      capture_io(fn ->
        CLI.main(["not_a_number", "launch:earth"])
      end)

    assert output =~ "Invalid input. Usage:"
  end
end
