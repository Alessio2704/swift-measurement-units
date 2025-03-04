//
//  File.swift
//  MeasurementSelector
//
//  Created by Alessio Marcuzzi on 04/03/25.
//

import SwiftUI

public struct ConvertedUnitView: View {
    
    let value: Double
    let unitString: String
    let subunitString: String
    let convertionMultiplier: Double
    let numberOfSubunitsInWholeUnit: Int
    let size: Size
    
#warning("try to fix this. Workaround for now")
    let forWeight: Bool
    let onlySubunit: Bool
    
    public init(
        value: Double,
        unitString: String,
        subunitString: String,
        convertionMultiplier: Double,
        numberOfSubunitsInWholeUnit: Int,
        size: Size = .base,
        forWeight: Bool,
        onlySubunit: Bool = false
    ) {
        self.value = value
        self.unitString = unitString
        self.subunitString = subunitString
        self.convertionMultiplier = convertionMultiplier
        self.numberOfSubunitsInWholeUnit = numberOfSubunitsInWholeUnit
        self.size = size
        self.forWeight = forWeight
        self.onlySubunit = onlySubunit
    }
    
    public var body: some View {
        
        HStack {
            
            if integerPart != 0 || integerPart == 0 && subunitPart == 0 {
                HStack(spacing: 5) {
                    Text("\(integerPart)")
                        .font(size.numberFont)
                        .bold()
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                    
                    Text(unitString)
                        .font(size.unitFont)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                }
            }

            if subunitPart != 0 {
                
                HStack(spacing: 5) {
                    
                    if subunitString.isEmpty {
                        Text(".")
                            .font(size.numberFont)
                            .fontWeight(.semibold)
                    }
                    
                    Text("\(subunitPart)")
                        .font(size.numberFont)
                        .bold()
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                    
                    if integerPart == 0 && subunitString.isEmpty {
                        Text(unitString)
                            .font(size.unitFont)
                            .fontWeight(.semibold)
                            .textScale(.secondary)
                            .foregroundStyle(.gray)
                    } else {
                        Text(subunitString)
                            .font(size.unitFont)
                            .fontWeight(.semibold)
                            .textScale(.secondary)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
    
    var convertedValue: Double {
        (value) * (convertionMultiplier)
    }
    
    var convertedValueInSubunits: Double {
        convertedValue * Double(numberOfSubunitsInWholeUnit)
    }
    
    var integerPart: Int {
        let ratio = convertedValueInSubunits / Double(numberOfSubunitsInWholeUnit)
        return Int(floor(ratio.roundToNearestOrOne()))
    }
    
    var subunitPart: Int {
        
        if convertedValueInSubunits == Double(numberOfSubunitsInWholeUnit) {
            return 0
        }
        
        let a = convertedValueInSubunits - Double(integerPart) * Double(numberOfSubunitsInWholeUnit)
        
        if forWeight {
            return Int(a * 25)
        }
        
        return Int(a.rounded(.toNearestOrAwayFromZero))
    }
}

extension ConvertedUnitView {
    
    public enum Size {
        
        case base, small, extraSmall
        
        var numberFont: Font {
            switch self {
            case .base: return .largeTitle
            case .small: return .title2
            case .extraSmall: return .body
            }
        }
        
        var unitFont: Font {
            switch self {
            case .base: return .title2
            case .small: return .body
            case .extraSmall: return .footnote
            }
        }
    }
}

