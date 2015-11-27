//
//  ViewController.swift
//  Silly Song
//
//  Created by Tanveer Bashir on 11/23/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    let vowel = "aeiou\u{00E4}\u{00EB}\u{00EF}\u{00F6}\u{00DC}" // vowel and Diaeresis
    let specialChar = "bfm" // special case
    var bananaFanaTemplate:String = ""
    var specialSong:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //default template
        bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>", "\n",
            "Banana Fana Fo F<SHORT_NAME>","\n",
            "Me My Mo M<SHORT_NAME>","\n",
            "<FULL_NAME>"].joinWithSeparator("")
        
        //This is presented if name starts with "b", "f", "m"
        specialSong = [
            "<FULL_NAME>, <FULL_NAME>, Bo-<SHORT_NAME>", "\n",
            "Banana Fana Fo-<SHORT_NAME>","\n",
            "Me My Mo-<SHORT_NAME>","\n",
            "<FULL_NAME>"].joinWithSeparator("")
    }
    
    // MARK:- Action methods
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        let randNumber = Int(arc4random_uniform(6))
        if let name = nameField.text {
            if name.isEmpty {
                lyricsView.font = UIFont(name: "Papyrus", size: 24.0)
                lyricsView.text = "Name field can not be blank!"
                
            } else {
                let nameCount = name.characters.count
                let song = lyricsFromName(name.capitalizedString)
                attributedStyleString(nameCount, randNumber: randNumber, finalSong: song)
            }
        }
    }
    
    //MARK:- Helper methods
    
    func shortName(name:String)-> String {
        return findCharacterInRange(name)
    }
    
    func lyricsFromName(fullName: String) -> String {
        return creatSongTemplateFromName(fullName)
    }
    
    //Dismiss keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //Attributed string
    func attributedStyleString(count:Int, randNumber:Int, finalSong:String){
        let attributedString = NSMutableAttributedString(string: finalSong)
        attributedString.addAttribute(NSFontAttributeName,
            value: UIFont(
            name:"BradleyHandITCTT-Bold",
            size: 27.0)!,
            range: NSRange(
            location:count,
            length: attributedString.length - count))
        
        attributedString.addAttribute(NSForegroundColorAttributeName,
            value: color(randNumber),
            range: NSRange(
            location:0,
            length: count))
        
        attributedString.addAttribute(NSForegroundColorAttributeName,
            value: color(randNumber - 1),
            range: NSRange(
            location: count,
            length:attributedString.length - count))
        
        attributedString.addAttribute(NSFontAttributeName,
            value: UIFont(
            name:"BradleyHandITCTT-Bold",
            size: 28.0)!,
            range: NSRange(
            location:0,
            length: count ))
        
        lyricsView.attributedText = attributedString
        lyricsView.textAlignment = .Center
        nameField.text = ""
    }
    
    // returns short name
    func findCharacterInRange(name:String)->String{
        let vowelCharSet = NSCharacterSet(charactersInString: vowel)
        let specialCharSet = NSCharacterSet(charactersInString: specialChar)
        let lowerCaseName = name.lowercaseString
        
        //check if first letter is a, f, m
        for char in lowerCaseName.characters {
            switch char {
            case "b", "f", "m":
                if let charRange = lowerCaseName.rangeOfCharacterFromSet(specialCharSet) {
                    return lowerCaseName.substringFromIndex(charRange.startIndex.successor())
                }
            default:
                if let charRange = lowerCaseName.rangeOfCharacterFromSet(vowelCharSet) {
                    return lowerCaseName.substringFromIndex(charRange.startIndex)
                }
            }
        }
        return lowerCaseName
    }
    
    // returns Silly Song from given name
    func creatSongTemplateFromName(fullName:String)->String{
        let lowercaseFullName = fullName.lowercaseString
        var finalTemplate:String = ""
        for char in lowercaseFullName.characters {
            switch char {
            case "b", "f", "m":
                finalTemplate = specialSong.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName).stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName(fullName))
                return finalTemplate
            default:
                finalTemplate = bananaFanaTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName).stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName(fullName))
            }
        }
        return finalTemplate
    }
    
    //random text color
    func color(number:Int)->UIColor{
        switch number{
        case 0 :
            return UIColor.whiteColor()
        case 1:
            return UIColor.orangeColor()
        case 2:
            return UIColor.greenColor()
        case 3:
            return UIColor.purpleColor()
        case 4:
            return UIColor.magentaColor()
        case 5:
            return UIColor.redColor()
            
        default:
            return UIColor.lightTextColor()
        }
    }
}


