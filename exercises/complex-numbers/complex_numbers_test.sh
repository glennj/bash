#!/usr/bin/env bash

# local version: 1.3.0.0

# We will be representing a complex number as the string
# "[real]i[imaginary]", for example "0i0" or "12i-23"
# This is straightforward to parse with bash:
#     IFS="i" read -r real imag <<<"$complex"

source complex_numbers.sh

@test "Real part of a purely real number" {
    #skip
    run ComplexNumber::real "1i0"
    [[ $status -eq 0 ]]
    [[ $output == "1" ]]
}

@test "Real part of a purely imaginary number" {
    #skip
    run ComplexNumber::real "0i1"
    [[ $status -eq 0 ]]
    [[ $output == "0" ]]
}

@test "Real part of a number with real and imaginary part" {
    #skip
    run ComplexNumber::real "1i2"
    [[ $status -eq 0 ]]
    [[ $output == "1" ]]
}

@test "Imaginary part of a purely real number" {
    #skip
    run ComplexNumber::imaginary "1i0"
    [[ $status -eq 0 ]]
    [[ $output == "0" ]]
}

@test "Imaginary part of a purely imaginary number" {
    #skip
    run ComplexNumber::imaginary "0i1"
    [[ $status -eq 0 ]]
    [[ $output == "1" ]]
}

@test "Imaginary part of a number with real and imaginary part" {
    #skip
    run ComplexNumber::imaginary "1i2"
    [[ $status -eq 0 ]]
    [[ $output == "2" ]]
}

@test "Imaginary unit" {
    #skip
    run ComplexNumber::mul 0i1 0i1
    [[ $status -eq 0 ]]
    [[ $output == "-1i0" ]]
}

@test "Add purely real numbers" {
    #skip
    run ComplexNumber::add 1i0 2i0
    [[ $status -eq 0 ]]
    [[ $output == "3i0" ]]
}

@test "Add purely imaginary numbers" {
    #skip
    run ComplexNumber::add 0i1 0i2
    [[ $status -eq 0 ]]
    [[ $output == "0i3" ]]
}

@test "Add numbers with real and imaginary part" {
    #skip
    run ComplexNumber::add 1i2 3i4
    [[ $status -eq 0 ]]
    [[ $output == "4i6" ]]
}

@test "Subtract purely real numbers" {
    #skip
    run ComplexNumber::sub 1i0 2i0
    [[ $status -eq 0 ]]
    [[ $output == "-1i0" ]]
}

@test "Subtract purely imaginary numbers" {
    #skip
    run ComplexNumber::sub 0i1 0i2
    [[ $status -eq 0 ]]
    [[ $output == "0i-1" ]]
}

@test "Subtract numbers with real and imaginary part" {
    #skip
    run ComplexNumber::sub 1i2 3i4
    [[ $status -eq 0 ]]
    [[ $output == "-2i-2" ]]
}

@test "Multiply purely real numbers" {
    #skip
    run ComplexNumber::mul 1i0 2i0
    [[ $status -eq 0 ]]
    [[ $output == "2i0" ]]
}

@test "Multiply purely imaginary numbers" {
    run ComplexNumber::mul 0i1 0i2
    [[ $status -eq 0 ]]
    [[ $output == "-2i0" ]]
}


@test "Multiply numbers with real and imaginary part" {
    run ComplexNumber::mul 1i2 3i4
    [[ $status -eq 0 ]]
    [[ $output == "-5i10" ]]
}

@test "Divide purely real numbers" {
    run ComplexNumber::div 1i0 2i0
    [[ $status -eq 0 ]]
    [[ $output == "0.5i0" ]]
}

@test "Divide purely imaginary numbers" {
    run ComplexNumber::div 0i1 0i2
    [[ $status -eq 0 ]]
    [[ $output == "0.5i0" ]]
}

@test "Divide numbers with real and imaginary part" {
    run ComplexNumber::div 1i2 3i4
    [[ $status -eq 0 ]]
    [[ $output == "0.44i0.08" ]]
}
# @q
# Djcf:@test$s {wc3f"    run ComplexNumber::f"DJDJdf:f[xf,2sif]DJdf:f[xf,2sif]xo[[ $status -eq 0 ]]jddcf:    [[ $output == lcf["f,2sif]s" ]]}jdd:wk

# @w
# Djcf:@test$s {wc3f"    run ComplexNumber::f"DJDJdf:f[xf,2sif]xo[[ $status -eq 0 ]]jddcf:    [[ $output == A ]]}jdd:wk


@test "Absolute value of a positive purely real number" {
    run ComplexNumber::abs 5i0
    [[ $status -eq 0 ]]
    [[ $output ==  5 ]]
}

@test "Absolute value of a negative purely real number" {
    run ComplexNumber::abs -5i0
    [[ $status -eq 0 ]]
    [[ $output == "5" ]]
}

@test "Absolute value of a purely imaginary number with positive imaginary part" {
    run ComplexNumber::abs 0i5
    [[ $status -eq 0 ]]
    [[ $output == "5" ]]
}

@test "Absolute value of a purely imaginary number with negative imaginary part" {
    run ComplexNumber::abs 0i-5
    [[ $status -eq 0 ]]
    [[ $output == "5" ]]
}

@test "Absolute value of a number with real and imaginary part" {
    run ComplexNumber::abs 3i4
    [[ $status -eq 0 ]]
    [[ $output == "5" ]]
}

@test "Conjugate a purely real number" {
    run ComplexNumber::conjugate 5i0
    [[ $status -eq 0 ]]
    [[ $output == "5i0" ]]
}

@test "Conjugate a purely imaginary number" {
    run ComplexNumber::conjugate 0i5
    [[ $status -eq 0 ]]
    [[ $output == "0i-5" ]]
}
@test "Conjugate a number with real and imaginary part" {
    run ComplexNumber::conjugate 1i1
    [[ $status -eq 0 ]]
    [[ $output == "1i-1" ]]
}

@test "Euler's identity/formula" {
    pi=$(awk 'BEGIN {print 2*atan2(1,0)}')
    run ComplexNumber::exp "0i${pi}"
    [[ $status -eq 0 ]]
    [[ $output == "-1i0" ]]
}

@test "Exponential of 0" {
    run ComplexNumber::exp 0i0
    [[ $status -eq 0 ]]
    [[ $output == "1i0" ]]
}

@test "Exponential of a purely real number" {
    e=$(awk 'BEGIN {print exp(1)}')
    run ComplexNumber::exp 1i0
    [[ $status -eq 0 ]]
    [[ $output == "${e}i0" ]]
}

@test "Exponential of a number with real and imaginary part" {
    l2=$(awk 'BEGIN {print log(2)}')
    pi=$(awk 'BEGIN {print 2*atan2(1,0)}')
    run ComplexNumber::exp "${l2}i${pi}"
    [[ $status -eq 0 ]]
    [[ $output == "-2i0" ]]
}
