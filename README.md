### Install Mongodb with Debian

Allow Ip4 and allow IP6

Create Volume Storage :

```
fly volumes create productiondb_storage --size 1 --region sin
```

Activate IP6

```
fly ips allocate-v6 --private --app applikasinya
```

IP4

```
fly ips allocate-v4 --app applikasinya
```
