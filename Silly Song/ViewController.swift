//
//  ViewController.swift
//  Silly Song
//
//  Created by Tanveer Bashir on 11/23/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Silly Song Template
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>\n",
        "Banana Fana Fo F<SHORT_NAME>\n",
        "Me My Mo M<SHORT_NAME>\n",
        "<FULL_NAME>"].joinWithSeparator("")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    var attributedString:NSMutableAttributedString = NSMutableAttributedString()
    var finalSongString:String = ""
    
    // MARK:- Action methods
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if let name = nameField.text{
            if name != "" {
               lyricsView.attributedText = lyricsFromName(bananaFanaTemplate, fullName: name.capitalizedString)
                 lyricsView.font = UIFont(name: "Papyrus", size: 27)
                lyricsView.textAlignment = .Center
            } else {
                lyricsView.text = "Name field can not be blank!"
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
    func lyricsFromName(lyricTemplate: String, fullName: String) -> NSMutableAttributedString {
        let replaceFullName = lyricTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
        let finalTemplate = replaceFullName.stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName(fullName))
        
        //Attributed String
        let attributedSong = NSMutableAttributedString(string: finalTemplate)
        let attrubutedString = [NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: UIColor.redColor()]
        attributedSong.setAttributes(attrubutedString, range: NSRange(location: 0, length: finalTemplate.characters.count - finalTemplate.characters.count + 1))
        return attributedSong
    }
    
    //Dismiss keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

