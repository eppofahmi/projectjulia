using Flux
import StatsBase: wsample

nunroll = 50
nbatch = 50

getseqs(chars, alphabet) =
  sequences((onehot(Float32, char, alphabet) for char in chars), nunroll)
getbatches(chars, alphabet) =
  batches((getseqs(part, alphabet) for part in chunk(chars, nbatch))...)

  
