## DemoCSV

## Description
Demonstration that strictly meets the requested requirements: [a link](https://github.com/Joule87/Media/blob/master/take-home-01.pdf)

## Technologies used
The app is written in Swift 5, with Xcode 14.2, UIKit as the UI framework, unit testing is done with the native tools provided by XCode

## How to run
Open DemoCSV.xcodeproj select target DemoCSV and select device/simulator, then run.
In order to run tests, on the left side open test navigator panel and run all the tests

## Architecture
MVVM architecture, combining UIKit and Combine frameworks

## Project structure 
* DemoCSV: Contains the main app code
    * Utilities: contains small helper classes, constants and extensions.
    * Resources: contains the apps resources (images, strings)
    * Service: contains the data provider
    * Core
        * Model: contains the domain model
        * View: contains custom UIViews, view controllers and table cells
        * ViewModel: exposes all data streams which are relevant to the View. Moreover, it servers as a link between the Model and the View.
* DemoCSVUnitTests: Contains the unit tests

## unit tests
The unit tests are focused on ViewModel layer. They don't test anything on view controllers or views.

## Pods
The app make use of 'CSV.swift', version '~> 2.4.3' for loading data from a CSV file.
