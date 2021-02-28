//
//  MainViewController.swift
//  RandomAnswer
//
//  Created by Duc'sMacBook on 8/20/20.
//  Copyright © 2020 VSHR. All rights reserved.
//

import UIKit
import SnapKit

class RanWordsViewController: UIViewController, UITextFieldDelegate {

    let minWordsLB = UILabel()
    let maxWordsLB = UILabel()
    let minWordsTF = UITextField()
    let maxWordsTF = UITextField()
    let lastWordsLB = UILabel()
    
    let resultLB = UILabel()
    
    var minValue = 0
    var maxValue = 0
    var result = ""
    var beforeResult = ""
    
    
    let generateBT = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Random Words"
        
        setupContraint()
        self.hideKeyboardWhenTappedAround()
    }
    

    func setupContraint(){
        
        let vw_top = UIView()
        self.view.addSubview(vw_top)
        vw_top.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        vw_top.addSubview(resultLB)
        resultLB.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let vw = UIView()
        self.view.addSubview(vw)
        vw.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(generateBT)
        generateBT.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalToSuperview().dividedBy(15)
            make.bottom.equalTo(vw.snp.top)
            make.centerX.equalToSuperview()
        }
        
        vw.addSubview(minWordsLB)
        minWordsLB.snp.makeConstraints { (make) in
            make.trailing.equalTo(vw.snp.leading)
            make.centerY.equalToSuperview()
        }
        
        vw.addSubview(minWordsTF)
        minWordsTF.snp.makeConstraints { (make) in
            make.leading.equalTo(minWordsLB.snp.trailing)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(8)
            make.width.equalToSuperview().dividedBy(3.5)
        }
        
        self.view.addSubview(maxWordsLB)
        maxWordsLB.snp.makeConstraints { (make) in
            make.trailing.equalTo(vw.snp.trailing)
            make.centerY.equalTo(minWordsTF)
        }
        
        self.view.addSubview(maxWordsTF)
        maxWordsTF.snp.makeConstraints { (make) in
            make.leading.equalTo(maxWordsLB.snp.trailing)
            make.height.width.equalTo(minWordsTF)
            make.centerY.equalTo(maxWordsLB)
        }
        
        self.view.addSubview(lastWordsLB)
        lastWordsLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultLB.snp.bottom).offset(20)
        }
        
        minWordsLB.text = "From:  "
        
        resultLB.font = UIFont.monospacedDigitSystemFont(ofSize: 200, weight: .semibold)
        
        minWordsTF.layer.borderWidth = 0.5
        minWordsTF.layer.borderColor = UIColor.gray.cgColor
        minWordsTF.layer.cornerRadius = 5
        minWordsTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: minWordsTF.frame.height))
        minWordsTF.leftViewMode = .always
        minWordsTF.delegate = self
        
        maxWordsLB.text = "To:  "
        
        maxWordsTF.layer.borderWidth = 0.5
        maxWordsTF.layer.borderColor = UIColor.gray.cgColor
        maxWordsTF.layer.cornerRadius = 5
        maxWordsTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: minWordsTF.frame.height))
        maxWordsTF.leftViewMode = .always
        maxWordsTF.delegate = self
        
        generateBT.layer.cornerRadius = 5.0
        generateBT.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 102/255, alpha: 1)
        generateBT.setAttributedTitle(NSAttributedString.init(string: "Generate", attributes: [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        
        generateBT.addTarget(self, action: #selector(generated), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func generated(){
        generateBT.animated()
        
        // check textFiled nil or not
        checkNull()
        //generate from min to max
        if(minValue<maxValue){
            maxWordsTF.layer.borderColor = UIColor.gray.cgColor
            minWordsTF.layer.borderColor = UIColor.gray.cgColor
            
            //generate from min to max
            let number = Int.random(in: minValue...maxValue)
            
            //convert number to ascii string
            DispatchQueue.main.async {
                self.resultLB.isHidden = true
                self.lastWordsLB.isHidden = true
                self.beforeResult = self.result
                self.result = ""
                self.result.append(Character(Unicode.Scalar(number)!))
                self.resultLB.text = self.result
                self.lastWordsLB.text = "Word before is: \(self.beforeResult)"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.resultLB.isHidden = false
                self.lastWordsLB.isHidden = false
            }
            
        }else{
            minWordsTF.layer.borderColor = UIColor.systemRed.cgColor
            maxWordsTF.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    // check nil function
    func checkNull(){
        
        if(minWordsTF.text! == "" || maxWordsTF.text! == ""){
            if(minWordsTF.text == ""){
                minWordsTF.layer.borderColor = UIColor.systemRed.cgColor
            }else{
                minWordsTF.layer.borderColor = UIColor.gray.cgColor
            }
            if(maxWordsTF.text == ""){
                maxWordsTF.layer.borderColor = UIColor.systemRed.cgColor
            }else{
                maxWordsTF.layer.borderColor = UIColor.gray.cgColor
            }
        }else{
            checkUppercase(valueMin: minWordsTF.text!, valueMax: maxWordsTF.text!)
        }
    }
    
    // kiểm tra ký tự hợp lệ.
    
    func checkUppercase(valueMin: String, valueMax: String){
        
        if(Character(valueMin).asciiValue! <= UInt8(90) && Character(valueMin).asciiValue! >= UInt8(65)){
            
            minValue = Int(Character(valueMin).asciiValue!)
            
            
        }else if(Character(valueMin).asciiValue! <= UInt8(122) && Character(valueMin).asciiValue! >= UInt8(97) ){
        
            minValue = Int(Character(valueMin).asciiValue!) - 32
            
            
        }else{
            minWordsTF.layer.borderColor = UIColor.systemRed.cgColor
            minValue = 0
        }
        
        if(Character(valueMax).asciiValue! <= UInt8(90) && Character(valueMax).asciiValue! >= UInt8(65)){
            
            maxValue = Int(Character(valueMax).asciiValue!)
            
            
        }else if(Character(valueMax).asciiValue! <= UInt8(122) && Character(valueMax).asciiValue! >= UInt8(97) ){
        
            maxValue = Int(Character(valueMax).asciiValue!) - 32
            
            
        }else{
            maxWordsTF.layer.borderColor = UIColor.systemRed.cgColor
            maxValue = 0
        }
        
    }
    
    // đẩy màn hình khi bàn phím hiện.
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 1
    }
    
    
}
