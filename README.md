# IsochronDB

Distributed database using WAL for asynchronous replication. The educational project is inspired by Apache Cassandra and similar distributed database systems.

## Overview

### Transaction

### Storage

### Replication/Migration

CAP: since the goal is to deploy this system across multiple data centers around the world, we will prioritize availability and partition tolerance (AP) over consistency. Therefore, we will perform replication and propagation asynchronously. Unfortunately, this also means that the storage provides a weaker guarantee in terms of whether a write is successful or not.

In this case, LWW with logical clocks is a suitable choice for our system. Lamport's logical clocks are used to ensure causal consistency. They provide a way to order events in the distributed system with tie-breaking mechanism for concurrent events. Last-write-wins (LWW) is used for conflict resolution, meaning that in the case of concurrent writes to the same data, the write with the latest timestamp will be considered the winner and will be applied to the database. They draw on Lamport timestamps to avoid problems with clock skew.

IsochronDB also uses a write-ahead log (WAL) for background replication and fault tolerance. When a write operation is performed, it is first written to the WAL, which is then asynchronously replicated to other nodes in the cluster. This allows for high availability and fault tolerance, as the data can be recovered from the WAL in case of node failures.


## TODO

- Context propagation to enable early termination
- Load shedding to protect the server from being overloaded
- Request latency monitoring


## Reference

- [CRDT Survey, Part 2](https://mattweidner.com/2023/09/26/crdt-survey-2.html#last-writer-wins-lww)
- [CRDT Survey, Part 3](https://mattweidner.com/2023/09/26/crdt-survey-3.html#lww-lamport-timestamps)

