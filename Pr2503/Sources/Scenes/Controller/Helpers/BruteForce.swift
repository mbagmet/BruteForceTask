//
//  BruteForce.swift
//  Pr2503
//
//  Created by Михаил Багмет on 13.05.2022.
//

import Foundation

class BruteForce {
    var password: String = ""
    
    func start(passwordToUnlock: String, queue: DispatchQueue = DispatchQueue.global(qos: .utility), complition: @escaping () -> ()) {
        
        let workItem = DispatchWorkItem {
            print("Начинаем подбор пароля \(Thread.current)")

            let allowedCharacters: [String] = String().printable.map { String($0) }
            
            var password = ""

            while password != passwordToUnlock {
                password = self.generate(password, fromArray: allowedCharacters)
                print(password)
            }
            self.password = password
            
            print("Закончили побдор пароля: \(Thread.current)")
            print("Подобранный пароль: \(self.password)")
        }
        
        workItem.notify(queue: .main) {
            print("Снова поработаем с интерфейсом: \(Thread.current)")
            complition()
        }
        
        queue.async(execute: workItem)
    }

    func generate(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generate(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}

extension BruteForce {
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }
}
