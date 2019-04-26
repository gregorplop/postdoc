## project now defunct, repo remains for historical reasons.<br/>See the 2019 entry in following paragraph
### A PostgreSQL-based Electronic Document Management framework for Xojo
postdoc aims to be a way for Xojo developers to easily create workflow-enabled EDM applications. It abstracts the underlying database structure for storing metadata as well as version and status information. In addition to that, it provides a mechanism for storing binary content outside the database, while providing access to it via the same database connection.
- - -
### The state of postdoc.
**(April 2019)**  
Due to to severely limited personal time, development on the project (as the pharaonic endeavour it was) has stopped and will not start again.

**But,** this does not mean that all work already done is tossed down the drain!  
An effort is being made to salvage interesting (and independent/reusable) parts by moving some of them to separate repos, where they can start a life of their own and be more visible to whoever might have a use for them. 

Already, 2 utilities have their own repository: pgNotifyDebug and SQLiteExplorer  
postdoc's object storage mechanism will follow, rebranded as **"Limnie"**


**(2018)**  
*Well, postdoc doesn't really exist yet!*

It is still under heavy development and large parts of it have not even left the design stage, meaning, it has not been decided on the optimal way to implement them!

**But,** what does exist and it's pretty functional, is the storage subsystem, *pdstorage*.
An important thing to note is the order of development: any meaningful work on postdoc cannot start before the storage and data transfer mechanisms are functional. So, all efforts are focused on them at the moment.
- - - 
### What's here
Below is a list of postdoc library components and applications that anyone interested in this project can explore and test. This list is going to be the main reference point as to the overall progress of the project.
#### postdoc libraries

* **pdcore**\
   This is the core library of methods, as well as utility classes that are to be universally required by any postdoc component. A good example (the only at this moment) is the pdoutcome class, which is the standard way for most methods to return their outcome or results. You may find some methods in the pdcorelib module useful to copy, but generally, nothing here is meaningful on its own.

* **pdstorage**\
   This is the binary storage subsystem of postdoc. It is meant for storing the document content off the database, in a structure that is convenient for both the developer and the system administrator. It is being developed in such way that it can be easily broken off the rest of postdoc and used in other projects.
 
   *pdstorage* is essentially a virtual file system where all data containers are SQLite databases. 
   
   There is a central "point of reference", which is called a **VFS** and it is the SQLite database file that holds object allocation and addressing information for the entire storage system. Access to a VFS can be password-protected if required.
   
   A VFS can contain multiple **Storage Pools**. Pools are logical storage spaces for segregating data that belong to entirely different archiving projects. Access to the contents of a Pool can be password-protected if required.
   
   Data pushed into a Pool is eventually stored in SQLite databases called **Media**. These are files that are created in configurable locations and cannot grow beyond a predefined limit (within some tolerance). A Pool can be configured to auto-create the next empty medium if the current working medium reaches its size limit.
   
   For examples over how *pdstorage* is implemented you can refer to **pdvfs_testGUI** and **pdStorageConsole** applications. For exploring the contents of the SQLite databases, you can use the **pdSQLiteStudio** application. More specific documentation on how to use the public methods will be included as notes in the corresponding classes, but generally an effort is being made to keep things as straightforward and self-explanatory as possible.

   **A final note of caution on pdstorage:**\
   While having multiple client applications running locally, mounting a VFS and performing I/O on Media is considered a safe practice, what is **ABSOLUTELY UNSAFE**, is connecting to a VFS or Media that reside on a shared network drive. This is an SQLite limitation and if at all possible to engage in such practice, you're risking database corruption. *You have been warned.*

#### postdoc applications (sample/test or backend)
* **pdvfs_testGUI**\
 This is the first application to test the functionality of *pdstorage*, when it was still called pdvfs. It provides a good overview of how to use the *pdstorage* classes, as well as how to implement password protection for both the VFS and Storage Pools.
 
* **pdStorageConsole**\
   A more recent testing ground for *pdstorage*. It allows creating and real time monitoring of Media usage but it does not support password protection.
 Also, allows for mass import of data for testing/benchmarking purposes.
 
* **pdSQLiteStudio**\
   An application for exploring SQLite database files. It was created for developing and debugging *pdstorage*. It supports opening password protected databases, **but** you need to keep in mind that *pdstorage* randomly salts all passwords. This means that the password you entered when creating the VFS or Pool is not the same password needed to manually open the VFS or Medium file using a database manager tool.

* **pdPgQueueDebug**\
   A diagnostic tool for the the PostgreSQL built-in message queue implemented using the LISTEN/NOTIFY statements. The document content transfer mechanism (*pdtransport*) will be relying on that message queue for communication between Postgres clients(=postdoc sessions) and the backend application that will be responding to their requests. This tool will be necessary for the debugging process.
   
- - -
### In conclusion...
We're still at the beginning. Please feel free to play around with *pdstorage* or integrate it to your application. For any questions, do not hesitate to contact me at g.poulopoulos at gmail.com


