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
            Text("結果画面")
                .font(.largeTitle)
                .padding()
            
            Text("支払い金額 \(paymentAmount)")
            
            ForEach(patterns) { pattern in
                HStack {
                    Text("\(pattern.change)")
                    Text("\(pattern.payment)")
                }
            }
            
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

