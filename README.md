# iOS_SimpleCoreDataApp_CRUD
Simple Core Data app using CRUD, based off a workout diary, LiftSmart, by Josh O'Connor.
It is essentially LiftSmart in it's earliest stages, and is as simple as it gets.


This project is a simple Core Data application.  It saves one entry with a textfield, 
and uses a UITableViewController and a NSFetchedResultsController.  The user can do 
basic CRUD (Create, Read, Update, Delete) methods.  Deletion comes with cell animation.

The purpose of this project, and the reason this was branched off LiftSmart and put in it's
own Git repo is because of the reusability of the code in the project, particularly the 
CoreDataStack, which has been removed from the App Delegate and placed into CoreDataStack.h/.m, 
in such that it encapsulates everything you need to use Core Data, as well as its CRUD methods.

This project, iOS_SimpleCoreDataApp_CRUD is available to the public for reuse and distribution
at no cost.  

Copyright Josh O'Connor 2016
