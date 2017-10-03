//
//  ViewController.swift
//  TextFilter
//
//  Created by lixinxing on 2017/10/2.
//  Copyright © 2017年 xx-li. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSearchFieldDelegate {

    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var textView: NSTextView!
    
    var resourceString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func openCotentWithURL(url: URL) {
        let str = try! String.init(contentsOf: url)
        textView.string = str
        resourceString = str
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        
        let openPanel = NSOpenPanel()
        openPanel.prompt = "打开"
        openPanel.resolvesAliases = true;
        openPanel.allowsMultipleSelection = false;
        openPanel.canChooseDirectories = false;
        openPanel.beginSheetModal(for: self.view.window!) { (result : NSApplication.ModalResponse) in
            guard result == NSApplication.ModalResponse.OK else { return }
            print(openPanel.url!)
            self.openCotentWithURL(url: openPanel.url!)
        }
    }
    
    func filterWithKeywork(keywork:String) -> String {
        
        let lines = resourceString.components(separatedBy: .newlines)
        var resultStr: String = ""
        for str in lines {
            if str.contains(keywork) {
                resultStr = resultStr + str + "\n"
            }
        }
        return resultStr
        
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(insertNewline(_:)) {
            print(textView.string)
            
            let resultStr = self.filterWithKeywork(keywork: textView.string);
            self.textView.string = resultStr;
            return true
        } else if commandSelector == #selector(deleteBackward(_:)) {
            self.textView.string = resourceString;
            textView.string = "";
            return true
        }
        
        return false
    }
}

