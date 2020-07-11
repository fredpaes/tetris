defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick
  import Tetris.Points

  test "Creates a new brick" do
    assert new_brick.name() == :i
  end

  test "Creates a new random brick" do
    actual = new_random()

    assert actual.name in [:i, :l, :z, :t, :o]
    assert actual.rotation in [0, 90, 180, 270]
    assert actual.reflection in [true, false]
  end

  test "Should manipulate brick" do
    actual = new_brick()
      |> left
      |> right
      |> right
      |> down
      |> spin
      |> spin

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end

  test "Should return points for z shape" do
    points_brick = new_brick(name: :z)
      |> shape

    assert {3, 3} not in points_brick
  end

  test "should translate a list of points" do
    actual_points = new_brick()
      |> shape
      |> translate({1, 1})
      |> translate({0, 1})

    assert actual_points !== []
  end

  # method to create a randow brick
  def new_brick(attributes \\ []), do: new(attributes)
end
