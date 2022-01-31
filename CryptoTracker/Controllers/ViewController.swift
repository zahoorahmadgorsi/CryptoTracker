//
//  ViewController.swift
//  CryptoTracker
//
//  Created by iMac on 29/01/2022.
//

import UIKit
import JGProgressHUD

enum UserDefaultsKeys : String {
    case BitCoinLatestDollarRate
    case BitCoinLatestDollarRateAtTime
}

class ViewController: UIViewController {

    private let naHUD = JGProgressHUD(style: .dark)
    var timer = Timer()
    var timerInterval:TimeInterval = 60.0
    
    @IBOutlet weak var lblCurrentRate: UILabel!
    @IBOutlet weak var txtMinimumAcceptableRate: UITextField!
    @IBOutlet weak var txtMaxAcceptableRate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loading stored values from user defaults
        let bitCoinLatestDollarRate = UserDefaults.standard.float(forKey: UserDefaultsKeys.BitCoinLatestDollarRate.rawValue)
        let bitCoinLatestDollarRateAtTime = UserDefaults.standard.string(forKey: UserDefaultsKeys.BitCoinLatestDollarRateAtTime.rawValue)
        if bitCoinLatestDollarRate > 0 {
            updateUI(bitCoinLatestDollarRate, bitCoinLatestDollarRateAtTime)
        }
        setUpAndStartTimer()
    }
    
    // made a function for test case
    func setUpAndStartTimer(){
        // 1 minute timer
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(self.getPerMinuteCryptoRates), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    // must be internal or public.
    @objc func getPerMinuteCryptoRates() {
        self.showNetworkActivity()
        getCryptoInfo() {currentRates, error in
            self.hideNetworkActivity()
            
            if let error = error {
                self.ShowAlert("Error", error.localizedDescription, "Dismiss" , btnTapHandler: nil)
                return
            }
            
            if let currentRates = currentRates {
                let bitCoinLatestDollarRate = currentRates.bpi.USD.rate_float
                let bitCoinLatestDollarRateAtTime = currentRates.time.updated
                self.updateUI(bitCoinLatestDollarRate, bitCoinLatestDollarRateAtTime)
                
                //Storing values in user defaults
                UserDefaults.standard.set(bitCoinLatestDollarRate, forKey: UserDefaultsKeys.BitCoinLatestDollarRate.rawValue)
                UserDefaults.standard.set(bitCoinLatestDollarRateAtTime, forKey: UserDefaultsKeys.BitCoinLatestDollarRateAtTime.rawValue)
                
                //Min and Maximum rate check
                if let minRate = Float(self.txtMinimumAcceptableRate.text ?? "0") , bitCoinLatestDollarRate < minRate{
                    self.ShowAlert("Minimum Rate Alert", "Current Rate is below the minimum acceptable limit", "OK", btnTapHandler: nil)
                }else if let maxRate = Float(self.txtMaxAcceptableRate.text ?? "0") , bitCoinLatestDollarRate > maxRate{
                    self.ShowAlert("Maximum Rate Alert", "Current Rate is above the maximum acceptable limit", "OK", btnTapHandler: nil)
                }
                
                
            } else {
                let error = BackendError.parsing(reason: "Could not crypto rates")
                self.ShowAlert("Error", error.localizedDescription, "OK", btnTapHandler: nil)
            }
        }
    }
    
    //Update the UILabel with latest value and at that time
    func updateUI(_ bitCoinLatestDollarRate:Float ,_ bitCoinLatestDollarRateAtTime:String?){
        var string = "Last rate: $" + String(bitCoinLatestDollarRate)
        if let time = bitCoinLatestDollarRateAtTime , time.count > 0{
            string += "\nAt: " + time
        }
        self.lblCurrentRate.text = string
        print(string)
    }
    
    func getCryptoInfo(completion: @escaping (CryptoRate?, Error?) -> Void) {
        APIManager().getCurrentCryptoRates() { cryptoRates, error in
            guard error == nil else {
                let error = BackendError.parsing(reason: "Could not get Crypto Info")
                completion(nil, error)
                return
            }
            completion(cryptoRates, error)
        }
    }
    
    func showNetworkActivity() {
        // Safe guard to that won't display both loaders at same time.
        naHUD.textLabel.text = "Loading"
        naHUD.show(in: view)
    }
    
    func hideNetworkActivity() {
        // Safe guard that will call dismiss only if HUD is shown on screen.
        if naHUD.isVisible {
            naHUD.dismiss()
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
}

