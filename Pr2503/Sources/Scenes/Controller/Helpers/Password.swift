//
//  Password.swift
//  Pr2503
//
//  Created by Михаил Багмет on 15.05.2022.
//

import Foundation

class Password {
    var generatedPassword: String = ""
    
    private func generatePassword(minLength: Int, maxLength: Int) -> String {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        let passwordLength = Int.random(in: minLength...maxLength)
        
        for _ in 1...passwordLength {
            guard let randomCharacter = allowedCharacters.randomElement() else { return password }
            password.append(randomCharacter)
        }
        
        print("Сгенерирован пароль: \(password)")
        
        return password
    }
    
    func startPasswordGeneration(queue: DispatchQueue = DispatchQueue.global(qos: .default), complition: @escaping () -> ()) {
        
        let workItem = DispatchWorkItem {
            print("Генерируем пароль: \(Thread.current)")
            self.generatedPassword = self.generatePassword(minLength: 3, maxLength: 3)
        }
        
        workItem.notify(queue: .main) {
            print("Поработаем с интерфейсом: \(Thread.current)")
            complition()
        }
        
        queue.async(execute: workItem)
    }
}
