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

  def mirror(points, bool) do
    case bool do
      true -> points
      false -> mirror(points)
    end
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

  def with_color(points, color) do
    Enum.map(points, fn point -> add_color(point, color) end)
  end

  defp add_color(point, color) do
    case point do
      {_x, _y, _z} -> point
      {x, y} -> {x, y, color}
    end
  end

  def to_string(points) do
    map = points
      |> Enum.map(fn key -> {key, "■"} end)
      |> Map.new

    for y <- (1..4), x <- (1..4) do
      Map.get(map, {x, y}, "□")
    end
      |> Enum.chunk_every(4)
      |> Enum.map(&(Enum.join/1))
      |> Enum.join("\n")
  end

  def print(points) do
    IO.puts(__MODULE__.to_string(points))
    points
  end

end