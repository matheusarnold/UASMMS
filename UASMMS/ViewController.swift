//
//  ViewController.swift
//  UASMMS
//
//  Created by Matheus Arnold on 15/02/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var table: UITableView!
    
    var words = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.searchBar.delegate = self
        
        searchBar.addTarget(self, action: #selector(checkAndDisplayError(textfield:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    //Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    //Return Key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWord()
        return (true)
    }
    
    func searchWord(){
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    tableView.deselectRow(at: indexPath, animated: true)
    //}
    
    @objc func checkAndDisplayError (textfield: UITextField) {
        if (textfield.text?.count ?? 0 < 3) {
            errorLabel.text = "Please enter more than 2 characters"
        }
        else {
            errorLabel.text = ""
        }
    }
}

struct Word {
    
}
