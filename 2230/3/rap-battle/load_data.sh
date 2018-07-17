#!/bin/bash
cd data
rm -r *
wget shizuku-san.narod.ru/rap-battles.zip
unzip rap-battles.zip
rm rap-battles.zip
rm -r __MACOSX
