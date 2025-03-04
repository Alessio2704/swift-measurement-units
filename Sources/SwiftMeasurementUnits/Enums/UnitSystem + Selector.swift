//
//  UnitSystem + Selector.swift
//  Test
//
//  Created by Alessio Marcuzzi on 22/02/25.
//

import SwiftUI

extension Units {
    
    @MainActor
    @ViewBuilder
    public func selector(unitSystem: UnitSystem, value: Binding<Double>) -> some View {
        MeasurementHorizontalSelector(
            value: value,
            numberOfWholeUnits: self.numberOfWholeUnits(unitSystem: unitSystem),
            unitString: self.unitString(unitSystem: unitSystem),
            numberOfSubunitsInWholeUnit: self.numberOfSubunitsInWholeUnit(unitSystem: unitSystem),
            subunitString: self.subunitString(unitSystem: unitSystem),
            tickValue: self.tickValue(unitSystem: unitSystem),
            convertionMultiplier: self.convertionMultiplier(unitSystem: unitSystem),
            highlightEvery: self.highlightEvery(unitSystem: unitSystem),
            forWeight: self == .kilogramsOrPounds,
            id: "\(self.rawValue)-\(unitSystem.rawValue)"
        )
    }
}
