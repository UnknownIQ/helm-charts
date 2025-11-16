#!/bin/bash

for chart in homepage; do
  helm dependency update ./$chart
done
