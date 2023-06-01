//
//  FooterView.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 26.05.23.
//

import UIKit

class FooterView: UIView {

    let addFileButton:UIButton = {
        let button = UIButton()
        button.setTitle("qqq", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let writeMessageTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "placeholder"
        tf.backgroundColor = .green
        return tf
    }()
    
    let tempButton:UIButton = {
        let button = UIButton()
        button.setTitle("rty", for: .normal)
        button.backgroundColor = .green
        return button
    }()
           
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupUI(){
        self.backgroundColor = .red
        self.addSubview(addFileButton)
        self.addSubview(writeMessageTextField)
        self.addSubview(tempButton)
                
        addFileButton.translatesAutoresizingMaskIntoConstraints = false
        writeMessageTextField.translatesAutoresizingMaskIntoConstraints = false
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        
                                        
        NSLayoutConstraint.activate([
                       
            addFileButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            addFileButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            addFileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            addFileButton.widthAnchor.constraint(equalToConstant: 40),
            
            writeMessageTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            writeMessageTextField.leftAnchor.constraint(equalTo: addFileButton.rightAnchor, constant: 10),
            writeMessageTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            writeMessageTextField.widthAnchor.constraint(equalToConstant: 240),
            
            tempButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            tempButton.leftAnchor.constraint(equalTo: writeMessageTextField.rightAnchor, constant: 10),
            tempButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            tempButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            ])
    }
}
