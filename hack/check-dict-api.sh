#!/usr/bin/env bash

exit_code=0
for word in $(git diff -U0 "origin/${GITHUB_BASE_REF}" -- enable1.txt | grep -E '^\+\w+' | grep -oE '\w+'); do
    echo "Checking word: ${word}"
    curl -s --fail -o /dev/null "https://api.dictionaryapi.dev/api/v2/entries/en/${word}" || (echo -e "Word not found\n"; false) && echo -e "Word found\n"
    exit_code=$((exit_code + $?))
done

exit $exit_code
