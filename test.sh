#!/bin/bash

ipAddress=$(hostname -i)

ping ipAddress -s 64000 -i 0.1
