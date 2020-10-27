#!/usr/bin/env bash

# local version: 2.0.0.0
# encode
verbose_test_info() {
  if [[ $BATS_VERBOSE ]] && { (( status != expected[1] )) || [[ $output != "${expected[0]}" ]]; }; then
    {
      printf 'test %d: %s\n' "$BATS_TEST_NUMBER" "$BATS_TEST_DESCRIPTION"
      printf 'status: %d (expected: %d)\n' "$status" "$expected[1]"
      printf 'expected: "%s"\n' "${expected[0]}"
      printf 'actual: "%s"\n' "$output"
    } | sed 's/^/# /' >&3
  fi
}

@test "encode yes" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 5 7 "yes"
  expected=( "xbt" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode no" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 15 18 "no"
  expected=( "fu" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode OMG" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 21 3 "OMG"
  expected=( "lvz" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode O M G" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 25 47 "O M G"
  expected=( "hjp" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode mindblowingly" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 11 15 "mindblowingly"
  expected=( "rzcwa gnxzc dgt" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 3 4 "Testing,1 2 3, testing."
  expected=( "jqgjc rw123 jqgjc rw" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode deep thought" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 5 17 "Truth is fiction."
  expected=( "iynia fdqfb ifje" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode all the letters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 17 33 "The quick brown fox jumps over the lazy dog."
  expected=( "swxtj npvyk lruol iejdc blaxk swxmh qzglf" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "encode with a not coprime to m" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh encode 6 17 "This is a test."
  expected=( "a and m must be coprime." 1 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

# decode

 @test "decode exercism" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 3 7 "tytgn fjr"
  expected=( "exercism" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode a sentence" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 19 16 "qdwju nqcro muwhn odqun oppmd aunwd o"
  expected=( "anobstacleisoftenasteppingstone" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 25 7 "odpoz ub123 odpoz ub"
  expected=( "testing123testing" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode all the letters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 17 33 "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
  expected=( "thequickbrownfoxjumpsoverthelazydog" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode with no spaces in input" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 17 33 "swxtjnpvyklruoliejdcblaxkswxmhqzglf"
  expected=( "thequickbrownfoxjumpsoverthelazydog" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode with too many spaces" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 15 16 "vszzm    cly   yd cg    qdp"
  expected=( "jollygreengiant" 0 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}

 @test "decode with a not coprime to m" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash affine_cipher.sh decode 13 5 "Test"
  expected=( "a and m must be coprime." 1 )
  verbose_test_info
  (( status == expected[1] ))
  [[ $output == "${expected[0]}" ]]
}
