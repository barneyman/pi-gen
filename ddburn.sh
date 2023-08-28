#!/bin/sh
sudo dd if=$1 of=/dev/sdb of=/dev/sdb bs=4M conv=fsync status=progress
