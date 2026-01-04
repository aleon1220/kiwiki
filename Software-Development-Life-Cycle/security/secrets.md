[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

## 1Pass CLI commands

#### set bash auto complete

```bash
source <(op completion bash)
```

#### sign in One Password

```bash
eval $(op signin --account my)
op signin
```

#### List vaults
```bash
op vault list
```

#### List Favorite items
```bash
op item list --favorite
```

#### List items given vault
```bash
op item list --vault my-vault
```
#### get one password my item 
```bash
op item get "my item"
```

#### read a password
```bash
op read "op://my-vault/Pluralsight Online Training/password"
```

#### read One-Time-Password
```bash
ONE_PASS_UUID="z1w2c3w4w5p6p7w8d9w10p11w12"
op item get $ONE_PASS_UUID --otp
```

#### pipe password to linux sudo
Using standard in
```bash
ONE_PASS_ITEM_ID="lutbhf3cx6qvng5qhktzoljh2q"
printf "$(op read "op://my-vault/$ONE_PASS_ITEM_ID/password")\n" | sudo --stdin apt update ; sudo apt upgrade --yes
```

#### Update 10 password Codes in created section
- To Already created items locate a section
- Add the Code01...Code10 as a Password
- Read from an environment variable
> Check escaping the characters if using `' '`

```bash
op item edit "GitLab" "2FA Recovery Codes.Code01[password]=$CODE01"
op item edit "GitLab" "2FA Recovery Codes.Code02[password]=$CODE02"
op item edit "GitLab" "2FA Recovery Codes.Code03[password]=$CODE03"
op item edit "GitLab" "2FA Recovery Codes.Code04[password]=$CODE04"
op item edit "GitLab" "2FA Recovery Codes.Code05[password]=$CODE05"
op item edit "GitLab" "2FA Recovery Codes.Code06[password]=$CODE06"
op item edit "GitLab" "2FA Recovery Codes.Code07[password]=$CODE07"
op item edit "GitLab" "2FA Recovery Codes.Code08[password]=$CODE08"
op item edit "GitLab" "2FA Recovery Codes.Code09[password]=$CODE09"
op item edit "GitLab" "2FA Recovery Codes.Code10[password]=$CODE10"
```

# References
- [1Pass Reference Docs](https://developer.1password.com/docs/cli/reference/management-commands/item)
