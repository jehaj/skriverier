#!/bin/bash

VERSION="v0.16.27"

curl -L "https://github.com/KaTeX/KaTeX/releases/download/${VERSION}/katex.tar.gz" | tar xz

mkdir -p assets/css static/fonts
mv katex/katex.min.css assets/css/
mv katex/fonts/* static/fonts/
rm -rf katex

# Ret stier til skrifttyper i CSS-filen
sed -i 's/url(fonts\//url(..\/fonts\//g' assets/css/katex.min.css
