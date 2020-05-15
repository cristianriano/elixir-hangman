
# Get all numbers that x^2 + y^2 = z^2
:timer.tc(fn ->
  for x <- 1..100, y <- (x+1)..100, z <- (y+1)..100, x*x + y*y == z*z, x+y>z, do: [x, y, z]
end) |> IO.inspect
