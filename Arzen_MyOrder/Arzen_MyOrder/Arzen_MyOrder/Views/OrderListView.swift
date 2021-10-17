//
//  OrderListView.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-09-30.
//  StudentID: 991579073
//

import SwiftUI

struct OrderListView: View {
    @State private var showNewOrderView: Bool = false
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                if (self.coreDBHelper.orderList.count > 0){
                    List{
                        ForEach (self.coreDBHelper.orderList.enumerated().map({$0}), id: \.element.self){ indx, currentOrder in
                            NavigationLink(destination: NewOrderView(selectedOrderIndex: indx)){
                                VStack(alignment: .leading){
                                    Text("\(currentOrder.coffeeType)")
                                        .fontWeight(.bold)
                                    
                                    Text("\(currentOrder.coffeeSize)")
                                        .font(.callout)
                                        .italic()
                                    
                                    Text("\(currentOrder.quantity)")
                                        .font(.callout)
                                        .italic()
                                }.padding(20)
                                    .onTapGesture {
                                        print("\(self.coreDBHelper.orderList[indx].coffeeType) selected")
                                    }
                            }//NavigationLink
                        }//ForEach
                        .onDelete(perform: {indexSet in

                            for index in indexSet{
                                //ask for confirmation and then delete
                                self.coreDBHelper.deleteOrder(orderID: self.coreDBHelper.orderList[index].id!)
                                self.coreDBHelper.orderList.remove(atOffsets: indexSet)
                            }
                        })
                    }//List
                }//if
                else{
                    VStack{
                        Spacer()
                        Text("Orders have not been made yet.")
                        Spacer()
                    }
                }
            }//ZStack
            .frame(maxWidth: .infinity)
            
            .navigationBarTitle("Orders List", displayMode: .inline)
        }//NavigationView
        .onAppear(){
            self.coreDBHelper.getAllOrders()
        }
    }
}


struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
