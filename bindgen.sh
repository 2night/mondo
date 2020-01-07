#!/bin/bash
pushd mongo-c-driver
cd build
cmake ..
make -j 8
popd
d++ --preprocess-only --include-path ./mongo-c-driver/build/src/libbson/src --include-path ./mongo-c-driver/src/libbson/src/ --keep-d-files source/bsonc.dpp

d++ --preprocess-only --include-path ./mongo-c-driver/build/src/libmongoc/src --include-path ./mongo-c-driver/src/libmongoc/src --include-path ./mongo-c-driver/src/libmongoc/src/mongoc --include-path ./mongo-c-driver/build/src/libbson/src --include-path ./mongo-c-driver/src/libbson/src --keep-d-files source/mongoc.dpp
