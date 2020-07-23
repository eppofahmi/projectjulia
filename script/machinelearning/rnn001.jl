using Flux
import StatsBase: wsample

nunroll = 50
nbatch = 50

getseqs(chars, alphabet) = sequences((onehot(Float32, char, alphabet) for char in chars), nunroll);
getbatches(chars, alphabet) =  batches((getseqs(part, alphabet) for part in chunk(chars, nbatch))...);

input = read("shkspr.txt")
#println(input)
alphabet = unique(input);
N = length(alphabet);

# An iterator of (input, output) pairs
train = zip(getbatches(input, alphabet), getbatches(input[2:end], alphabet));
# We will evaluate the loss on a particular batch to monitor the training.
eval = tobatch.(first(drop(train, 5)))
