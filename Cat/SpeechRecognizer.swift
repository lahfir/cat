//
//  SpeechRecognizer.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    enum SpeechRecognitionError: Error {
        case audioSessionError(String)
        case recognitionRequestError
    }
    
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    @Published var isSpeaking = false
    @Published var transcribedText = ""
    
    func startListening() {
        do {
            try startSpeechRecognition()
        } catch {
            print("There was a problem starting speech recognition: \(error.localizedDescription)")
        }
    }
    
    func stopSpeaking() {
        isSpeaking = false
    }
    
    func handleError() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest = nil
        recognitionTask = nil
        isSpeaking = false
        startListening()
    }
    
    private func startSpeechRecognition() throws {
        recognitionTask?.cancel()
        recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw SpeechRecognitionError.audioSessionError(error.localizedDescription)
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            throw SpeechRecognitionError.recognitionRequestError
        }
        recognitionRequest.shouldReportPartialResults = true
        
        setupRecognitionTask(recognitionRequest: recognitionRequest)
    }
    
    private func setupRecognitionTask(recognitionRequest: SFSpeechAudioBufferRecognitionRequest) {
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            DispatchQueue.main.async {
                if let result = result {
                    self.handleResult(result)
                }
                
                if error != nil {
                    self.handleError()
                }
            }
        }
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    private func handleResult(_ result: SFSpeechRecognitionResult) {
        isSpeaking = true
        transcribedText = result.bestTranscription.formattedString
        
        if result.isFinal {
            isSpeaking = false
        }
    }
}
