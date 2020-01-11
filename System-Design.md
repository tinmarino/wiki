# Youtube Gaurav Sen


- Messenging tools
- Gatteway (Enter Wtsp internal cloud)


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
* Database Sharding: Divide the data in different machines according to the mist relevant index => first find the most relvant index (goelic, age, tag)

## Interview tips

* Front to back approach: what user want -> how to configure servers
* Each time you have a collection, think you should get a max number of items, size

1. Think about the features you want, 4 feature is enought for 1h interview
  1. Store profile
    1. Id
    2. Surname
    3. Images (Give a max bound), Avatar
  2. Recommend matches (Tinder)
  3. Notes maches, analytices
  4. Dirext messaging (chat)


## Databases

Blob: Binary large object stored in databaese have 3 avantages over files

* Blob
  1. Mutability: can change cells := item attributes
  2. Transaction safety: atomic operation safe
  3. Indexablility
  4. Access control: possible with files too

* Files (No select *)
  1. Cheap
  2. Faster
  3. Content Delivery Network


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

## Tips

* Preparing beforehand at non peek hours
  1. Identificate the hours
  2. Cron jobs
