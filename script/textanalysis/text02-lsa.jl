using TextAnalysis

crps = Corpus([StringDocument("Document 1"),
                      StringDocument("Document 2")]);

crps = Corpus([StringDocument("Document 1"),
                TokenDocument("Document 2"),
                NGramDocument("Document 3")]);


crps = Corpus([StringDocument("Name Foo"), StringDocument("Name Bar")]);
lexicon(crps);

update_lexicon!(crps)
lexicon(crps);

lexical_frequency(crps, "Name")
lexical_frequency(crps, "Foo")
lexical_frequency(crps, "Bar")

# Converting a DataFrame from a Corpus
convert(DataFrame, crps);

crps = Corpus([StringDocument("To be or not to be"),
                             StringDocument("To become or not to become")])

update_lexicon!(crps)
m = DocumentTermMatrix(crps)

dtm(m)
dtm(m, :dense)
dtv(crps[1], lexicon(crps))

# LDA
crps = Corpus([StringDocument("This is the Foo Bar Document"), StringDocument("This document has too Foo words")])
update_lexicon!(crps)
m = DocumentTermMatrix(crps)

k = 2            # number of topics
iterations = 1000
α = 0.1
β  = 0.1

ϕ, θ  = lda(m, k, iterations, α, β)
