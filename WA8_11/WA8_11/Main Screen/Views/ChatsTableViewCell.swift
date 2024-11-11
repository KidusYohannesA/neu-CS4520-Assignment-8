//
//  ChatsTableViewCell.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/11/24.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelText: UILabel!
    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelText()
        setupLabelDate()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = UIFont.boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelText.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2),
            labelText.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelText.heightAnchor.constraint(equalToConstant: 16),
            labelText.widthAnchor.constraint(lessThanOrEqualTo: labelName.widthAnchor),
            
            labelDate.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 2),
            labelDate.leadingAnchor.constraint(equalTo: labelText.leadingAnchor),
            labelDate.heightAnchor.constraint(equalToConstant: 16),
            labelDate.widthAnchor.constraint(lessThanOrEqualTo: labelName.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
