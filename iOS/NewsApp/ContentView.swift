

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var showProfile = false
    
    var body: some View {

        MemeList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
