#!/usr/bin/env bash

echo "Part one:"
cobc -xO part-one.cbl && ./part-one

echo "Part two:"
cobc -xO part-two.cbl && ./part-two
