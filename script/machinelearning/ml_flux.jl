using Flux
#f(x) = 3x^2 + 2x + 1;
#df(x) = gradient(f, x)[1];
#d2f(x) = gradient(df, x)[1];
#f(x, y) = sum((x .- y).^2);

W = rand(2, 5)
b = rand(2)
predict(x) = W*x .+ b

function loss(x, y)
  ŷ = predict(x)
  sum((y .- ŷ).^2)
end

x, y = rand(5), rand(2) # Dummy data
loss(x, y) # ~ 3


gs = gradient(() -> loss(x, y), params(W, b))
