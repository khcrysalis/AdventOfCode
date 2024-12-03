#!/usr/bin/swift
import Foundation

fileprivate func getFile(at path: String) -> String? {
    return try? String(contentsOfFile: path, encoding: .utf8)
}

fileprivate func file()  -> String {
    let currentDirectory = FileManager.default.currentDirectoryPath
    let filePath = "\(currentDirectory)/input.txt"
    return try! String(contentsOfFile: filePath, encoding: .utf8)
}

fileprivate func part1() {    
    let regex = try! NSRegularExpression(pattern: "mul\\((\\d+),(\\d+)\\)", options: [])
    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
    var d = 0
    for match in matches {
        if let range = Range(match.range(at: 1), in: input),
           let range2 = Range(match.range(at: 2), in: input),
           let a = Int(input[range]),
           let b = Int(input[range2]) {
            d += a * b
        }
    }
    print(d)
}

fileprivate func part2() {
    let regex = try! NSRegularExpression(pattern: "(do\\(\\)|don't\\(\\)|mul\\((\\d+),(\\d+)\\))", options: [])
    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
    var d = 0
    var mulEnabled = true

    for match in matches {
        let matchString = (input as NSString).substring(with: match.range)
        switch matchString {
        case "do()":
            mulEnabled = true
        case "don't()":
            mulEnabled = false
        default:
            if mulEnabled, 
            let range1 = Range(match.range(at: 2), in: input), 
            let range2 = Range(match.range(at: 3), in: input), 
            let a = Int(input[range1]), 
            let b = Int(input[range2]) {
                d += a * b
            }
        }
    }
    print(d)
}

let input = file()
part1()
part2()