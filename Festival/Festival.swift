//
// Created by Tom Sartori on 1/31/23.
//

import Foundation

class Festival: ObservableObject {

    static var sqmTable: Double = 6.0

    public var name: String;

    public var initialNumberOfTable: Int;
    @Published public var currentNumberOfTable: Int;

    public var initialTablePrice: Double;
    @Published public var currentTablePrice: Double;

//    private var sqmPrice: Double { round(currentTablePrice / Festival.sqmTable) };
    private var sqmPrice: Double;

    private var maxRevenue: Double { Double(currentNumberOfTable) * currentTablePrice }

    init(name: String, initialNumberOfTable: Int, initialTablePrice: Double) {
        self.name = name

        self.initialNumberOfTable = initialNumberOfTable
        currentNumberOfTable = self.initialNumberOfTable

        self.initialTablePrice = initialTablePrice
        currentTablePrice = self.initialTablePrice

        sqmPrice = 18.3
    }
}
