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
        
        table.register(WordTableViewCell.nib(), forCellReuseIdentifier: WordTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        self.searchBar.delegate = self
        
        searchBar.addTarget(self, action: #selector(checkAndDisplayError(textfield:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    // Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // Return Key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWord()
        return (true)
    }
    
    func searchWord(){
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        let query = text
        
        words.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://myawesomedictionary.herokuapp.com/words?q=\(query)")!,
                                   completionHandler: {data, response, error in
                                    guard let data = data, error == nil else {
                                        return
                                    }
                                    
                                    // Data convert
                                    var result: WordResult?
                                    
                                    do {
                                        result = try JSONDecoder().decode(WordResult.self, from: data)
                                    }
                                    
                                    catch {
                                        print("error")
                                    }
                                    
                                    guard let endResult = result else {
                                        return
                                    }
                                    
                                    // Update array
                                    // SOMETHING MISSING HERE (newWord for word)
                                    //let newWord = endResult.word
                                    let newWords = endResult.definitions
                                    self.words.append(contentsOf: newWords)
                                    
                                    // Refresh
                                    DispatchQueue.main.async {
                                        self.table.reloadData()
                                    }
                                    
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as! WordTableViewCell
        cell.configure(with: words[indexPath.row])
        return cell
    }
    
    @objc func checkAndDisplayError (textfield: UITextField) {
        if (textfield.text?.count ?? 0 < 3) {
            errorLabel.text = "Please enter more than 2 characters"
        }
        
        // if (ga ada hasil)
        
        else {
            errorLabel.text = ""
        }
    }
}

struct WordResult: Codable {
    let word: String
    let definitions: [Word]
}

struct Word: Codable {
    let image_url: String
    let type: String
    let definition: String
}
