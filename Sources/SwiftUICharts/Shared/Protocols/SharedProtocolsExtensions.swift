//
//  SharedProtocolsExtensions.swift
//  
//
//  Created by Will Dale on 13/02/2021.
//

import SwiftUI

// MARK: - Data Set
extension CTSingleDataSetProtocol where Self.DataPoint: CTStandardDataPointProtocol & CTnotRanged {
    public func maxValue() -> Double {
        self.dataPoints
            .map(\.value)
            .max() ?? 0
    }
    public func minValue() -> Double {
        self.dataPoints
            .map(\.value)
            .min() ?? 0
    }
    public func average() -> Double {
        self.dataPoints
            .map(\.value)
            .reduce(0, +)
            .divide(by: Double(self.dataPoints.count))
    }
}
extension CTSingleDataSetProtocol where Self.DataPoint: CTRangeDataPointProtocol & CTisRanged {
    public func maxValue() -> Double {
        self.dataPoints
            .map(\.upperValue)
            .max() ?? 0
    }
    public func minValue() -> Double {
        self.dataPoints
            .map(\.lowerValue)
            .min() ?? 0
    }
    public func average() -> Double {
        self.dataPoints
            .reduce(0) { $0 + ($1.upperValue - $1.lowerValue) }
            .divide(by: Double(self.dataPoints.count))
    }
}

extension CTMultiDataSetProtocol where Self.DataSet.DataPoint: CTStandardDataPointProtocol {
    public func maxValue() -> Double {
        self.dataSets.compactMap {
            $0.dataPoints
                .map(\.value)
                .max()
        }
        .max() ?? 0
    }
    public func minValue() -> Double {
        self.dataSets.compactMap {
            $0.dataPoints
                .map(\.value)
                .min()
        }
        .min() ?? 0
    }
    public func average() -> Double {
        
        self.dataSets
            .compactMap {
                $0.dataPoints
                    .map(\.value)
                    .reduce(0, +)
                    .divide(by: Double($0.dataPoints.count))
            }
            .reduce(0, +)
            .divide(by: Double(self.dataSets.count))
    }
}

extension CTMultiDataSetProtocol where Self == StackedBarDataSets {
    /**
     Returns the highest sum value in the data sets
     
     - Note:
     This differs from other charts, as Stacked Bar Charts
     need to consider the sum value for each data set, instead of the
     max value of a data point.
     
     - Returns: Highest sum value in data sets.
     */
    public func maxValue() -> Double {
        self.dataSets
            .map {
                $0.dataPoints
                    .map(\.value)
                    .reduce(0.0, +)
            }
            .max() ?? 0
    }
}
extension CTMultiBarChartDataSet where Self == StackedBarDataSet {
    /**
     Returns the highest sum value in the data set.
     
     - Note:
     This differs from other charts, as Stacked Bar Charts
     need to consider the sum value for each data set, instead of the
     max value of a data point.
     
     - Returns: Highest sum value in data set.
     */
    public func maxValue() -> Double {
        self.dataPoints
            .map(\.value)
            .reduce(0, +)
    }
}

extension CTDataPointBaseProtocol {
    /// Unwraps description
    public var wrappedDescription: String {
        self.description ?? ""
    }
}