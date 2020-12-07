#!/bin/bash

rm -f Elixir.AdventOfCode.*
elixirc lib
mix run -e "Elixir.AdventOfCode.day_output($1)"