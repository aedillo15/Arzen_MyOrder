//
//  NewOrderView.swift
//  Arzen_MyOrder
//  991579073
//  Created by Arzen Edillo on 2021-10-14.
//

import SwiftUI

struct NewOrderView: View {
    
    @State private var coffeeType = ""
    @State private var coffeeSize : String = ""
    @State private var quantity : String = ""
    
    @State private var selectedCoffeeType = ""
    @State private var selectedCoffeeSize : String = ""
    @State private var selectedQuantity : String = ""
    
    @State var typesOfCoffeePicker = ["Dark Roast", "Original Blend", "French Vanilla", "Cappicuino"]
    @State var sizesOfCoffeePicker = ["Small", "Medium", "Large", "Xtra-Large"]
    @State var quantityPicker = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    let selectedOrderIndex : Int
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper: CoreDBHelper
    
    var body: some View {
        VStack{
            Spacer()
            //Display order to be updated
            Text("Updating: \n" + coffeeType + coffeeSize + quantity)
            
            Form{
                //Type of coffee picker
                Picker("Coffee type", selection: $selectedCoffeeType) {
                    ForEach(typesOfCoffeePicker, id: \.self) {
                        Text($0)
                    }
                }
                    
                //Size of Coffee
                Picker("Coffee size", selection: $selectedCoffeeSize) {
                    ForEach(sizesOfCoffeePicker, id: \.self) {
                        Text($0)
                    }
                }
                
                //Quantity Picker
                Picker("Quantity", selection: $selectedQuantity) {
                    ForEach(quantityPicker, id: \.self) {
                        Text($0)
                    }
                }
            }//Form
            
            Button(action:{
                self.updateOrder()
            }){
                Text("Update Order")
            }
            
            Spacer()
        }//VStack
        .frame(maxWidth: .infinity)
        .onAppear(){
            self.coffeeType = self.coreDBHelper.orderList[selectedOrderIndex].coffeeType
            self.coffeeSize = self.coreDBHelper.orderList[selectedOrderIndex].coffeeSize
            self.quantity = self.coreDBHelper.orderList[selectedOrderIndex].quantity
        }
        .onDisappear(){
            self.coreDBHelper.getAllOrders()
        }
    }//body
    
    private func updateOrder(){
        self.coreDBHelper.orderList[selectedOrderIndex].coffeeType = self.selectedCoffeeType
        self.coreDBHelper.orderList[selectedOrderIndex].coffeeSize = self.selectedCoffeeSize
        self.coreDBHelper.orderList[selectedOrderIndex].quantity = self.selectedQuantity
        
        self.coreDBHelper.updateOrder(updatedOrder: self.coreDBHelper.orderList[selectedOrderIndex])
        self.presentationMode.wrappedValue.dismiss()
    }
}

