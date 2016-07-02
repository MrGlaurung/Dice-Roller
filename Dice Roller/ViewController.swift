//
//  ViewController.swift
//  Dice Roller
//
//  Created by Anders Lidén on 2016-01-09.
//  Copyright © 2016 Anders Lidén. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
    @IBOutlet weak var d4Amount: NSTextField!
    @IBOutlet weak var d6Amount: NSTextField!
    @IBOutlet weak var d8Amount: NSTextField!
    @IBOutlet weak var d10Amount: NSTextField!
    @IBOutlet weak var d12Amount: NSTextField!
    @IBOutlet weak var d20Amount: NSTextField!
    @IBOutlet weak var d100Amount: NSTextField!
    @IBOutlet weak var d1000Amount: NSTextField!
    @IBOutlet weak var d4OE: NSButton!
    @IBOutlet weak var d6OE: NSButton!
    @IBOutlet weak var d8OE: NSButton!
    @IBOutlet weak var d10OE: NSButton!
    @IBOutlet weak var d12OE: NSButton!
    @IBOutlet weak var d20OE: NSButton!
    @IBOutlet weak var d100OE: NSButton!
    @IBOutlet weak var d1000OE: NSButton!
    @IBOutlet var OutputText: NSTextView!
    @IBOutlet weak var OutputScrollView: NSScrollView!
    @IBOutlet weak var CleanUp: NSButton!

    @IBAction func PerformRoll(sender: AnyObject)
    {
        var total: Int = 0;
        let dice:[NSTextField:NSArray] = [
                d4Amount:[d4OE, 4],
                d6Amount:[d6OE, 6],
                d8Amount:[d8OE, 8],
                d10Amount:[d10OE, 10],
                d12Amount:[d12OE, 12],
                d20Amount:[d20OE, 20],
                d100Amount:[d100OE, 100],
                d1000Amount:[d1000OE, 1000]
            ];
        
        for (die, dieArray) in dice
        {
            total += DoRoll(die, oe: dieArray[0] as! NSButton, max: dieArray[1] as! Int);
        }
        OutputText.string! += "Total: " + String(total) + "\n";
        OutputText.string! += "--------------------------------------\n";
        OutputText.scrollToEndOfDocument(sender);
    }
    
    @IBAction func CleanOutput(sender: AnyObject)
    {
        OutputText.string = "";
    }
    
    private func DoRoll(amount: NSTextField, oe: NSButton, max: Int) -> Int
    {
        let nrRolls: Int! = Int(amount.stringValue);
        var total: Int = 0;
        if(nrRolls != nil && nrRolls != 0)
        {
            OutputText.string! += "Now rolling d" + String(max) + ": ";
            for(var i: Int = 0; i < nrRolls; i++)
            {
                var randomNr: Int, specialMax: Int;
                var textStr: String = "";
                
                specialMax = max;
                if(max >= 100)
                {
                    if(max > 100)
                    {
                        specialMax = 995;
                    }
                    else if(max > 99)
                    {
                        specialMax = 95;
                    }
                    else
                    {
                        specialMax = max - 1;
                    }
                }

                repeat
                {
                    randomNr = Int(arc4random_uniform(UInt32(max))) + 1;
                    total += randomNr;
                    if(textStr != "") { textStr = textStr + "+"; }
                    textStr = textStr + String(randomNr);
                } while(oe.state == NSOnState && randomNr >= specialMax)
                
                OutputText.string! += textStr + " ";
            }
            OutputText.string! += "= " + String(total) + "\n";
        }
        
        return total;
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject?
    {
        didSet
        {
            // Update the view, if already loaded.
        }
    }


}

