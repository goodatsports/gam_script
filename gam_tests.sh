#!/usr/bin/bash

OUTPUT= "$(gam info user ${1})"

echo "${OUTPUT}"