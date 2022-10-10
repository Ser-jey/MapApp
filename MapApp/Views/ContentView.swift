//
//  ContentView.swift
//  MapApp
//
//  Created by Сергей Кривошеев on 26.08.2022.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack {
                header
                    .padding()
                Spacer()
           
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
        ContentView()
            .environmentObject(LocationsViewModel())
        }
    }
}

extension ContentView {
    
    private var header: some View {
        
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.linear, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.primary)
                            .font(.headline)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationslist ? 180 : 0))
            }
                }
            if vm.showLocationslist {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(15)
        .shadow(radius: 15)
    }
    
    private var mapLayer: some View {
        
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .animation(.easeInOut, value: vm.mapLocation)
                    .shadow(radius: 5)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        
    }
    
    private var locationsPreviewStack: some View {
        
        ZStack{
            ForEach(vm.locations){ location in
                if vm.mapLocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .transition(.asymmetric(
                            insertion:  .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
        
    }
}
    

