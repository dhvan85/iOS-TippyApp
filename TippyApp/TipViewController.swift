//
//  ViewController.swift
//  TippyApp
//
//  Created by Van Do on 9/14/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var percentSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billText: UITextField!
    
    let percentArray = [0.18, 0.2, 0.25]
    let currentLocale = NSLocale.currentLocale()
    let formater = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.locale = currentLocale
        formater.numberStyle = .CurrencyStyle
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TipViewController.willEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func willEnterForeground(notification: NSNotification!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let date = defaults.objectForKey("last_time") as? NSDate

        if date != nil && date!.timeIntervalSinceNow < -60 {
            billText.text = ""
            updateTip()
        }
    }
    
    deinit {
       NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaults.integerForKey("default_tip")
        
        billText.becomeFirstResponder()
        percentSegment.selectedSegmentIndex = index
        
        updateTip()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTip(){
        let billValue = Double(billText.text!) ?? 0
        let tipValue = billValue * percentArray[percentSegment.selectedSegmentIndex]
        let totalValue = billValue + tipValue
        
        tipLabel.text = formater.stringFromNumber(tipValue)// String(format: "$%.2f", tipValue)
        totalLabel.text = formater.stringFromNumber(totalValue) //String(format: "$%.2f", totalValue)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(percentSegment.selectedSegmentIndex, forKey: "default_tip")
        
        updateTip()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
}