//
//  Business.swift
//  CurrencyBitcoinConverter
//
//  Created by practica on 15/11/17.
//  Copyright © 2017 practica. All rights reserved.
//

import Foundation
class Business {
    let separator = "."
    let baseURL="https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    func FormatNumber(number:Double) -> String {
        let formatNumber = NumberFormatter()
        formatNumber.numberStyle = NumberFormatter.Style.decimal
        formatNumber.groupingSeparator = separator
        let returnValue = formatNumber.string(from: NSNumber(value:number))
        return returnValue!
    }
}
