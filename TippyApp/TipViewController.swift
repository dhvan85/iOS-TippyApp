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
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var horizontalLine: UIView!
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var tipValue: UILabel!
    let currentLocale = NSLocale.currentLocale()
    let formater = NSNumberFormatter()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    let blueColor = UIColor(red:CGFloat(23) / 255, green: CGFloat(122) / 255, blue: CGFloat(255) / 255, alpha: CGFloat(1))
    
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.locale = currentLocale
        formater.numberStyle = .CurrencyStyle
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TipViewController.willEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func willEnterForeground(notification: NSNotification!) {
        let date = userDefaults.objectForKey("last_time") as? NSDate

        if date != nil && date!.timeIntervalSinceNow < -6 {
            billText.text = ""
            updateTip()
        }
    }
    
    deinit {
       NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("default_settings") as? NSData {
            settings = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Settings
        }
        
        billText.becomeFirstResponder()
        
        for index in 0...2 {
            percentSegment.setTitle(String(format: "%0.0f%%", settings.percentArray[index] * 100), forSegmentAtIndex: index)
        }
       
        
        percentSegment.selectedSegmentIndex = settings.defaultIndex
    
        updateTip()
        updateTheme()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTip() {
        let billAmount = Double(billText.text!) ?? 0
        let tipAmount = billAmount * settings.percentArray[settings.defaultIndex]
        let totalAmount = billAmount + tipAmount
        
        tipValue.text = formater.stringFromNumber(tipAmount)
        totalValue.text = formater.stringFromNumber(totalAmount)
        
        self.totalValue.alpha = 0.2
        UIView.animateWithDuration(0.5, animations: {
            self.totalValue.alpha = 1
        })
    }
    
    func updateTheme() {
        if (settings.darkTheme == true) {
            view.backgroundColor = UIColor.darkGrayColor()
            
            tipLabel.textColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.whiteColor()
            billLabel.textColor = UIColor.whiteColor()
            tipValue.textColor = UIColor.whiteColor()
            totalValue.textColor = UIColor.yellowColor()
            horizontalLine.backgroundColor = UIColor.whiteColor()
            percentSegment.tintColor = UIColor.yellowColor();
        }
        else {
            view.backgroundColor = UIColor.whiteColor()
            
            tipLabel.textColor = UIColor.darkTextColor()
            totalLabel.textColor = UIColor.darkTextColor()
            billLabel.textColor = UIColor.darkTextColor()
            tipValue.textColor = UIColor.darkTextColor()
            horizontalLine.backgroundColor = UIColor.darkTextColor()
            totalValue.textColor = blueColor
            percentSegment.tintColor = blueColor
        }
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        settings.defaultIndex = percentSegment.selectedSegmentIndex
        
        let value = Int64(billText.text!)
        if value == nil {
            billText.text = ""
        }
        else if value >= 0 {
            billText.text = String(value!)
        }
        
        updateTip()
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
//        view.endEditing(true);
    }
}