//
//  SettingsViewController.swift
//  TippyApp
//
//  Created by Van Do on 9/15/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var defaultSegment: UISegmentedControl!
    @IBOutlet var thisView: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        let index = userDefaults.integerForKey("default_tip")
        
        themeSwitch.on = userDefaults.boolForKey("default_theme")
        defaultSegment.selectedSegmentIndex = index
        
        updateTheme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        userDefaults.setInteger(defaultSegment.selectedSegmentIndex, forKey: "default_tip")
        
        userDefaults.synchronize()
    }

    @IBAction func changeTheme(sender: AnyObject) {
        userDefaults.setBool(themeSwitch.on, forKey: "default_theme")
        updateTheme()
    }
    
    func updateTheme() {
        if (userDefaults.boolForKey("default_theme") == true) {
            thisView.backgroundColor = UIColor.darkGrayColor()
            
            tipLabel.textColor = UIColor.whiteColor()
            darkThemeLabel.textColor = UIColor.whiteColor()
            defaultSegment.tintColor = UIColor.yellowColor()
        }
        else {
            thisView.backgroundColor = UIColor.whiteColor()
            
            tipLabel.textColor = UIColor.darkTextColor()
            darkThemeLabel.textColor = UIColor.darkTextColor()
            defaultSegment.tintColor = UIColor(red:CGFloat(23) / 255, green: CGFloat(122) / 255, blue: CGFloat(255) / 255, alpha: CGFloat(1))
        }
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
