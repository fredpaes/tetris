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

    assert {2, 3} not in points_brick
  end

  test "should translate a list of points" do
    actual_points = new_brick()
      |> shape
      |> translate({1, 1})
      |> translate({0, 1})

    assert actual_points == [{3, 3}, {3, 4}, {3, 5}, {3, 6}]
  end

  test "should flip rotate flip and mirror" do
    [{1, 1}]
      |> mirror
      |> assert_point({4, 1})
      |> flip
      |> assert_point({4, 4})
      |> rotate(90)
      |> assert_point({1, 4})
      |> rotate(90)
      |> assert_point({1, 1})
  end

  test "should convert brick to string" do
    actual = new_brick() |> Tetris.Brick.to_string
    expected = "□□■□\n□□■□\n□□■□\n□□■□"

    assert actual == expected
  end

  test "should inspect brick" do
    actual = new_brick() |> inspect
    expected = 
      """
      □□■□
      □□■□
      □□■□
      □□■□
       name: :i
       location: {40, 0}
       rotation: 0
       reflection: false
      """

    assert "#{actual}\n" == expected
  end

  # method to create a randow brick
  def new_brick(attributes \\ []), do: new(attributes)

  def assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end
end
