//
//  ViewController.swift
//  Debait_Testing
//
//  Created by Alejandro Martinez on 9/21/19.
//  Copyright © 2019 Alejandro Martinez. All rights reserved.
//

struct GoogleData: Codable {
    
    let evaluation : String?
    let score: Double
    let magnitude : Double
    
}

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    var googleEvaluation: String?
    var googleScore: Double?
    var googleMagnitude: Double?

    override func viewDidLoad() {
        userInput.delegate = self
        userInput.keyboardType = .default
        
        //These happens to be the observes that we are going to have
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBOutlet var userInput: UITextField!
    
    @IBOutlet var decodeButton: UIButton!
    
    var userText: String?
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.userInput.text = "Enter your URL link"
        self.userInput.textColor = .lightGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Pressed")
        inputTranslator()
        hideKeyboard()
        return true
    }
    
    func inputTranslator () -> String  {
        userText = userInput.text!
        print(userText)
        return userText!
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if userInput.text == "Enter your URL link" {
            userInput.text = ""
            userInput.textColor = .black
        }
    }
    
    //Function that when the keyboard disappears the default value goes back to 0.00. This function is an overwritten function
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userInput.text == ""{
            userInput.text = "Enter your URL link"
            userInput.textColor = .lightGray
        }
    }
    
    
    func hideKeyboard() {
        //method from the UItextviewdelgate protocol that hodes the key board.
        userInput.resignFirstResponder()
    }
    
    @objc func keyBoardWillChange (notification: Notification){
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillShowNotification {
            view.frame.origin.y = -keyboardReact.height
            decodeButton.isEnabled = false
        } else {
            view.frame.origin.y = 0
            decodeButton.isEnabled = true
            
        }
    }
    
    @IBAction func decodeAction(_ sender: Any) {
        //if enter is never submitedd
        inputTranslator()
        
        let parameters = [ "message" : inputTranslator() ]
        
        guard let url = URL(string: "http://localhost:5000/processing") else {return}
        var request = URLRequest(url: url)
        request.httpMethod =  "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6000) {
            
            if let response = response {
                print(data)
            }
            if let data = data {
                
                do{
                    let decoder = JSONDecoder()
                    let digest = try decoder.decode(GoogleData.self, from: data)
                    self.googleEvaluation = String (digest.evaluation!)
                    self.googleScore = Double (digest.score)
                    self.googleMagnitude = Double (digest.magnitude)
                    
                }
                    
                catch {
                    print(error)
                }
                
            }
                
         }
        }.resume()
                
            print(self.googleEvaluation)
            print(self.googleMagnitude)
            print(self.googleScore)
    }
    
}
//                do {
//                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch {
//                    print(error)
//                }
//            }
//            }.resume()
        


