# Compile the English paper (default recipe).
all:
    typst compile main.typ main.pdf

# Compile the Chinese paper.
cn:
    typst compile main-cn.typ main-cn.pdf

# Compile both versions.
both: all cn

# Recompile automatically when sources change.
watch:
    typst watch main.typ main.pdf

# Watch the Chinese paper.
watch-cn:
    typst watch main-cn.typ main-cn.pdf

# Remove the generated PDF.
clean:
    rm -f main.pdf main-cn.pdf
