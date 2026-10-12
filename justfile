# Compile the English paper (default recipe).
all:
    typst compile main.typ main.pdf

# Recompile automatically when sources change.
watch:
    typst watch main.typ main.pdf

# Remove the generated PDF.
clean:
    rm -f main.pdf
