import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var data = [
        Media(nameURL: "vou-me-matar", nameMedia: "BOM DIA", nameAuthor: "Alê"),
        Media(nameURL: "ideaSound", nameMedia: "PILANTRA", nameAuthor: "Arqui"),
        Media(nameURL: "eu-amei-demais", nameMedia: "GALERAAA", nameAuthor: "Chico"),


    ]
    
    @State var Grid: [Int] = []
    
    var body: some View {
        VStack (spacing: 0 ){
            ZStack {
                HStack{
                    Text("Vozes da Academy")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                }
            }.padding()
            MainView(data: self.$data, Grid: self.$Grid)
            TabBar()
        }.background(Color.white.opacity(0.4).edgesIgnoringSafeArea(.bottom))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear{
                self.generateGrid()
            }
    }
    
    func generateGrid(){
        for i in stride(from: 0, to: self.data.count, by: 2){
            
            if i != self.data.count {
                self.Grid.append(i)
            }
            
            
        }
    }
    
}

struct TabBar: View {
    @State var index = 0
    var body: some View{
        HStack {
            Button(action: {
                self.index = 0
            }) {
                VStack{
                    Image(systemName: "house")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(self.index == 0 ? .red : .gray)
                    
                    if self.index == 0{
                        Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                    }
                }
            }
        }.padding(.horizontal, UIScreen.main.bounds.size.width)
        .padding(.top, 12)
        .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 0, x: 0, y: -6)
        .animation(.default)
    }
}

struct Card: View {
    var data: Media
    var body: some View {
        VStack(spacing: 15){
            Button(action: {
                playSound(sound: data.nameURL)
            }) {
                Text(data.nameMedia).foregroundColor(.white)
                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
            }.background(Color.yellow.opacity(0.4))
                .cornerRadius(12)
                .shadow(radius: 6)
        }
    }
}

struct MainView: View{
    @Binding var data : [Media]
    @Binding var Grid : [Int]
    var body: some View {
        VStack {
            if !self.Grid.isEmpty{
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack (spacing: 25){
                        ForEach(self.Grid, id: \.self){i in
                            HStack(spacing: 15){
                                ForEach(i...i+1, id: \.self){j in
                                    
                                    VStack{
                                        if j != self.data.count {
                                            Card(data: self.data[j])
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                            if i == self.Grid.last && self.data.count % 2 != 0 {
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct Media {
    var nameURL: String
    var nameMedia: String
    var nameAuthor: String
}
