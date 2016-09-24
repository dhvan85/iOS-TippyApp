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
    
    @IBOutlet weak var currentPercentText: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
    
        settings = (userDefaults.objectForKey("default_settings") as? Settings) ?? Settings()
        
        themeSwitch.on = settings.darkTheme
        defaultSegment.selectedSegmentIndex = settings.defaultIndex
        
        for index in 0...2
        {
         defaultSegment.setTitle(String(settings.percentArray[index] * 100) + "%", forSegmentAtIndex: index)
        }
        
        updateTheme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
    
        userDefaults.setObject(settings, forKey: "default_settings")
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        settings.defaultIndex = defaultSegment.selectedSegmentIndex
    }

    @IBAction func currentPercentChange(sender: AnyObject) {
        defaultSegment.setTitle(currentPercentText.text ?? "0" + "%", forSegmentAtIndex: settings.defaultIndex)
        settings.percentArray[settings.defaultIndex] = Double(currentPercentText.text ?? "0")! / 100.0
    }
    
    @IBAction func changeTheme(sender: AnyObject) {
        updateTheme()
        settings.darkTheme = themeSwitch.on
    }
    
    func updateTheme() {
        if (settings.darkTheme == true) {
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
