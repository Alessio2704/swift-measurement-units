//
//  File.swift
//  MeasurementSelector
//
//  Created by Alessio Marcuzzi on 04/03/25.
//

import Foundation

extension Double {

    func roundToNearestOrOne(decimalPlaces: Int = 6) -> Double {
        let precision = pow(10, Double(decimalPlaces))
        let roundedNumber = roundl(self * precision) / precision
        
        if abs(roundedNumber - 1) < 1e-10 {
            return 1.0
        } else {
            return roundedNumber
        }
    }
    
    func round(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
    func determineDecimalPlaces() -> Int {
        let stringRepresentation = String(format: "%g", self)
        let decimalPointIndex = stringRepresentation.firstIndex(of: ".") ?? stringRepresentation.endIndex
        let decimalPlaces = stringRepresentation.distance(from: decimalPointIndex, to: stringRepresentation.endIndex)
        return decimalPlaces == 0 ? decimalPlaces : decimalPlaces - 1
    }
}
