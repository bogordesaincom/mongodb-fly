[Mongodb Docker Compass](/images/mongodbcompass.png)

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

### Login in to SSH For Secure Mongodb Access

```
fly ssh console --app applikasinya
```

Create User and Password in `admin` db

Change `userlogin` and `changemepassword`

```
mongosh

test > use admin

admin > db.createUser({ user: "userlogin", pwd: "changemepassword", roles: [{ role: "userAdminAnyDatabase", db: "admin"}, "readWriteAnyDatabase" ]})

```

Change Docker file

```
RUN sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf
```

Change to

```
COPY mongod.conf /etc/mongod.conf
```

Deploy Again to Fly.io

```
fly deploy --config=fly.toml --no-cache
```

### Example Login using mongodb Compass :

```
mongodb://userlogin:changemepassword@applikasinya.fly.dev:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.6.1
```
