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

    @IBAction func PerformRoll(sender: AnyObject)
    {
        var total: Int = 0;
        total += DoRoll(d4Amount, oe: d4OE, max: 4);
        total += DoRoll(d6Amount, oe: d6OE, max: 6);
        total += DoRoll(d8Amount, oe: d8OE, max: 8);
        total += DoRoll(d10Amount, oe: d10OE, max: 10);
        total += DoRoll(d12Amount, oe: d12OE, max: 12);
        total += DoRoll(d20Amount, oe: d20OE, max: 20);
        total += DoRoll(d100Amount, oe: d100OE, max: 100);
        total += DoRoll(d1000Amount, oe: d1000OE, max: 1000);
        OutputText.string = OutputText.string! + "Total: " + String(total) + "\n";
        OutputText.string = OutputText.string! + "--------------------------------------\n";
        OutputText.scrollToEndOfDocument(sender);
    }
    
    private func DoRoll(amount: NSTextField, oe: NSButton, max: Int) -> Int
    {
        let nrRolls: Int! = Int(amount.stringValue);
        var total: Int = 0;
        if(nrRolls != nil && nrRolls != 0)
        {
            OutputText.string = OutputText.string! + "Now rolling d" + String(max) + ": ";
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
                    else
                    {
                        specialMax = 95;
                    }
                }

                repeat
                {
                    randomNr = Int(arc4random_uniform(UInt32(max))) + 1;
                    total += randomNr;
                    if(textStr != "") { textStr = textStr + "+"; }
                    textStr = textStr + String(randomNr);
                } while(oe.state == NSOnState && randomNr >= specialMax)
                
                OutputText.string = OutputText.string! + textStr + " ";
            }
            OutputText.string = OutputText.string! + "\n";
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

