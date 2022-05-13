//
//  BruteForce.swift
//  Pr2503
//
//  Created by Михаил Багмет on 13.05.2022.
//

import Foundation

class BruteForce {
    func start(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            password = generate(password, fromArray: allowedCharacters)
            print(password)
        }
        
        print(password)
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
