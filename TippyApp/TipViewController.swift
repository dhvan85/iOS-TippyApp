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
    @IBOutlet var thisView: UIView!
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var tipValue: UILabel!
    let percentArray = [0.18, 0.2, 0.25]
    let currentLocale = NSLocale.currentLocale()
    let formater = NSNumberFormatter()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.locale = currentLocale
        formater.numberStyle = .CurrencyStyle
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TipViewController.willEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func willEnterForeground(notification: NSNotification!) {
        let date = userDefaults.objectForKey("last_time") as? NSDate

        if date != nil && date!.timeIntervalSinceNow < -60 {
            billText.text = ""
            updateTip()
        }
    }
    
    deinit {
       NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        let index = userDefaults.integerForKey("default_tip")
        
        billText.becomeFirstResponder()
        percentSegment.selectedSegmentIndex = index
        
        updateTip()
        updateTheme()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTip(){
        let billAmount = Double(billText.text!) ?? 0
        let tipAmount = billAmount * percentArray[percentSegment.selectedSegmentIndex]
        let totalAmount = billAmount + tipAmount
        
        tipValue.text = formater.stringFromNumber(tipAmount)
        totalValue.text = formater.stringFromNumber(totalAmount)
        
        self.totalValue.alpha = 0.2
        UIView.animateWithDuration(0.5, animations: {
            self.totalValue.alpha = 1
        })
    }
    
    func updateTheme() {
        if (userDefaults.boolForKey("default_theme") == true) {
            thisView.backgroundColor = UIColor.darkGrayColor()
            
            tipLabel.textColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.whiteColor()
            billLabel.textColor = UIColor.whiteColor()
            tipValue.textColor = UIColor.whiteColor()
            totalValue.textColor = UIColor.yellowColor()
            horizontalLine.backgroundColor = UIColor.whiteColor()
            percentSegment.tintColor = UIColor.yellowColor();
        }
        else {
            thisView.backgroundColor = UIColor.whiteColor()
            
            tipLabel.textColor = UIColor.darkTextColor()
            totalLabel.textColor = UIColor.darkTextColor()
            billLabel.textColor = UIColor.darkTextColor()
            tipValue.textColor = UIColor.darkTextColor()
            totalValue.textColor = UIColor(red:CGFloat(23) / 255, green: CGFloat(122) / 255, blue: CGFloat(255) / 255, alpha: CGFloat(1))
            horizontalLine.backgroundColor = UIColor.darkTextColor()
            percentSegment.tintColor = UIColor(red:CGFloat(23) / 255, green: CGFloat(122) / 255, blue: CGFloat(255) / 255, alpha: CGFloat(1))
        }
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        userDefaults.setInteger(percentSegment.selectedSegmentIndex, forKey: "default_tip")
        
        updateTip()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
}