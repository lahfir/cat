import SwiftUI
import Speech
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace 
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                
            }.onAppear{
                Task {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
