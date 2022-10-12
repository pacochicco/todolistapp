import UIKit

enum AddTwoNumberErrors : Error{
    case numberGreaterThanNine, numberIsOdd
}

func addTwoNumbers( firstNumber: Int, secondNumber: Int) throws -> Int{
    if firstNumber > 9{
        throw AddTwoNumberErrors.numberGreaterThanNine
    }
    if secondNumber > 9{
        throw AddTwoNumberErrors.numberGreaterThanNine
    }
    if !(firstNumber % 2 == 0){
        throw AddTwoNumberErrors.numberIsOdd
    }
    return firstNumber + secondNumber
}

do{
    let sumOfNumbers = try addTwoNumbers(firstNumber: 10, secondNumber: 10)
} catch(let error){
    let twoError = error as! AddTwoNumberErrors
    switch twoError{
    case .numberGreaterThanNine:
        break
    case .numberIsOdd:
        break
    }
        
}

