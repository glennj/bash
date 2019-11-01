#!/usr/bin/env bash

ComplexNumber::format() {
    printf "%si%s" "$@"
}

ComplexNumber::real() {
    local a b
    IFS="i" read -r a b <<< "$1"
    echo "$a"
}

ComplexNumber::imaginary() {
    local a b
    IFS="i" read -r a b <<< "$1"
    echo "$b"
}

ComplexNumber::add() {
    local a b c d
    IFS="i" read -r a b <<< "$1"
    IFS="i" read -r c d <<< "$2"
    awk -v OFS=i -v a=$a -v b=$b -v c=$c -v d=$d 'BEGIN {
        print a + c, b + d
    }'
}

ComplexNumber::sub() {
    local a b c d
    IFS="i" read -r a b <<< "$1"
    IFS="i" read -r c d <<< "$2"
    awk -v OFS=i -v a=$a -v b=$b -v c=$c -v d=$d 'BEGIN {
        print a - c, b - d
    }'
}

ComplexNumber::mul() {
    local a b c d
    IFS="i" read -r a b <<< "$1"
    IFS="i" read -r c d <<< "$2"
    awk -v OFS=i -v a=$a -v b=$b -v c=$c -v d=$d 'BEGIN {
        print a*c - b*d, b*c + a*d
    }'
}

ComplexNumber::div() {
    local a b c d
    IFS="i" read -r a b <<< "$1"
    IFS="i" read -r c d <<< "$2"
    awk -v OFS=i -v a=$a -v b=$b -v c=$c -v d=$d 'BEGIN {
        div = c*c + d*d
        print (a*c + b*d)/div, (b*c - a*d)/div
    }'
}

ComplexNumber::abs() {
    local a b
    IFS="i" read -r a b <<< "$1"
    awk -v OFS=i -v a=$a -v b=$b 'BEGIN {
        print sqrt(a*a + b*b)
    }'
}

ComplexNumber::conjugate() {
    local a b
    IFS="i" read -r a b <<< "$1"
    awk -v OFS=i -v a=$a -v b=$b 'BEGIN {
        print a, -1*b
    }'
}

ComplexNumber::exp() {
    local a b
    IFS="i" read -r a b <<< "$1"
    awk -v OFS=i -v a=$a -v b=$b '
        function trunc(n,     a) { 
            a = sprintf("%.6f", n)
            sub(/[1-9]$/, "", a)
            sub(/0+$/, "", a)
            sub(/\.$/, "", a)
            return a
        }
        BEGIN {
            ea = exp(1) ^ a
            print trunc(ea * cos(b)), trunc(ea * sin(b))
        }
    '
}
