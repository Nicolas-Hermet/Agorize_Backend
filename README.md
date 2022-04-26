Context
=======
We have a web app using RoR called ShortcutApp, this app has 2 main models : Building and Person.

Our users use our app to handle these models but also have an old software called OldApp that they can interact with on a daily basis to change some attributes of the models.

Example : If a user wants to change the address of a building, he can either : 
- Use ShortcutApp to change it via the web interface
- Use OldApp to change it via its desktop application

Some users prefer using the first method and other prefer using the second one.

To make sure people working on those models make the best of our ShortcutApp, we want to implement an import that is based on CSV files exported by OldApp and that we would run everyday.


Exercise
========
Your goal will be to build this import, by making sure that we do not overwrite what has been changed by the user of ShortcutApp.

In this exercise, we **will not** implement the cron / scheduler task, we will only focus on the import itself.

Also, we will not implement any web interface of ShortcutApp, we can use the console to simulate changes of the models.

The import we want to build has to comply with some rules : 

- Because we want to make sure a change on specific attribuets in ShortcutApp won't be overriden by a change in OldApp, some attributes need a higher level of update :
  - For example, if a user changes a building address in ShortcutApp, then we will stop updating this address at each import
  - The rule to make sure this won't happen is : "Update the address of the building only if it has never been an address of the building before", that way, if we try to import the old adress, we know it's an old one and won't replace it.
- The attributes that needs this level of update are :
  - building manager name
  - person email
  - person mobile phone number
  - person home phone number
  - person address
- We may add or remove attributes from this list as our product evolve
- We may add models to this list as our product evolve
- In the example, there are only 2 records per csv, but in production mode, there can be hundreds thousands of records to import each day


Your job :
- Write the import of the csv files (provided)
- Write some tests (not necesssary to have a 100% coverage but write tests you think are consistent with the main features)


Evaluation Criteria
=========
We will particularly analyze the following criterias for the evaluation :

- The readability of the code (can we understand what you did easily)
- The flexibility of the code (how easy it would be to extend the features)
- The global performance of the import (we don't need a rocket, but not a turtle either)
- Tests !!!

Quick Start
==========
## App Setup
````shell
rails new shortcut-test
cd shortcut-test
rails g model building reference address zip_code city country manager_name
rails g model person reference email home_phone_number mobile_phone_number firstname lastname address
````

## CSV examples
You will find some CSV examples in the files provided that can help you understand the input of our system, but you will have to create more when writing your tests.
