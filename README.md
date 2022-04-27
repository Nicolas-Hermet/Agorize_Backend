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

## Answer and notes to this exercice
### First:
I mainly wanted to respect my engagement to deliver the exercice for wednesday evening.
So reader and reviewer are now warned that I had to make decision also based on deadline, and unfortunately not with a "state of the art" approach everytime.
### Assumptions made, and how I saw the answer

- I focused mainly on a one way update : the import, with that constraint in mind : "Update the address of the building only if it has never been an address of the building before".

- Therefore I needed to keep track of every changes made for these columns.
As we wanted the mechanism to be easily adaptable for future models, polymorphisme could do the trick.

- I wondered if "reference" column was here to stay. IMO, we should consider a process to force people out of the old app, by not allowing import on newly created instance with ShortCutApp.

- I did it in rails 6 because I had a fat-finger on setting up the app... but anyway, it doesn't change anything IMHO.

Everytime, we update one instance of any model, we will then store it in the `History` model as `memorable`. This way, we will be able to check for a previous existing record in each import.

### Known limitations :
When a column is removed from a model, we should destroy every record found.

It will store every update of every model : we should limit it with a constant listing concerning models in `application_record.rb`.

I should have put a dependancy on the History model, so that whe a record is destroyed, every related history is destroy dependantly.

I know that I encountered some trouble in `app/services/data_import.rb` with hash mutability... And I'm frustrated  I didn't have the time to do something more maintainable.

I clearly didn't have the time to figure out how to properly mock a CSV with RSpec. Therefore you will find some ugly and not DRY specs in `spec/services/data_import_spec.rb` along with some pending tests.

Ususally for something like this, much more would have been spent on discussing with my PO and lead to ensure the technical solution and scope first.

Then I would have normally done a "Hat PR" instead of multiple PR directly merged to the main branch, but hey, I'm at home here.

Hope you enjoyed... sorry if not.
