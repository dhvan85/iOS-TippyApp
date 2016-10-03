//
//  SettingsViewController.swift
//  TippyApp
//
//  Created by Van Do on 9/15/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var thisView: UIView!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var percentSegment: UISegmentedControl!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!

    @IBOutlet weak var percentText: UITextField!
    
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("default_settings") as? NSData {
            settings = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Settings
        }
        
        themeSwitch.on = settings.darkTheme
        percentSegment.selectedSegmentIndex = settings.defaultIndex
        
        for index in 0...2 {
            percentSegment.setTitle(String(format: "%0.0f%%", settings.percentArray[index] * 100), forSegmentAtIndex: index)
        }
        
        percentText.text = String(format: "%0.0f", (settings.percentArray[settings.defaultIndex] * 100.0))

        updateTheme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        settings.percentArray.sortInPlace()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data  = NSKeyedArchiver.archivedDataWithRootObject(settings)
        
        userDefaults.setObject(data, forKey: "default_settings")
    }
    
    @IBAction func onPercentSegment_ValueChanged(sender: AnyObject) {
        settings.defaultIndex = percentSegment.selectedSegmentIndex
        percentText.text = String(format: "%0.0f", (settings.percentArray[settings.defaultIndex] * 100.0))
    }

    @IBAction func onPercentText_EditChanged(sender: AnyObject) {
        percentSegment.setTitle((percentText.text! == "" ? "0" : percentText.text!) + "%", forSegmentAtIndex: settings.defaultIndex)
        settings.percentArray[settings.defaultIndex] = (Double(percentText.text!) ?? 0)  / 100.0
    }
    
    @IBAction func onThemeSwitch_Toggle(sender: AnyObject) {
        settings.darkTheme = themeSwitch.on
        updateTheme()
    }
    
    func updateTheme() {
        if (settings.darkTheme == true) {
            thisView.backgroundColor = UIColor.darkGrayColor()
            
            tipLabel.textColor = UIColor.whiteColor()
            darkThemeLabel.textColor = UIColor.whiteColor()
            percentSegment.tintColor = UIColor.yellowColor()
        }
        else {
            thisView.backgroundColor = UIColor.whiteColor()
            
            tipLabel.textColor = UIColor.darkTextColor()
            darkThemeLabel.textColor = UIColor.darkTextColor()
            percentSegment.tintColor = UIColor(red:CGFloat(23) / 255, green: CGFloat(122) / 255, blue: CGFloat(255) / 255, alpha: CGFloat(1))
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
