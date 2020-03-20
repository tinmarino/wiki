# Youtube Gaurav Sen


- Messenging tools

## Interview tips

* Front to back approach: what user want -> how to configure servers
* Each time you have a collection, think you should get a max number of items, size

1. Think about the features you want, 4 feature is enought for 1h interview
  1. Store profile
    1. Id
    2. Score (good client ?)
    3. Surname
    4. Images (Give a max bound), Avatar
  2. Recommend matches (Tinder)
  3. Notes maches, analytices
  4. Direct messaging (chat)
  5. Group messages (Wts)
  6. Sent / Delivered / Read notification (Wts)

* Preparing beforehand at non peek hours
  1. Identificate the hours
  2. Cron jobs

### 5 tips video

1. Do not detail early (top-bottom) => speak alone
2. Don't get a full architecture at once, wait for the scenario to evolve. Avoid silver bullet, golden harmer
3. Keep It Simple Stupid. Every block should be the same size
4. Justify each choice. Form your thought
5. Be tech aware (Name load balancer, database host)

Be
1. Clear
2. Flexible
3. Knowledge

## Voc

* Vertical scaling: buy a bigger machine
* Horizontal scaling: buy more machines
* Scalable: With horizontal, increase number of user
* Consistent: the cache is consistent, the data if one server fails
* Resilient: power failure, os crash
* Fault tolerant
* Resilient to changes
* Extendable
* Single point of failure: if one system fails, cannot be replaced
* Microservice: A specialized program (cook empanadas) so each time a client ask for empanada, he can directly ask there
* Decoupling, separate responsabilities: tje cook does no need to know if it is the.client a a delivery agent coming to get the empanada
* Consisten hashing, used by load balancers to responsibilise a server on a (discontinous) range of request IDs
  * Ensure there is no duplicayes
* Notifier: Check heartbeat for each server (each 10sec) and if one is dead, notify
* Database Sharding: Divide the data in different machines according to the mist relevant index => first find the most relvant index (goelic, age, tag). Also known as horizontal partitioning.
* Client Server Communication Protocol: (ex: HTTP) The client requedt, the server respond. Pb: if slow operation, the client must request every 5s, generate noise
* Peer to Peer: (ex: XMPP) Every actor is equal, WebSocket (C TCP)
* Long pooling: repitively send HTTP request for user to check if there is a change in server (i.e. if he received a message)
* Service discovery: each service.must authentificate (name, ip, port) to the load balancer
* Health check, a 2 way heart beat to ensure a service is performing well his job, and kill it otherwise. Availability, economy of forces.


## API

www.site.com/chat-messeging/getAdmins/v1
get m with gid=123 json in the request
you can replace the get in the route because the HTTP request is get

For big response:
1. Pagination gives the responsibility to the client of repetitive calls
2. Fragmentation

## Databases

* Blob: Binary large object stored in databaese have 3 avantages over files
* You must shard your database according to the query. Some frameworks do it automamatically (Casandra, Dynamo)

* Blob
  1. Mutability: can change cells := item attributes
  2. Transaction safety: atomic operation safe
  3. Indexablility
  4. Access control: possible with files too

* Files (No select *)
  1. Cheap
  2. Faster
  3. Content Delivery Network: Distributed File System : each file is referenced by an url

* Cache:
  1. Save networkk call
  2. Avoid repeated computation
  3. Reduce Db load

* Cache policies:
  1. Least Recently Used (queue)
  2. Least Frecuently Used

* Redis is a global cache, slower but more accurate than in memory cache. Easyer to scale

* Write though cache, first write cache then db
* Write-back cache, first db then write cache

#### Master slave

Master write and propagte, read inconsitent only on slave. Like facbook where more read tha write

#### Distributed consensus

Multiple node agree for the final state. Odd number of nodes is better for votes

* Consistency, use 3 databases in a triangular (Split-Brain). Because db can crash and network too.
* Transaction: Only when transaction as been approved by all nodes, we may commit them -> consistent state committed, inconsistent transaction looking back and foward to propagate before writing
* MVCC: protocol to get consistent read (heavy)
* SAGA: very long transaction able to roll back in case of failure


### Not Only SQL

Advantages are like json Vs comma separated values. Dynamic Vs Static. Array Vs List

SQL is said to be a relational Db.

* Faster to read a full row (SELECT *) : all data is in one block
* Scheme easily changeable: easy to add a col
* Better scalable
* Faster metric, analytics (average salary)
* Bad for coherence ACID not garantee
* - Slower read time (for a column)
* - Relations are not implicits
* - Joins are hard

## Monolith Vs microservices

* Advantages
  * Less architecture
  * Less moving parts
  * Deployement, set up, test
  * Faster, no RPC (if 2 micro services speak a lot, join them)

* Drawbacks
  * Integration of new team memeber, must be in context
  * Deployelement must be more frequent
  * Test complicates
  * Single point of failuer
  * More difficult to scale, more difficult monitoring, maybe the chat part limits, maybe the analytics
  * More dificult to work in parrallel code in different files, machines, less dependencies

* StackOverflow is a monolith

#### Publisher / Subscriber model

Pb: Request / Response has a stron coupling, client machine must wait a may timeout: failure latency.

Publisher / Subscriber model: there is a message broker between asker and responder that take the responsability to wait

Warning, no atomicity, poor consistency

Twitter is the perfect example: one publisher, many subscribers

#### Event driven (micro)services

The calling service is publishing events when he feels someone may need it. In a Request / Response services, he ask directly someone to do a job.

Avantages
1. Availability (! This always means inconsistency)
2. Easy Roll Back (Undo possible)
3. Replacement (due to easy rool back)
4. Transaction guarantee (can be send max or min 1 email)
5. Store intent

Drawbacks
1. Inconsistency
2. Gateway must store all responses
3. Lesser control from master -> dificult to trace data flow for devs

* The publisher is sending an event to the event bus or message broker and who is interested can read from the event bus
* Good in video games to get a consistent timeline of game: where was player2 when player1 shot, no when server received both info


## Evernote

Mobile is the way in for new users.

### Keywords

* __WebDav:__ file server
* __PubSub:__ message queue for Publisher Subscriber
* __GCS:__ Google Cloud Storage
* __RAID:__ Redundant Array of Inexpensive Disks
* __MySql:__ NoteStore
* __Lucene:__
* Graphite For logging with Slunk
* Splunk ingestion pipeline.
* __Ansible:__ Automate deployment, configuration, instalation
* __Puppet:__ Declarative configuration language
* __Kubernetes:__ Orchestration framework

### Experience first

Feature anti-pattern:
1. if a feature, you are thinking about must appear in preference (configurable): red alert. It is pointing the job to the user.
2. Disagree on the default value

Icons, and UX matters a lot when competing in the noise of conpetency (app, themes: food, music)

### Design by Feature

#### Feature

__Idea__ offline doc with zeal framework or webclipper

1. Web Clipper
2. Templates
3. Spaces
4. Integrations
5. Notes Sync
6. PDF & Doc Search
7. Search Handwriting
8. Document Scanning
9. Notebooks & Tags

#### Products

1. Evernote
2. Web clipper
3. Scannable
4. Skitch: draw on a image
5. Penultimate: Get presentation from hand written

#### Sharing

1. Individual
2. Group
3. World

* As soon as you have a feed, people stated to share. But too noisy, voctim of its.own success
* Personal and shared content side by side, publicize the share

#### Searching
 
1. Keyword
2. Tag
