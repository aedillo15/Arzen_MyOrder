//
//  ContentView.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-09-30.
//  StudentID: 991579073
//

import SwiftUI


struct ContentView: View {
    
    
    //variables for input
    @State private var selectedCoffeeType = ""
    @State private var selectedCoffeeSize : String = ""
    @State private var selectedQuantity : String = ""
    
   
    @State private var showingAlert = false
    
    @State private var selection : Int? = nil
    
    @State var typesOfCoffee = ["Dark Roast", "Original Blend", "French Vanilla", "Cappicuino"]
    @State var sizesOfCoffee = ["Small", "Medium", "Large", "Xtra-Large"]
    @State var quantity = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    //Body
    var body: some View
    {
    NavigationView
    {
            VStack{
            //NavigationView start
            NavigationLink(destination: OrderListView(), tag: 1, selection: $selection){
                Text("List of Orders")
                    .bold()
                    .frame(width:280, height:50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
                //Type of coffee picker
                Picker("Please choose a coffee type", selection: $selectedCoffeeType) {
                    ForEach(typesOfCoffee, id: \.self) {
                        Text($0)
                    }
                }
                    
                //Size of Coffee
                Picker("Please choose a coffee size", selection: $selectedCoffeeSize) {
                    ForEach(sizesOfCoffee, id: \.self) {
                        Text($0)
                    }
                }
                
                //Quantity Picker
                Picker("Please choose a quantity", selection: $selectedQuantity) {
                    ForEach(quantity, id: \.self) {
                        Text($0)
                    }
                }
        
        Button("Place Order", action:{
            //Place Order into database now
            self.addNewOrder()
            
            self.presentationMode.wrappedValue.dismiss()
            showingAlert = true
        })
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("Order has been placed"),
                message: Text("Check List of Orders for more details"),
                dismissButton: .default(Text("Got it!"))
            )}
        }
    }
}// Body
    
private func addNewOrder(){
    if (!self.selectedCoffeeType.isEmpty && !self.selectedCoffeeSize.isEmpty){
        self.coreDBHelper.insertOrder(newOrder: Order(coffeeType: self.selectedCoffeeType, coffeeSize: self.selectedCoffeeSize, quantity: self.selectedQuantity))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
}
