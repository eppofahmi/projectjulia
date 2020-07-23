# analisis teks menggunakan julia
# install packaged
# using Pkg
# Pkg.add("TextAnalysis")

# menggunakan package
using TextAnalysis
# Catatan: pada saat memanggil package pertama kali akan memakan waktu yang lama
# karena perlu mengcompile package terlebih dahulu

model = SentimentAnalyzer()

s = StringDocument("Assume this Short Document as an example. Assume this as an example summarizer. This has too foo sentences.")
summarize(s, ns=2)

# Pkg.add("Flux") #ML Juli Framework
using Flux
ner = NERTagger()

crps = Corpus([StringDocument("To be or not to be"),
              StringDocument("To become or not to become")])
update_lexicon!(crps)
m = DocumentTermMatrix(crps)
tf(m)

tf_idf(m)

model = SentimentAnalyzer()
model(crps)
model(doc, handle_unknown)


tagger = PerceptronTagger(false)
tagger = PerceptronTagger(true)
