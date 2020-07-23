# https://juliatext.github.io/TextAnalysis.jl/latest/documents/#Preprocessing-Documents-1
using TextAnalysis

pathname = "Users/ujangfahmi/Desktop/UJANG FAHMI/julia/data/text/";
str = "To be or not to be...";
sd = StringDocument(str);

fd = FileDocument(pathname);
my_tokens = String["To", "be", "or", "not", "to", "be..."];

td = TokenDocument(my_tokens);

my_ngrams = Dict{String, Int}("To" => 1, "be" => 2,
                                    "or" => 1, "not" => 1,
                                    "to" => 1, "be..." => 1);

ngd = NGramDocument(my_ngrams)

# how to create bigram
bigram = NGramDocument("To be or not to be ...", 2)
println(NGramDocument("To be or not to be ...", 2))


sd = StringDocument("To be or not to be...")
td = TokenDocument("To be or not to be...")

Document("To be or not to be...")
Document("/usr/share/dict/words");


# PRE-PROCESSING
## remove punctuations
str = StringDocument("here are some punctuations !!!...")
prepare!(str, strip_punctuation)
text(str)

# to remove case distinction default to lowercase
sd = StringDocument("Lear the akun is mad on me")
remove_case!(sd)
text(sd)
# remove words
remove_words!(sd, ["lear", "is"])
text(sd)

# another strip function from TextAnalysis
#
prepare!(sd, strip_articles)
prepare!(sd, strip_indefinite_articles)
prepare!(sd, strip_definite_articles)
prepare!(sd, strip_preposition)
prepare!(sd, strip_pronouns)
prepare!(sd, strip_stopwords)
prepare!(sd, strip_numbers)
prepare!(sd, strip_non_letters)
prepare!(sd, strip_spares_terms)
prepare!(sd, strip_frequent_terms)
prepare!(sd, strip_html_tags)

prepare!(sd, strip_articles| strip_numbers| strip_html_tags)
text(sd)

# stemming
sd = StringDocument("They write, it writes")
stem!(sd)
text(sd)
