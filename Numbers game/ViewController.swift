//
//  ViewController.swift
//  Numbers game
//
//  Created by Albero Nat on 2/7/16.
//  Copyright © 2016 Kipras Sederevicius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Setting screen variables' visibility
        self.NoMoreHints.alpha = 0
        self.Higher.alpha = 0
        self.Lower.alpha = 0
        self.Hint1.alpha = 0
        self.Hint2.alpha = 0
        self.Hint3.alpha = 0
        self.Victory.alpha = 0
        self.Loss.alpha = 0
        self.Rules.alpha = 1
        self.Intro.alpha = 1
        self.Lifes.text = "\(LifesCount) guesses"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize variables

    @IBOutlet weak var Victory: UILabel!
    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var Higher: UILabel!
    @IBOutlet weak var Lower: UILabel!
    @IBOutlet weak var Loss: UILabel!
    @IBOutlet weak var Hint1: UILabel!
    @IBOutlet weak var Hint2: UILabel!
    @IBOutlet weak var Hint3: UILabel!
    @IBOutlet weak var NoMoreHints: UILabel!
    @IBOutlet weak var Intro: UILabel!
    @IBOutlet weak var Rules: UILabel!
    @IBOutlet weak var Lifes: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var HintButton: UIButton!
    
    var HintCount = 0
    var LifesCount = 7
    let RandomNumber: Double = Double(arc4random_uniform(1000))
    var Guess: Double? {
        return Double(Input.text!)
    }


    // Guessing actions
    @IBAction func SubmitButton(sender: AnyObject) {
        // Correct guess, change to Victory screen mode
        if RandomNumber == Guess
        {
            self.NoMoreHints.alpha = 0
            self.Higher.alpha = 0
            self.Lifes.alpha = 0
            self.Lower.alpha = 0
            self.Hint1.alpha = 0
            self.Hint2.alpha = 0
            self.Hint3.alpha = 0
            self.Input.alpha = 0
            self.Rules.alpha = 0
            self.Victory.alpha = 1
            
            
        }
        // Ran out of attempts to guess, change to loss screen mode
        else if LifesCount < 2
        {
            self.NoMoreHints.alpha = 0
            self.Lifes.alpha = 0
            self.Higher.alpha = 0
            self.Lower.alpha = 0
            self.Hint1.alpha = 0
            self.Hint2.alpha = 0
            self.Hint3.alpha = 0
            self.Input.alpha = 0
            self.Rules.alpha = 0
            self.Loss.alpha = 1
        }
        // Actual number is higher than guessed, display "Higher" label
        else if RandomNumber > Guess
        {
            LifesCount = LifesCount - 1
            Lower.alpha = 0
            Higher.alpha = 0.5
            self.Lifes.text = "\(LifesCount) guesses"
        }
        // Actual number is lower than guessed, display "Lower" label
        else if RandomNumber < Guess
        {
            LifesCount = LifesCount - 1
            Higher.alpha = 0
            Lower.alpha = 0.5
            self.Lifes.text = "\(LifesCount) guesses"
        }
        
    }

    // Shows a hint about actual number when pressed
    @IBAction func HintButton(sender: AnyObject) {
        // Shows whether the actual number is even or not
        if HintCount == 0
        {
            self.Hint1.alpha = 1.0
            if RandomNumber % 2 == 0
            {
                self.Hint1.text = "It is an even number"
            }
            else
            {
                self.Hint1.text = "It is an odd number"
            }
        }
        // Shows whether the root of actual number is an integer
        if HintCount == 1
        {
            self.Hint2.alpha = 1.0
            if floor(sqrt(RandomNumber)) == sqrt(RandomNumber)
            {
                self.Hint2.text = "The root of this number is an integer"
            }
            else
            {
                self.Hint2.text = "The root of this number is not an integer. it has decimal points"
            }
        }
        // Shows one multiple of the actual number
        if HintCount == 2
        {
            self.Hint3.alpha = 1.0
            var numbers: [Double] = [2,3,4,5,6,7,8,9]
            var selector = Int(arc4random_uniform(UInt32(numbers.count)))
            while RandomNumber % numbers[selector] != 0
            {
                numbers.removeAtIndex(selector)
                selector = Int(arc4random_uniform(UInt32(numbers.count)))
            }
            self.Hint3.text = "\(numbers[selector]) is a multiple of this number"
        }
        if HintCount >= 3
        {
            UIView.animateWithDuration(1.5, animations: {
                self.NoMoreHints.alpha = 1.0})
        }
        HintCount = HintCount + 1
        }
}





