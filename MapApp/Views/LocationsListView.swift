//
//  LocationsListView.swift
//  MapApp
//
//  Created by Сергей Кривошеев on 26.08.2022.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
              
            }
            .padding(.vertical, 3)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
    
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView {

    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(7)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            
        }
    }
    
}
