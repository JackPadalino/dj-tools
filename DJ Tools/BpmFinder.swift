import SwiftUI

class BPMManager: ObservableObject {
    @Published var bpm: Double = 0
    @Published var countClicks: Double = 0
    @Published var bpmTotal: Double = 0
    @Published var bpmFinal: Int = 0
    @Published var prevTime: TimeInterval = 0
    @Published var currentTime: TimeInterval = 0
    @Published var timeDifference: TimeInterval = 0

    func getBPM() {
        if prevTime == 0 {
            prevTime = Date().timeIntervalSince1970
        } else if (Date().timeIntervalSince1970 - prevTime) > 2200 {
            reset()
        } else {
            currentTime = Date().timeIntervalSince1970
            timeDifference = currentTime - prevTime
            prevTime = currentTime
            bpm = 60 / timeDifference
            bpmTotal += bpm
            countClicks += 1
            bpmFinal = Int(round(bpmTotal / countClicks))
        }

    }

    func reset() {
        prevTime = 0
        bpm = 0
        bpmTotal = 0
        bpmFinal = 0
        countClicks = 0

    }
}

struct BpmFinder: View {
    @StateObject var bpmManager = BPMManager()

    var body: some View {
        ZStack {
            Color.init(red: 1.0, green: 0.7529411764705882, blue: 0.0).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("vinyl")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .onTapGesture {
                        bpmManager.getBPM()
                    }
                Text("Tap the record for BPM")
                    .bold()
                    .padding()
                Text("\(bpmManager.bpmFinal)")
                    .opacity(bpmManager.bpmFinal == 0 ? 0 : 1)
                    .font(.system(size: 75))
                    .padding()
                Text("Reset")
                    .bold()
                    .opacity(bpmManager.bpmFinal == 0 ? 0 : 1)
                    .padding()
                    .foregroundColor(.white)
                    .onTapGesture {
                        bpmManager.reset()
                    }
                    
                    
                
            }
        }
    }
}

#Preview {
    BpmFinder()
}
