//
//  WAHeaderInfoView.swift
//  Weather
//
//  Created by Nikhil yawalkar on 20/04/24.
//

import SwiftUI

struct WAHeaderInfoView: View {
    var viewModel: WAHeaderInfoViewModel
    var body: some View {
        VStack(spacing: 5) {
            WhiteText(text: viewModel.cityName, size: 30, weight: .medium)
            WhiteText(text: "\(viewModel.currentTemp)°", size: 60, weight: .medium)
            WhiteText(text: viewModel.weatherStatus, size: 15, weight: .regular)
            WhiteText(text: "H:\(viewModel.maxTemp)°  L:\(viewModel.minTemp)°", size: 15, weight: .regular)
        }
        .padding()
    }
}

#Preview {
    WAHeaderInfoView(viewModel: WAHeaderInfoViewModel(cityName: "Begaluru", currentTemp: 32, weatherStatus: "Cloudy", maxTemp: 34, minTemp: 24))
}

struct WAHeaderInfoViewModel {
    var cityName: String
    var currentTemp: Double
    var weatherStatus: String
    var maxTemp: Double
    var minTemp: Double
}
