//
//  ContentView.swift
//  Magic 8 Ball
//
//  Created by Karteikay Dhuper on 7/16/22.
//

import SwiftUI
import SwiftSpeech

struct ContentView: View {
    
    @State var eightBallAnswer = "Ask and I shall answer..."
    @State var questionText = "Hold to Ask"
    @State var shakes: Int = 0
    @State var blackCircleYOffset = -350
    @State var innerCirclesYOffset = -200
    
    let radialGradient = RadialGradient(gradient:  Gradient(colors: [
        Color.gray,
        Color.black]), center: UnitPoint(x: 0.5, y: 0.64), startRadius: 0, endRadius: 190)

    var body: some View {
        ZStack {
            Image("cosmos")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    Group{
                        Circle()
                            .fill(radialGradient)
                            .foregroundColor(.black)
                            .offset(x: 0, y: CGFloat(blackCircleYOffset))
                        Circle()
                            .fill(radialGradient)
                            .frame(height: 280).foregroundColor(.blue)
                            .offset(x: 0, y: CGFloat(innerCirclesYOffset))

                        Circle().frame(height: 250).foregroundColor(Color(hue: 0.686, saturation: 0.855, brightness: 0.727))
                            .offset(x: 0, y: CGFloat(innerCirclesYOffset))
                        
                        Text(eightBallAnswer)
                            .bold()
                            .frame(width: 200)
                            .padding()
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundColor(.white)
                            .offset(x: 0, y: CGFloat(innerCirclesYOffset))
                    }.modifier(Shake(animatableData: CGFloat(shakes)))
                    
                    
                    VStack{
                        Text(questionText)
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.bottom,30)
                            .multilineTextAlignment(.center)
                            .frame(width: 350)
                        
                        SwiftSpeech.RecordButton()
                            .swiftSpeechRecordOnHold()
                            .onRecognizeLatest(update: $questionText)
                        
                        Button(action: {
                                withAnimation(.default)
                                {
                                    self.shakes += 1
                                }
                            eightBallAnswer = EightBall_Logic().getEightBallAnswer()

                        }, label: {Text("Shake").bold() })
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .cornerRadius(24)
                        .padding(.top, 30)
                    
                    }.offset(x: 0, y: 200)                }
            }.onAppear(perform: SwiftSpeech.requestSpeechRecognitionAuthorization)
        
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

}
