#!/bin/bash

ipAddress=$(hostname -I)

ping ipAddress -s 64000 -i 0.1
