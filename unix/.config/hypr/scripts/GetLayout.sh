#!/bin/bash
hyprctl getoption general:layout -j | jq -r '.str'
