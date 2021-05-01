//
//  ViewController.swift
//  CutUpRefactorOOPPractice
//
//  Created by Geoffry Gambling on 4/26/21.
//

import UIKit



class ViewController: UIViewController, UITextViewDelegate {
    var cutUp: [String] = []
    let cutUpLogic = CutUpLogic()
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textView.delegate = self

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(goToEditingView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cut", style: .done, target: self, action: #selector(cutSelectionActionSheet))
    }
    

    @objc func cutText() {
       
        cutUp += cutUpLogic.cutUpBySelectedAmount(text: textView.text, chunkSize: 3)
        textView.text = ""
      
    }
    
    @objc func cutSelectionActionSheet() {
        
        if textView.text == "" {
            return
        }
        
        let prompt = UIAlertController(title: "Choose How You'd Like to Cut Your Text",
                                       message: nil,
                                       preferredStyle: .actionSheet)
        
        //Alert popover origin required for iPad
        prompt.popoverPresentationController?.sourceView = self.view
        prompt.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
      
        let byLineAction = UIAlertAction(title: "Single Lines", style: .default) { _ in
            self.cutUp += self.cutUpLogic.cutUpSeparatedByComponents(text: self.textView.text, separator: "\n")
            self.textView.text = ""
        }
        
        let byWordAction = UIAlertAction(title: "Single Words", style: .default) { _ in
            self.cutUp += self.cutUpLogic.cutUpSeparatedByComponents(text: self.textView.text, separator: " ")
            self.textView.text = ""
        }
        
        let byThreeWordsAction = UIAlertAction(title: "Every Third Word", style: .default) { _ in
            self.cutUp += self.cutUpLogic.cutUpBySelectedAmount(text: self.textView.text, chunkSize: 3)
            self.textView.text = ""
        }
        
        let byFiveWordsAction = UIAlertAction(title: "Every Fifth Word", style: .default) { _ in
            self.cutUp += self.cutUpLogic.cutUpBySelectedAmount(text: self.textView.text, chunkSize: 5)
            self.textView.text = ""
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(byLineAction)
        prompt.addAction(byWordAction)
        prompt.addAction(byThreeWordsAction)
        prompt.addAction(byFiveWordsAction)
        prompt.addAction(cancelAction)
        
        present(prompt, animated: true, completion: nil)
    }
    

    @objc func goToEditingView() {
        
        performSegue(withIdentifier: "EditingBoard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? EditingBoardViewController
        
        vc?.cutUp = cutUp
    }



}

