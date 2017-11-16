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
    
    private var modelBusiness=Business()
    
    var finalURL: String?
    
    let currencyArray = ["ARS","AUD","BRL","BOB","CAD","CNY","COP","EUR","GBP","HKD","IDR","ILS","INR","JPY","LRD","MXN","NOK","NZD","PLN","RON","RUB","HUF","UYU"]
    
    let symbols = ["$","$","R","Bs","$","¥","$","€","£","$","Rp","₪","₹","¥","$","$","kr","$","zł","lei","₽"
        ,"Ft","$U"]
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
 
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
        finalURL=modelBusiness.baseURL+currencyArray[row]
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
            lblPrice.text=symbol+String(modelBusiness.FormatNumber(number:bitcoinResult))
        }
        else{
        lblPrice.text="Servicio no Disponible"
        }
    }

}

