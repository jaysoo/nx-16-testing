#!/bin/sh
export $(cat .env | xargs)
rm -rf $TMP
