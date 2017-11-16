//
//  ViewController.swift
//  CurrencyBitcoinConverter
//
//  Created by practica on 1/11/17.
//  Copyright © 2017 practica. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    let currencyArray = ["ARS","AUD","BRL","CAD","CNY","COP","EUR","GBP","HKD","IDR","ILS","INR","JPY","LRD","MXN","NOK","NZD","PLN","RON","RUB","HUF","MZN","SVC"]
    
    let symbols = ["$","$","R","$","¥","$","€","£","$","Rp","₪","₹","¥","$","$","kr","$","zł","lei","₽"
        ,"Ft","MT","$"]
    
    
    let baseURL="https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    var finalURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPickerView.delegate=self
        currencyPickerView.dataSource=self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        
        finalURL=baseURL+currencyArray[row]
        getBitcoinData(url: finalURL!,symbol: symbols[row])
        

    }
    
    //MARK: - Networking
    func getBitcoinData(url:String,symbol: String){
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let bitcoinJSON: JSON = JSON(response.result.value!)
                self.updateBitCoinData(json:bitcoinJSON,symbol: symbol)
            
            }
            else{
                print ("Error: \(response.result.error)")
                self.lblPrice.text="Se presento un problema"
            }
        }
        
    }
    func updateBitCoinData(json:JSON,symbol:String){
        if let bitcoinResult=json["ask"].double {
            lblPrice.text=symbol+String(FormatNumber(number:bitcoinResult))
        }
        else{
        lblPrice.text="Servicio no Disponible"
        }
    }
    func FormatNumber(number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        let returnValue = numberFormatter.string(from: NSNumber(value:number))
        
        return returnValue!
    }
}

