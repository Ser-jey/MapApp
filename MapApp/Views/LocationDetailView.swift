//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Сергей Кривошеев on 30.08.2022.
//

import SwiftUI
import MapKit


struct LocationDetailView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack{
                imagesSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                }
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
         backButton
        }
        
    }
    
}
struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
      
            LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailView {
    
    private var imagesSection: some View {
        
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                // Убираем глюки картинок при переходе
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 7) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(location.description)
                .foregroundColor(.secondary)
              
            if let url = URL(string: location.link) {
                Link<Text>(destination: url, label: {
                    Text("Read more on Wikipedia")
                        .font(.headline)
                        .foregroundColor(.blue)
                })
                    
        }
        
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
       
}
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: vm.mapSpan)), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 5)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
        .padding()
    }
    
    private var backButton: some View {
        
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()

        }

    }
    
}

