//
//  GeometryReaderBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 06/05/2024.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geo) * 20),
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()

                }
            }
        }
//        GeometryReader { geo in //geo = size of the content that's inside
//            HStack(spacing: 0) {
//                Rectangle().fill(Color.red)
//                    .frame(width: geo.size.width * 0.66)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double { //GeometryProxy = value that is coming from geo
        let maxDistance = UIScreen.main.bounds.width / 2  //center of the screen
        let currentX = geo.frame(in: .global).midX //middle x coordinate of rectangle, geo.frame(in:) -> Location of the object in the coordinate space
        return Double(1 - (currentX / maxDistance))
    }
}

#Preview {
    GeometryReaderBootcamp()
}


/*  MARK: NOTE
 
    Recommended to not use GeometryReader unless we need to  because it's expensive and cost a lot of computing power
    to put into apps and it can slow down
 
 */
