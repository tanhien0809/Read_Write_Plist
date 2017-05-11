//
//  ViewController.swift
//  Thuc hanh 3
//
//  Created by TTB on 5/11/17.
//  Copyright © 2017 TTB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let item: String = "item"
    var itemValue: String?
    
    @IBOutlet weak var itemTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPlist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveItem(_ sender: Any) {
        self.savePlist(value: itemTxt.text!)
    }
    
    
    func savePlist(value:String){
        
        let paths = NSSearchPathForDirectoriesInDomains(
            
            .documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        
        let path = documentDirectory.appending("vidu.plist")
        
        let dict: NSMutableDictionary = [:]
        
        dict.setObject(value, forKey: item as NSString)
        
        dict.write(toFile: path, atomically: false)
    }
    
    func getPlist() {
        
        let paths = NSSearchPathForDirectoriesInDomains(
            
            .documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        
        let path = documentDirectory.appending("vidu.plist")
        
        let fileManager = FileManager.default
        
        if(!fileManager.fileExists(atPath: path)){
            
            if let bundlePath = Bundle.main.path(forResource: "vidu", ofType: "plist"){
                
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                
                do{
                    
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                    
                    
                }
                catch{
                    
                    print("Bi loi roi")
                    
                }
                
            }else{
                
                print("file plist not found")
                
            }
        }else{
            
            print("file exists!")
            
        }
        
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        print("My plist is ->\(resultDictionary?.description)")
        
        let dictionaries = NSDictionary(contentsOfFile: path)
        
        if let dict = dictionaries {
            
            itemValue = dict.object(forKey: item) as! String
            
            itemTxt.text = itemValue
            
        }
        
    }
    
}

