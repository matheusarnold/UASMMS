//
//  WordTableViewCell.swift
//  UASMMS
//
//  Created by Matheus Arnold on 16/02/21.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    @IBOutlet var wordImage: UIImageView!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var wordTypeLabel: UILabel!
    @IBOutlet var wordDefLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static let identifier = "WordTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WordTableViewCell", bundle: nil)
    }
    
    func configure(with model: WordResult){
        self.wordLabel.text = model.word
    }
    
    func configure(with model: Word) {
        let url = model.image_url
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.wordImage.image = UIImage(data: data)
        }
        
        self.wordTypeLabel.text = model.type
        self.wordDefLabel.text = model.definition
        
    }
    
}
