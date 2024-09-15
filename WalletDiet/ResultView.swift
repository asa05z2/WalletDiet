import SwiftUI

protocol PaymentCaculateProtocol {
    func calculateCharge(from payment: Int) -> [PaymentPattern]
}

struct ResultView: View {  // 結果画面の定義
    @Environment(\.presentationMode) var presentationMode  // 画面を閉じるための変数
    
    let calculator: PaymentCaculateProtocol = PaymentCalculate()
    let paymentAmount: Int
    @State var patterns: [PaymentPattern] = []
    
    var body: some View {
        
            VStack {
                HStack{
                    Text("支払い金額")
                        .padding()
                        .font(.largeTitle)
                    
                    Text("\(paymentAmount)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    
                    Text("円")
                        .padding()
                        .font(.largeTitle)
                }
                
                
                Text("コインの枚数差が大きい順")
                    .font(.title2)
                    .padding()
                
                
                
                List{
                    ForEach(patterns) { pattern in
                        HStack {
                            Text("\(pattern.change)円支払い")
                                .font(.title3)
                            
                            Text("お釣り\(pattern.payment)円")
                                .font(.title3)
                        }//HStach
                    }//ForEach
                }//List
                
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()  // 画面を閉じるアクション
                }) {
                    Text("戻る")
                        .font(.body)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            //.navigationTitle("Result画面")  // 画面タイトル
            .onAppear {
                //paymentAmountを 関数に 渡して patterns に代入する。
                patterns = calculator.calculateCharge(from: paymentAmount)
            }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(paymentAmount: 100)
    }
}

