//
//  DownloadAnswer.swift
//  MagicAnswer
//
//  Created by Iryna Kopchynska on 29.09.2021.
//  Copyright © 2021 Iryna Kopchynska. All rights reserved.
//

import Foundation

class DownloadAnswer {
    
    let answerURL = "https://8ball.delegator.com/magic/JSON/question"
    func getQuestionResponse() {
        
        guard let url = URL(string: answerURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: ", error)
        
                let answers = UserDefaults.standard.array(forKey: "answer")
                let rundomAnswer = answers?.randomElement() ?? "Some default answer"

                self.sendingData(data: rundomAnswer as! String)
                
        //        self.sendingData(data: UserDefaults.standard.string(forKey: "answer")!)
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(Magic.self, from: data)
                self.sendingData(data: data.magic.answer!)
            } catch let jsonError {
                print(jsonError)
                self.sendingData(data: UserDefaults.standard.string(forKey: "answer")!)
            }
        }.resume()
    }
    
    func sendingData(data: String) {
        NotificationCenter.default.post(name: Notification.Name("didReceiveData"), object: data)
    }
    
}
