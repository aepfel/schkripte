#!/bin/bash
free -h | grep - | awk '{print $4}'
