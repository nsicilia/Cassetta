//
//  HighlightsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI

struct HighlightsView: View {
    var body: some View {
        ScrollView(.horizontal , showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<5) { _ in
                    HighlightCell()
                }
            }
            .padding(.leading)
        }
    }
}

struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView()
    }
}
