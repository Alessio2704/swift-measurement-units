//
//  File.swift
//  MeasurementSelector
//
//  Created by Alessio Marcuzzi on 04/03/25.
//

import SwiftUI
import HapticManager

public struct MeasurementHorizontalSelector: View {
    
    @Binding var value: Double
    
    let numberOfWholeUnits: Int
    let unitString: String
    let numberOfSubunitsInWholeUnit: Int
    let subunitString: String
    let tickValue: Double
    let convertionMultiplier: Double
    let highlightEvery: Int
    
    let forWeight: Bool
    let spacing: Double
    
    let id: String
    
    public init(
        value: Binding<Double>,
        numberOfWholeUnits: Int,
        unitString: String,
        numberOfSubunitsInWholeUnit: Int,
        subunitString: String,
        tickValue: Double,
        convertionMultiplier: Double,
        highlightEvery: Int,
        forWeight: Bool,
        spacing: Double = 30,
        id: String
    ) {
        self._value = value
        self.numberOfWholeUnits = numberOfWholeUnits
        self.unitString = unitString
        self.numberOfSubunitsInWholeUnit = numberOfSubunitsInWholeUnit
        self.subunitString = subunitString
        self.tickValue = tickValue
        self.convertionMultiplier = convertionMultiplier
        self.highlightEvery = highlightEvery
        self.forWeight = forWeight
        self.spacing = spacing
        self.id = id
    }
    
    public var body: some View {
        
        VStack {
            
            ConvertedUnitView(
                value: value,
                unitString: unitString,
                subunitString: subunitString,
                convertionMultiplier: convertionMultiplier,
                numberOfSubunitsInWholeUnit: numberOfSubunitsInWholeUnit,
                forWeight: forWeight
            )
            
            SelectorComponent(
                value: $value,
                numberOfWholeUnits: numberOfWholeUnits,
                unitString: unitString,
                numberOfSubunitsInWholeUnit: numberOfSubunitsInWholeUnit,
                subunitString: subunitString,
                tickValue: tickValue,
                convertionMultiplier: convertionMultiplier,
                highlightEvery: highlightEvery,
                forWeight: forWeight,
                spacing: spacing
            )
            .frame(height: 100)
            .id(id)
        }
    }
}

private struct SelectorComponent: View {
    
    @State private var isLoaded: Bool = false
    @Binding var value: Double
    @State private var scrollViewPosition: Int?
    
    let numberOfWholeUnits: Int
    let unitString: String
    let numberOfSubunitsInWholeUnit: Int
    let subunitString: String
    let tickValue: Double
    let convertionMultiplier: Double
    let highlightEvery: Int
    
    let forWeight: Bool
    let spacing: Double
    
    init(
        value: Binding<Double>,
        numberOfWholeUnits: Int,
        unitString: String,
        numberOfSubunitsInWholeUnit: Int,
        subunitString: String,
        tickValue: Double,
        convertionMultiplier: Double,
        highlightEvery: Int,
        forWeight: Bool,
        spacing: Double
    ) {
        self._value = value
        self.numberOfWholeUnits = numberOfWholeUnits
        self.unitString = unitString
        self.numberOfSubunitsInWholeUnit = numberOfSubunitsInWholeUnit
        self.subunitString = subunitString
        self.tickValue = tickValue
        self.convertionMultiplier = convertionMultiplier
        self.highlightEvery = highlightEvery
        self.forWeight = forWeight
        self.spacing = spacing
    }
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            let horizontalPadding = size.width / 2 - 0.5
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: spacing) {
                    let totalSteps = numberOfWholeUnits * numberOfSubunitsInWholeUnit
                    ForEach(0...totalSteps, id: \.self) { index in
                        
                        let shouldHighlight = index % highlightEvery == 0
                        
                        HStack {
                            Divider()
                                .frame(width: 1, height: shouldHighlight ? 30 : 15, alignment: .bottom)
                        }
                        .frame(height: 40, alignment: .bottom)
                        .id(index)
                        .overlay(alignment: .bottom) {
                            if shouldHighlight {
                                let calc = Double(index) / Double(numberOfSubunitsInWholeUnit) / convertionMultiplier
                                
                                ConvertedUnitView(
                                    value: calc,
                                    unitString: unitString,
                                    subunitString: subunitString,
                                    convertionMultiplier: convertionMultiplier,
                                    numberOfSubunitsInWholeUnit: numberOfSubunitsInWholeUnit,
                                    size: .extraSmall,
                                    forWeight: forWeight
                                )
                                .offset(y: 30)
                                .fixedSize()
                            }
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, horizontalPadding)
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: 50)
                    .padding(.bottom, 20)
                
            })
            .onAppear {
                DispatchQueue.main.async {
                    isLoaded = true
                }
            }
            .scrollPosition(id: .init(get: {
                getPosition()
            }, set: { newValue in
                setPosition(newValue: newValue)
            }))
        }
    }
    
    private func getPosition() -> Int? {
        let res = value / tickValue * convertionMultiplier
        let position = isLoaded ? Int(res.rounded(.toNearestOrAwayFromZero)) : nil
        return position
    }
    
    private func setPosition(newValue: Int?) {
        if let newValue {
            value = Double(newValue) * tickValue / convertionMultiplier
            let shouldHighlight = newValue % highlightEvery == 0
            HapticManager.shared.impact(style: shouldHighlight ? .medium : .light)
        }
    }
}
