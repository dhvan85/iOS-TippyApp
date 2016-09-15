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
    let percentages = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateTip(){
        let billValue = Double(billText.text!) ?? 0
        let tipValue = billValue * percentages[percentSegment.selectedSegmentIndex]
        let totalValue = billValue + tipValue
        
        tipLabel.text = String(format: "$%.2f", tipValue)
        totalLabel.text = String(format: "$%.2f", totalValue)
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaults.integerForKey("default_tip")
        
        percentSegment.selectedSegmentIndex = index
        updateTip()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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