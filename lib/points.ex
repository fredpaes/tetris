defmodule Tetris.Points do
  def translate(points, {x, y}) do
    Enum.map(points, fn {dx, dy} -> {dx + x, dy + y} end)
  end

  def transpose(points) do
    points
      |> Enum.map(fn {x, y} -> {y, x} end)
  end

  def mirror(points) do
    points
      |> Enum.map(fn {x, y} -> {(5 - x), y} end)
  end

  def flip(points) do
    points
      |> Enum.map(fn {x, y} -> {x, (5 - y)} end)
  end

  def rotate(points, degrees) do
    case degrees do
      0 -> points
      _ -> rotate(rotate_90(points), (degrees - 90))
    end
  end

  defp rotate_90(points) do
    points
      |> transpose
      |> mirror
  end
end