//
//  File.swift
//  SwiftMeasurementUnits
//
//  Created by Alessio Marcuzzi on 04/03/25.
//

import Foundation

public enum UnitSystem: String, CaseIterable, Codable {
    
    case metric
    case us
    
    public var label: String {
        switch self {
        case .metric:
            return "Metric"
        case .us:
            return "US"
        }
    }
}
