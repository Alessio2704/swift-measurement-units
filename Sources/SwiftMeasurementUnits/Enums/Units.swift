//
//  UnitSystem.swift
//  Test
//
//  Created by Alessio Marcuzzi on 08/11/24.
//

import Foundation

public enum Units: String, Codable, CaseIterable {
    
    case kilogramsOrPound
    case gramsOrOunces
    case metersOrFeet
    case centimetersOrInches
    case millimiters
    case minutes
    case seconds
    case count
    case repetition
    case degrees
    
    public func unitString(unitSystem: UnitSystem) -> String {
        switch unitSystem {
        case .metric:
            switch self {
            case .kilogramsOrPound:
                return "kg"
            case .gramsOrOunces:
                return "g"
            case .metersOrFeet:
                return "m"
            case .centimetersOrInches:
                return "cm"
            case .seconds:
                return "sec"
            case .count:
                return ""
            case .millimiters:
                return "mm"
            case .minutes:
                return "min"
            case .repetition:
                return "reps"
            case .degrees:
                return "°"
            }
        case .us:
            switch self {
            case .kilogramsOrPound:
                return "lbs"
            case .gramsOrOunces:
                return "oz"
            case .metersOrFeet:
                return "feet"
            case .centimetersOrInches:
                return "in"
            case .seconds:
                return "sec"
            case .count:
                return ""
            case .millimiters:
                return "mm"
            case .minutes:
                return "min"
            case .repetition:
                return "reps"
            case .degrees:
                return "°"
            }
        }
    }
    
    public func subunitString(unitSystem: UnitSystem) -> String {
        switch unitSystem {
        case .metric:
            switch self {
            case .kilogramsOrPound:
                return ""
            case .gramsOrOunces:
                return ""
            case .metersOrFeet:
                return "cm"
            case .centimetersOrInches:
                return "mm"
            case .seconds:
                return ""
            case .count:
                return ""
            case .millimiters:
                return ""
            case .minutes:
                return "sec"
            case .repetition:
                return ""
            case .degrees:
                return ""
            }
        case .us:
            switch self {
            case .kilogramsOrPound:
                return ""
            case .gramsOrOunces:
                return ""
            case .metersOrFeet:
                return "in"
            case .centimetersOrInches:
                return ""
            case .seconds:
                return ""
            case .count:
                return ""
            case .millimiters:
                return ""
            case .minutes:
                return "sec"
            case .repetition:
                return ""
            case .degrees:
                return ""
            }
        }
    }
    
    public func convertionMultiplier(unitSystem: UnitSystem) -> Double {
        switch unitSystem {
        case .metric:
            return 1
        case .us:
            switch self {
            case .kilogramsOrPound:
                return 2.205
            case .gramsOrOunces:
                return 1 / 28.3495
            case .metersOrFeet:
                return 1 / 0.3048
            case .centimetersOrInches:
                return 1 / 2.54
            case .seconds:
                return 1
            case .count:
                return 1
            case .millimiters:
                return 1
            case .minutes:
                return 1
            case .repetition:
                return 1
            case .degrees:
                return 1
            }
        }
    }
    
    public func numberOfWholeUnits(unitSystem: UnitSystem) -> Int {
        switch self {
        case .kilogramsOrPound: return unitSystem == .us ? 2205 : 1000
        case .gramsOrOunces: return unitSystem == .us ? 176 : 5000
        case .metersOrFeet: return unitSystem == .us ? 10 : 3
        case .centimetersOrInches: return unitSystem == .us ? 79 : 200
        case .millimiters: return 200
        case .minutes: return 120
        case .seconds: return 600
        case .count: return 1000
        case .repetition: return 1000
        case .degrees: return 360
        }
    }
    
    public func numberOfSubunitsInWholeUnit(unitSystem: UnitSystem) -> Int {
        switch self {
        case .kilogramsOrPound: return unitSystem == .us ? 1 : 4
        case .gramsOrOunces: return unitSystem == .us ? 10 : 1
        case .metersOrFeet: return unitSystem == .us ? 12 : 100
        case .centimetersOrInches: return 10
        case .millimiters: return 10
        case .minutes: return 60
        case .seconds: return 1
        case .count: return 1
        case .repetition: return 1
        case .degrees: return 1
        }
    }
    
    public func highlightEvery(unitSystem: UnitSystem) -> Int {
        switch self {
        case .kilogramsOrPound: return unitSystem == .us ? 5 : 4
        case .gramsOrOunces: return 5
        case .metersOrFeet: return unitSystem == .us ? 3 : 5
        case .centimetersOrInches: return 5
        case .millimiters: return 5
        case .minutes: return 5
        case .seconds: return 5
        case .count: return 5
        case .repetition: return 5
        case .degrees: return 5
        }
    }
    
    public func tickValue(unitSystem: UnitSystem) -> Double {
        switch self {
        case .kilogramsOrPound: return unitSystem == .us ? 1 : 0.25
        case .gramsOrOunces: return unitSystem == .us ? 0.1 : 1
        case .metersOrFeet: return unitSystem == .us ? 1 / 12 : 0.01
        case .centimetersOrInches: return 0.1
        case .millimiters: return 0.1
        case .minutes: return 1 / 60
        case .seconds: return 1
        case .count: return 1
        case .repetition: return 1
        case .degrees: return 1
        }
    }
}

extension Units {
    
    public var id: UUID { .init() }
    
    public var label: LocalizedStringResource {
        switch self {
        case .kilogramsOrPound:
            return "kg / Lbs"
        case .gramsOrOunces:
            return "grams / ounces"
        case .metersOrFeet:
            return "m / ft"
        case .centimetersOrInches:
            return "cm / in"
        case .millimiters:
            return "mm"
        case .minutes:
            return "min"
        case .seconds:
            return "sec"
        case .count:
            return "count"
        case .repetition:
            return "reps"
        case .degrees:
            return "degrees (°)"
        }
    }
}


