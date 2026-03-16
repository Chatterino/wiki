from pygments.lexer import RegexLexer
from pygments.token import (
    Number,
    String,
    Operator,
    Punctuation,
    Whitespace,
    Keyword,
)


class FilterLexer(RegexLexer):
    name = "Chatterino Filter Lexer"
    aliases = ["c2-filter"]
    filenames = ["*.c2filter"]
    mimetypes = ["text/x-c2-filter"]

    tokens = {
        "root": [
            (r"(r|ri)\"", String.Regex, "regex"),
            (r"\"", String, "string"),
            (r"<=?|>=?|!=?|==|\|\||&&|\+|-|\*|\/|%", Operator),
            (r"(contains|startswith|endswith|match)\b", Operator.Word),
            (r"\d+", Number),
            (r"[\w\\.]+", Keyword),
            (r"{|}|\(|\)|\[|\]|,", Punctuation),
            (r"\s+", Whitespace),
        ],
        "regex": [
            (r"\\\"", String.Escape),
            (r"\\", String.Regex),
            (r'"', String.Regex, "#pop"),
            (r'[^\\"]+', String.Regex),
        ],
        "string": [
            (r"\\\"", String.Escape),
            (r"\\", String),
            (r'"', String, "#pop"),
            (r'[^\\"]+', String),
        ],
    }
