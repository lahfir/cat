import SwiftUI
import AVFoundation
import Speech

// MARK: - ImmersiveView

struct ImmersiveView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    
    @State private var catPosition: CGSize = .zero
    @State private var particlePositions: [CGPoint] = Array(repeating: .zero, count: 50)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particlePositions.indices, id: \.self) { index in
                    ParticleView(
                        position: particlePositions[index],
                        color: Color.pink.opacity(Double.random(in: 0.5...1)),
                        animation: Animation.linear(duration: Double.random(in: 5...10)).repeatForever(autoreverses: false), scale:1
                    )
                    .onAppear {
                        particlePositions[index] = CGPoint(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                    }
                }
                
                VStack {
                    DraggableView {
                        AnimatedCatImage(isSpeaking: speechRecognizer.isSpeaking)
                            .offset(catPosition)
                            .background(Color.clear)
                            .onAppear {
                                speechRecognizer.startListening()
                            }
                            .onReceive(audioPlayerManager.$didFinishPlaying) { didFinish in
                                if didFinish {
                                    speechRecognizer.stopSpeaking()
                                    audioPlayerManager.finishPlaying()
                                    audioPlayerManager.playSound()
                                }
                            }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct ImmersiveView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveView()
            .previewLayout(.sizeThatFits)
    }
}
