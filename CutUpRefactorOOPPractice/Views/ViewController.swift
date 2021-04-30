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
        let prompt = UIAlertController(title: "Choose How You'd Like to Cut Your Text",
                                       message: nil,
                                       preferredStyle: .actionSheet)
      
        let byLineAction = UIAlertAction(title: "Single Lines", style: .default) { (alert) in
            self.cutUp = self.cutUpLogic.cutUpSeparatedByComponents(text: self.textView.text, separator: "\n", alert)
            self.textView.text = ""
        }
        
        
//        let byWordAction = UIAlertAction(title: "Single Words", style: .default, handler: byWord)
//
//        let byFiveWordsAction = UIAlertAction(title: "Every Fifth Word", style: .default, handler: byFiveWords)
//
//        let byThreeWordsAction = UIAlertAction(title: "Every Third Word", style: .default, handler: byThreeWords)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(byLineAction)
//        prompt.addAction(byWordAction)
//        prompt.addAction(byFiveWordsAction)
//        prompt.addAction(byThreeWordsAction)
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

