//
//  ContentView.swift
//  Weather
//
//  Created by Nikhil yawalkar on 20/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cityWeatherResponse: CityWeatherResponse?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: cityWeatherResponse?.currentWeather?.isDay == 1 ? [.blue, .white] : [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack {
                    WAHeaderInfoView(viewModel: WAHeaderInfoViewModel(
                        cityName: cityWeatherResponse?.location?.name ?? "", 
                        currentTemp: cityWeatherResponse?.currentWeather?.tempC ?? 0,
                        weatherStatus: cityWeatherResponse?.currentWeather?.condition?.text?.rawValue ?? "", 
                        maxTemp: cityWeatherResponse?.forecast?.forecastday?.first?.day?.maxtempC ?? 0,
                        minTemp: cityWeatherResponse?.forecast?.forecastday?.first?.day?.mintempC ?? 0))
                    .frame(height: 300)
                    
                    AirQualityCardView()
                    
                    HourlyForecastView()
                    
                }
            }
        }
        .task {
            do {
                cityWeatherResponse = try await NetworkManager().getTodaysWeatherForecast()
            } catch {
                print(String(describing: error))
            }
        }
    }
}

#Preview {
    ContentView()
}

struct LightCardView: View {
    var isDarkMode: Bool
    var cornerRadius: CGFloat
    var body: some View {
        LinearGradient(colors: [isDarkMode ? .white : .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .opacity(0.05)
    }
}

struct AirQualityCardView: View {
    var body: some View {
        ZStack {
            LightCardView(isDarkMode: true, cornerRadius: 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    CardHeaderView(icon: "aqi.high", text: "AIR QUALITY")
                    WhiteText(text: "215 - Poor", size: 15, weight: .regular)
                    WhiteText(text: "Air quality index is 215, which is similar to yesterday at abot same time", size: 10, weight: .medium)
                }
                .padding()
                Spacer()
            }
        }
        .padding()
    }
}

struct HourlyForecastView: View {
    var body: some View {
        ZStack {
            LightCardView(isDarkMode: true, cornerRadius: 10)
            
            VStack(alignment: .leading, spacing: 15){
                CardHeaderView(icon: "clock", text: "HOURLY FORECAST")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0, content: {
                        ForEach(1..<25) { index in
                            VStack(spacing: 5) {
                                WhiteText(text: "\(String(format: "%02d", index))", size: 12, weight: .medium)
                                Image(systemName: "cloud.fill")
                                    .symbolRenderingMode(.multicolor)
                                WhiteText(text: "28°", size: 14, weight: .medium)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                        }
                    })
                }
            }
            .padding()
        }
        .padding()
    }
}

struct WhiteText: View {
    var text: String
    var size: CGFloat
    var weight: FontWeight
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(WAFont.font(weight: weight, size: size))
    }
}

enum FontWeight {
    case bold
    case medium
    case regular
}

struct WAFont {
    static func font(weight: FontWeight, size: CGFloat) -> Font {
        switch weight {
        case .bold:
            Font.bold(size: size)
        case .medium:
            Font.medium(size: size)
        case .regular:
            Font.regular(size: size)
        }
    }
}

extension Font {
    static func medium(size: CGFloat) -> Font {
        return .system(size: size, weight: .medium)
    }
    
    static func bold(size: CGFloat) -> Font {
        return .system(size: size, weight: .bold)
    }
    
    static func regular(size: CGFloat) -> Font {
        return .system(size: size, weight: .regular)
    }
}

struct CardHeaderView: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack() {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundStyle(.gray)
            Text(text)
                .foregroundStyle(.gray)
                .font(.system(size: 10))
        }
    }
}


