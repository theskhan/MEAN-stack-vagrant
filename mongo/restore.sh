#!/bin/bash
cp -R -f "/vagrant/mongo/data/mongodb" "/var/lib"
service mongod restart