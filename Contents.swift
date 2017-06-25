//: Playground - noun: a place where people can play

import UIKit

// CLOSURES
// functions are a special (named) case of closures
// closures are discrete bundles of functionality that can be used in your application to accomplish specific tasks

let volunteerCounts = [1,3,40,32,2,53,77,13]

// sorting the array
//func sortAscending (_ i:Int, _ j:Int) -> Bool {
//    return i < j
//}
//
//let volunteersSorted = volunteerCounts.sorted(by: sortAscending)

// closure syntax follows this general form:
// { (parameters) -> return type in 
//      // Code
// }

// refactoring the sorting code
//let volunteersSorted = volunteerCounts.sorted(by: {
//    (i: Int, j: Int) -> Bool in
//    return i < j
//})

// refactor again taking advantage of type inference
//let volunteersSorted = volunteerCounts.sorted(by: {i, j in i < j})
// if there were more than one expression an explicit return would be needed

// compiler can use some shorthand syntax to make it even shorter because it knows sorted(by:) takes a closure with two parameters of the same type as the items passed into the argument
//let volunteersSorted = volunteerCounts.sorted(by: {$0 < $1})
// for closure with more than two arguments, can use $2, $3 etc

// refactoring again...
let volunteersSorted = volunteerCounts.sorted {$0 < $1}

// removed parentheses because sorted(by:) only takes one argument

// nice that things can be shorter, but it is more important that things are readable and maintainable.

// functions as return types
//func makeTownGrand() -> (Int, Int) -> Int {
//    func buildRoads (byAddingLights lights: Int, toExistingLights existingLights: Int) -> Int {
//        return lights + existingLights
//    }
//    return buildRoads
//}
//
//var stoplights = 4
//let townPlanByAddingLightsToExistingLights = makeTownGrand()
//stoplights = townPlanByAddingLightsToExistingLights (4, stoplights)
//print("Knowhere has \(stoplights) stoplights.")

// functions as arguments
func makeTownGrand(withBudget budget: Int, condition: (Int) -> Bool) -> ((Int, Int) -> Int)? {
    if condition(budget) {
        func buildRoads(byAddingLights lights: Int, toExistingLights existingLights: Int) -> Int {
            return lights + existingLights
        }
        return buildRoads
    } else {
        return nil
    }
}
func evaluate(budget: Int) -> Bool {
    return budget > 10_000
}

var stoplights = 4

if let townPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 1_000, condition: evaluate) {
    stoplights = townPlanByAddingLightsToExistingLights(4, stoplights)
}

// if withBudget: on line 73 is less than 10,000, condition is false so makeTownGrand(withBudget: condition:) returns nil and buildRoads(byAddingLights: toExistingLights:) is never executed.

if let newTownPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 10_500, condition: evaluate) {
    stoplights = newTownPlanByAddingLightsToExistingLights (4, stoplights)
}
print("Knowhere has \(stoplights) stoplights.")

// closures capture values
// note each time growBy is called it increases the population, but doesn't assign the result to a constant or variable
// it is keeping an internal running total; to get the value, assign the result to your currentPopulation variable
func makePopulationTracker (forInitialPopulation population:Int) -> (Int) -> Int {
    var totalPopulation = population
    func populationTracker(growth: Int) -> Int {
        totalPopulation += growth
        return totalPopulation
    }
    return populationTracker
}

var currentPopulation = 5_422
let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)

growBy(500)
growBy(500)
growBy(500)
currentPopulation = growBy(500)


// closures are reference types
// this means when you assign a function to a constant or variable you're setting that constant or variable to _point to_ the function
// you are NOT creating a distinct copy of that function

let anotherGrowBy = growBy
anotherGrowBy(500)
print("current population is: \(currentPopulation)")
// total population (the internal variable in the function) is increased with anotherGrowBy(500) but currentPopulation remains the same because currentPopulation's value is not set by the return value of anotherGrowBy

// add yet another population to track
var bigCityPopulation = 4_061_981
let bigCityGrowBy = makePopulationTracker(forInitialPopulation: bigCityPopulation)
bigCityPopulation = bigCityGrowBy(10_000)
currentPopulation

// functional programming
// swift adopts some patterns from the functional programming paradigm such as first-class functions, pure functions, immutability and strong typing
// also provides some higher-order functions such as map(_:), filter(_:) and reduce(_:_:)

// higher-order functions
// take at least 1 function as input
// sorted(by:) is a higher order function

// map(_:)
//use to transform an array's contents.  swift provides an implementation of map on the Array type.  takes a function in to tell it how to transform the array contents

let precinctPopulations = [1244, 2021, 2157]
let projectedPopulations = precinctPopulations.map {
    (population: Int) -> Int in
    return population * 2
}
projectedPopulations

// filter(_:)
// can be called on Array type, takes a closure expression as argument, filters an array based on some criteria

let bigProjections = projectedPopulations.filter {
    (projection: Int) -> Bool in
    return projection > 4000
}
bigProjections

// reduce(_:_:)
// reduces values in an Array type to a single value that is returned from the function

let totalProjection = projectedPopulations.reduce(0) {
    (accumulatedProjection: Int, precinctProjection: Int) -> Int in
    return accumulatedProjection + precinctProjection
}

totalProjection

// BRONZE CHALLENGE
// you can also sort collections in place
// modify  volunteerCounts array to sort in place from smallest to largest
var volunteerCountsGiven = [1,3,40,32,2,53,77,13]

volunteerCountsGiven.sort()


// GOLD CHALLENGE
//clean up the implementation of reduce presented above
let totalPop = projectedPopulations.reduce(0, {x,y in x + y})
totalPop

