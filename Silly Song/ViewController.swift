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
    var attributedString = NSMutableAttributedString()
    var finalSongString:String = ""
    //Silly Song Template
    var bananaFanaTemplate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>", "\n",
            "Banana Fana Fo F<SHORT_NAME>","\n",
            "Me My Mo M<SHORT_NAME>","\n",
            "<FULL_NAME>"].joinWithSeparator("")
    }
    // MARK:- Action methods
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        let randNumber = Int(arc4random_uniform(6))
        if let name = nameField.text{
            if name.isEmpty {
                lyricsView.font = UIFont(name: "Papyrus", size: 24.0)
                lyricsView.text = "Name field can not be blank!"
                
            }else {
                
                let nameCount = name.characters.count
                let song = lyricsFromName(bananaFanaTemplate, fullName: name.capitalizedString)
                attributedStyleString(nameCount, randNumber: randNumber, finalSong: song)
            }
        }
    }
    
    //MARK:- Helper methods
    
    //ShortName returns short name by removing Consonant before first Vowel
    func shortName(name:String)-> String {
        let vowel = "aeiou\u{00E4}\u{00EB}\u{00EF}\u{00F6}\u{00DC}"
        let vowelCharSet = NSCharacterSet(charactersInString: vowel)
        let lowerCaseName = name.lowercaseString
        if let charRange = lowerCaseName.rangeOfCharacterFromSet(vowelCharSet) {
            return lowerCaseName.substringFromIndex(charRange.startIndex)
        }
        return lowerCaseName
    }
    
    //lyricsFromName creates Silly Song from given name
    func lyricsFromName(lyricTemplate: String, fullName: String) -> String {
        let finalTemplate = lyricTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName).stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName(fullName))
        return finalTemplate
    }
    
    //Dismiss keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //random text color
    func color(number:Int)->UIColor{
        switch number{
        case 0 :
            return UIColor.redColor()
        case 1:
            return UIColor.greenColor()
        case 2:
            return UIColor.orangeColor()
        case 3:
            return UIColor.whiteColor()
        case 4:
            return UIColor.purpleColor()
        case 5:
            return UIColor.yellowColor()
        default:
            return UIColor.lightTextColor()
        }
    }
    
    //Attributed string
    func attributedStyleString(count:Int, randNumber:Int, finalSong:String){
        attributedString = NSMutableAttributedString(string: finalSong)
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
}


