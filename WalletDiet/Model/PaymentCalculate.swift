//  PaymentCalculate.swift
//  WalletDiet
//
//  Created by 浦山秀斗 on 2024/09/13.
//

import Foundation

class PaymentCalculate : PaymentCaculateProtocol {

    // 小銭の種類の関数
    func CoinTypes() -> [Int] {
        return [10000, 5000, 1000, 500, 100, 50, 10, 5, 1]
    }

    // 特定の金額を小銭で払うのに必要な枚数を計算する関数
    func calculateCoins(_ amount: Int, coinTypes: [Int]) -> Int {
        var totalCoins = 0
        var remainingAmount = amount

        for i in 3..<coinTypes.count {
            totalCoins += remainingAmount / coinTypes[i]
            remainingAmount %= coinTypes[i]
        }
        return totalCoins
    }

    func calculateCharge(from payment: Int) -> [PaymentPattern] {
        let coinTypes = CoinTypes()  // 小銭の種類
        let originalCoins = calculateCoins(payment, coinTypes: coinTypes)  // ピッタリ支払う場合の小銭枚数
        var array = [Int](repeating: 0, count: originalCoins + 1)
        array[originalCoins] = payment

        var paymentPatterns: [PaymentPattern] = []

        // 支払い額を上回る場合を順に確認
        for extraPayment in 1...10000 {
            let totalPayment = payment + extraPayment  // 実際に支払う総額
            let change = extraPayment  // もらうお釣りは超過分

            let paymentCoins = calculateCoins(totalPayment, coinTypes: coinTypes)  // 多めに払った場合の小銭の枚数
            let changeCoins = calculateCoins(change, coinTypes: coinTypes)  // お釣りに必要な小銭の枚数

            // もらうお釣りの枚数が払った小銭の枚数より少ない場合のみ結果を追加
            if paymentCoins > changeCoins && array[paymentCoins - changeCoins] == 0 {
                array[paymentCoins - changeCoins] = totalPayment
                paymentPatterns.append(PaymentPattern(payment: totalPayment, change: change))
            }
        }

        return paymentPatterns
    }
} 
