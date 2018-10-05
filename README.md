
# 概要
packer+ansibleでGCP上にMinecraft Server(Forge)のイメージを構築します。  
ansibleの実行確認のためVirtualBoxのイメージも構築できるようにしてあります。  

実行すると,自動的にMinecraft Eulaに同意しますのでご注意ください。

# 設定方法
後述の設定内容を参考にファイルを作成する必要があります。  
GCPのイメージを作成する際は追加でアカウントファイルが必要です。  
ここを参考にして設定してください。  
https://www.packer.io/docs/builders/googlecompute.html

# 注意
バージョンなどべた書きの部分もあるので使用する際は注意が必要です。

# VirtualBox(local))
## pakcer 設定
``` 
(secret/vm-conf.json)
{
    "gateway": {ゲートウェイ},
    "user_name": {ssh用ユーザ名},
    "user_pass": {ssh用ユーザパスワード},
    "vm_cpus": {割当core数},
    "vm_hostonly_if": {ホストオンリーアダプター名}},
    "vm_memory": {割当メモリ}
}
```
## ansible 設定
``` 
(ansible/vars/virtualbox.yml)
ansible_ssh_host: 127.0.0.1
ansible_ssh_port: 2222
ansible_ssh_user: {sshユーザ名}
ansible_ssh_pass: {ssh用ユーザパスワード}
ansible_sudo_pass: {ssh用ユーザパスワード}
host_name: {ホストネーム}
gateway: {ゲートウェイ}
```


# GCP
## packer 設定
``` 
(secret/gcp-conf.json)
{
    "gce_zone_name": {リージョン},
    "source_image_name": ubuntu-1804-bionic-v20180911,
    "gce_network_name": {ネットワーク名},
    "google_account_file": {api操作用のjsonファイルパス},
    "google_project_id": {プロジェクトID},
    "machine_type": {インスタンスタイプ},
    "ssh_username": {sshユーザ名}
}

```
## ansible 設定
``` 
(ansible/vars/gcp.yml)
host_name: {ホストネーム}
bucket_name: {バックアップするバケット名　※バケットは作成しておくこと}
```

# Minecraft 設定
```
(ansible/vars/minecraft.yml)
minecraft_version: "1.12.2"
minecraft_user_pass: {minecraftユーザ用パスワード}
minecraft_initial_memory: {minecraft起動時の初期メモリ}
minecraft_max_memory: {minecraft起動時の最大メモリ}

minecraft_mods:
  - {minecraft modファイルのURL}
```
# 使い方

## virtualboxイメージの作成
```
$ make build-vm
```

## GCPイメージの作成
```
$ make build-gcp
```