import Foundation

// Create the input and output file paths.
let inputFilePath = "input.txt"
let outputFilePath = "output.txt"

// Create a FileManager.
let fileManager = FileManager.default

// This checks to see if the input file exists.
guard fileManager.fileExists(atPath: inputFilePath) else {
    print("Input file not found.")
    exit(1)
}

// Create an output file if it doesn't exist.
fileManager.createFile(atPath: outputFilePath, contents: nil, attributes: nil)

// Open the input and output files.
let inputFile = try FileHandle(forReadingFrom: URL(fileURLWithPath: inputFilePath))
let outputFile = try FileHandle(forWritingTo: URL(fileURLWithPath: outputFilePath))

// Define a function to handle errors.
func handleError(_ error: Error) {
    print("Error: \(error.localizedDescription)")
    let errorMessage = "Error: \(error.localizedDescription)\n"
    outputFile.write(errorMessage.data(using: .utf8)!)
}

// Read the contents of the input file as a string.
let contents = String(data: inputFile.readDataToEndOfFile(), encoding: .utf8)

// Split the contents into an array of lines.
let lines = contents?.components(separatedBy: .newlines) ?? []

// Loop through each line of the input file.
for line in lines {
    // Split the line into an array of integers.
    let integers = line.split(separator: " ").compactMap { Int($0) }
    
    // Calculate the sum of the integers.
    let sum = integers.reduce(0, +)
    
    // Write the sum to the output file.
    outputFile.write("\(sum)\n".data(using: .utf8)!)
}

// Close the input and output files.
inputFile.closeFile()
outputFile.closeFile()
