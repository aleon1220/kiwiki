#!/bin/bash

function opFunctionOnePassword() {
  printf "======= TODO Recheck the openSSL command. openssl new version issues \n"
  OnePASS=$(openssl rsautl -decrypt -inkey ~/.ssh/private_key.pem -in ~/.hidden_dir/dataFile.dat.enc)
  opFunctionLogInfo "decrypted encoded text file with private key"
  # switch to pkeyutl as suggested by bash in ubuntu22
  opFunctionLogInfo "WSL Clipboard enabled!"
}

function opFunctionGetPassUnsafe(){
  cat ~/.ssh/op
}

function opFunctionGetSecretAdminWSL(){
  opFunctionOnePasswordLogin
  export ADMIN_SECRET=$(op read "op://uqbpxejq7gifvi6mg3c7xxokre/6vu5piejmjehnwktfotomtf7ca/password")
  op://uqbpxejq7gifvi6mg3c7xxokre/6vu5piejmjehnwktfotomtf7ca/
  opFunctionLogInfo "Retrieved Admin WSL password from 1Password"
}

function opFunctionOnePasswordLogin(){
  printf "======= Login to opFunctionOnePasswordLogin via WSL CLI \n"
  ONE_PASS=$(opFunctionGetPassUnsafe)
  printf "$ONE_PASS" | clip.exe
  eval $(op signin --account my)
  printf "======= opFunctionOnePassword() fetched password & Logged In successfully \n"
}