import SwiftUI

class PitchManager: ObservableObject {
    @Published var range: String = ""
    @Published var startingBpm: String = ""
    @Published var targetBpm: String = ""
    @Published var pitchFinal: String = "Final Pitch"

    func getPitch() {
        if let rangeInt = Int(range),
           let startingBpmInt = Int(startingBpm),
           let targetBpmInt = Int(targetBpm),
           startingBpmInt != 0 {
            let result = Double(targetBpmInt - startingBpmInt) / (Double(startingBpmInt) * (Double(rangeInt) / 1000))
            pitchFinal = String(format: "%.2f", result)
//            Hide keypad on submit
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        } else {
            // Handle cases where conversion fails or startingBpmInt is 0
            pitchFinal = "X_X"
        }
    }

    func reset() {
        range = ""
        startingBpm = ""
        targetBpm = ""
        pitchFinal = "Final Pitch"
    }
}

struct PitchFinder: View {
    @StateObject var pitchManager = PitchManager()
    
    var body: some View {
        ZStack {
            Color.init(red: 0.0, green: 0.0, blue: 0.0).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Spacer()
                TextField("Range", text: $pitchManager.range)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                //                .padding()
                
                TextField("Starting BPM", text: $pitchManager.startingBpm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                //                .padding()
                
                TextField("Target BPM", text: $pitchManager.targetBpm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
//                                .padding()
                Text("Submit")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .onTapGesture {
                        pitchManager.getPitch()
                    }
                
                
                Text("\(pitchManager.pitchFinal)")
                    .opacity(pitchManager.pitchFinal == "Final Pitch" ? 0 : 1)
                    .foregroundColor(.white)
                    .font(.system(size: 75))
                //                .padding()
                Spacer()
                Text("Reset")
                    .bold()
                    .padding()
                    .opacity(pitchManager.pitchFinal == "Final Pitch" ? 0 : 1)
                    .foregroundColor(.white)
                    .onTapGesture {
                        pitchManager.reset()
                    }
                
                
            }
            .padding()
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    PitchFinder()
}
