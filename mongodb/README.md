# MongoDB

aushacker<br/>
May 2024

## Replica Set Initialisation

```
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-0.mongodb:27017" },
    { _id: 1, host: "mongodb-1.mongodb:27017" },
    { _id: 2, host: "mongodb-2.mongodb:27017" }
  ]
})
```
## Useful Commands

On primary: <br/>
```
// mark a member as non-voting
cfg = rs.config()
cfg.members[2].priority = 0
cfg.members[2].votes = 0
rs.reconfig(cfg)
```

```
// add a member to the resplica set
rs.add( { "host": "mongodb-3.mongodb" } )
```

```
// remove a member from the replica set
rs.remove( "mongodb-3.mongodb" )
```
