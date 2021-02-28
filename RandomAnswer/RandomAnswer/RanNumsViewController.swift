//
//  RanNumsViewController.swift
//  RandomAnswer
//
//  Created by Duc'sMacBook on 8/20/20.
//  Copyright © 2020 VSHR. All rights reserved.
//

import UIKit

class RanNumsViewController: UIViewController {

    let minNumsLB = UILabel()
    let maxNumsLB = UILabel()
    let minNumsTF = UITextField()
    let maxNumsTF = UITextField()
    let lastNumsLB = UILabel()
    
    let intBT = UIButton()
    let DoubleBT = UIButton()
     
    let resultLB = UILabel()
     
    var minValueI = 0
    var maxValueI = 0
    
    var minValueD = 0.0
    var maxValueD = 0.0
    
    var isInt = true
    
    var result = 0.0
    var beforeResult = ""
     
     
    let generateBT = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Random Numbers"
        setupContraint()
        hideKeyboardWhenTappedAround()
        typeRandom(isInteger: true)
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
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.35)
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        let vw = UIView()
        self.view.addSubview(vw)
        vw.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
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
        
        vw.addSubview(minNumsTF)
        minNumsTF.snp.makeConstraints { (make) in
            make.bottom.equalTo(vw.snp.centerY).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().dividedBy(8)
            make.width.equalTo(self.view).dividedBy(2)
        }
        
        vw.addSubview(minNumsLB)
        minNumsLB.snp.makeConstraints { (make) in
            make.bottom.equalTo(minNumsTF.snp.top)
            make.centerX.equalToSuperview()
        }
        
        vw.addSubview(maxNumsLB)
        maxNumsLB.snp.makeConstraints { (make) in
            make.top.equalTo(vw.snp.centerY).offset(10)
            make.centerX.equalToSuperview()
        }
        
        vw.addSubview(maxNumsTF)
        maxNumsTF.snp.makeConstraints { (make) in
            make.top.equalTo(maxNumsLB.snp.bottom)
            make.height.width.equalTo(minNumsTF)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(lastNumsLB)
        lastNumsLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultLB.snp.bottom).offset(20)
        }
        
        self.view.addSubview(intBT)
        intBT.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.view.snp.centerX).offset(-10)
            make.top.equalTo(generateBT.snp.bottom).offset(10)
            make.width.equalToSuperview().dividedBy(4)
            make.bottom.equalTo(minNumsLB.snp.top).offset(-10)
        }
        
        self.view.addSubview(DoubleBT)
        DoubleBT.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.centerX).offset(10)
            make.width.height.equalTo(intBT)
            make.centerY.equalTo(intBT)
        }
        
        minNumsLB.text = "From:  "
        
        resultLB.font = UIFont.monospacedDigitSystemFont(ofSize: 90, weight: .semibold)
        resultLB.textAlignment = .center
        resultLB.lineBreakMode = .byWordWrapping
        resultLB.numberOfLines = 2
        
        minNumsTF.layer.borderWidth = 0.5
        minNumsTF.layer.borderColor = UIColor.gray.cgColor
        minNumsTF.layer.cornerRadius = 5
        minNumsTF.keyboardType = .decimalPad
        minNumsTF.textAlignment = .center
        
        maxNumsLB.text = "To:  "
        
        maxNumsTF.layer.borderWidth = 0.5
        maxNumsTF.layer.borderColor = UIColor.gray.cgColor
        maxNumsTF.layer.cornerRadius = 5
        maxNumsTF.keyboardType = .decimalPad
        maxNumsTF.textAlignment = .center
        
        generateBT.layer.cornerRadius = 5.0
        generateBT.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 102/255, alpha: 1)
        generateBT.setAttributedTitle(NSAttributedString.init(string: "Generate", attributes: [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        
        generateBT.addTarget(self, action: #selector(generated), for: .touchUpInside)
        
        intBT.addTarget(self, action: #selector(intBTAction), for: .touchUpInside)
        DoubleBT.addTarget(self, action: #selector(doubleBTAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func typeRandom(isInteger: Bool){
        
        if(isInteger == true){
            intBT.setAttributedTitle(NSAttributedString(string: "Int",attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
            intBT.layer.borderColor = UIColor.systemGreen.cgColor
            intBT.layer.borderWidth = 1
            intBT.layer.cornerRadius = 10
            DoubleBT.setAttributedTitle(NSAttributedString(string: "Double",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]), for: .normal)
            DoubleBT.layer.borderColor = UIColor.black.cgColor
            DoubleBT.layer.borderWidth = 1
            DoubleBT.layer.cornerRadius = 10
        }else{
            intBT.setAttributedTitle(NSAttributedString(string: "Int",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]), for: .normal)
            intBT.layer.borderColor =  UIColor.black.cgColor
            intBT.layer.borderWidth = 1
            intBT.layer.cornerRadius = 10
            DoubleBT.setAttributedTitle(NSAttributedString(string: "Double",attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
            DoubleBT.layer.borderColor = UIColor.systemGreen.cgColor
            DoubleBT.layer.borderWidth = 1
            DoubleBT.layer.cornerRadius = 10
        }
    }
    
    @objc func intBTAction(){
        typeRandom(isInteger: true)
        intBT.animated()
        isInt = true
    }
    
    @objc func doubleBTAction(){
        typeRandom(isInteger: false)
        DoubleBT.animated()
        isInt = false
    }
    
    @objc func generated(){
        generateBT.animated()
        
        if(minNumsTF.text! == "" || maxNumsTF.text! == "" || minNumsTF.text!.first == "." || minNumsTF.text!.last == "." || maxNumsTF.text!.first == "." || maxNumsTF.text!.last == "."){
            if(minNumsTF.text == "" || minNumsTF.text!.first == "." || minNumsTF.text!.last == "."){
                minNumsTF.layer.borderColor = UIColor.systemRed.cgColor
            }else{
                minNumsTF.layer.borderColor = UIColor.gray.cgColor
            }
            if(maxNumsTF.text == "" || maxNumsTF.text!.first == "." || maxNumsTF.text!.last == "."){
                maxNumsTF.layer.borderColor = UIColor.systemRed.cgColor
            }else{
                maxNumsTF.layer.borderColor = UIColor.gray.cgColor
            }
        }else{
            minNumsTF.layer.borderColor = UIColor.gray.cgColor
            maxNumsTF.layer.borderColor = UIColor.gray.cgColor
            
            if(isInt == true){
                
                minValueI = Int(Double(minNumsTF.text!) ?? 0)
                maxValueI = Int(Double(maxNumsTF.text!) ?? 0)
                
                if(minValueI<maxValueI){
                    beforeResult = "Number before is: \(Int(result))"
                    let number = Int.random(in: minValueI...maxValueI)
                    result = Double(number)
                    DispatchQueue.main.async {
                        self.resultLB.isHidden = true
                        self.lastNumsLB.isHidden = true
                        self.resultLB.text = "\(number)"
                        self.lastNumsLB.text = self.beforeResult
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.resultLB.isHidden = false
                        self.lastNumsLB.isHidden = false
                    }
                }else{
                    minNumsTF.layer.borderColor = UIColor.systemRed.cgColor
                    maxNumsTF.layer.borderColor = UIColor.systemRed.cgColor
                }
            }else{
                minValueD = Double(minNumsTF.text!) ?? 0.0
                maxValueD = Double(maxNumsTF.text!) ?? 0.0
                
                if(minValueD<maxValueD){
                    beforeResult = "Number before is: \(result)"
                    let number = Double.random(in: minValueD...maxValueD)
                    result = number.rounded(toPlaces: 4)
                    DispatchQueue.main.async {
                        self.resultLB.isHidden = true
                        self.lastNumsLB.isHidden = true
                        self.resultLB.text = "\(number.rounded(toPlaces: 4))"
                        
                        self.lastNumsLB.text = self.beforeResult
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.resultLB.isHidden = false
                        self.lastNumsLB.isHidden = false
                    }
                }else{
                    minNumsTF.layer.borderColor = UIColor.systemRed.cgColor
                    maxNumsTF.layer.borderColor = UIColor.systemRed.cgColor
                }
            }
            
        }
        
    }
    
    

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

}
