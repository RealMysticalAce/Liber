//
//  DeviceActivityReportView.swift
//  testing123
//
//  Created by Valeriy Yauseichyk on 20/03/2026.
//

import SwiftUI
import FamilyControls
import DeviceActivity

struct DeviceActivityReportView: View {
    @State private var selection = FamilyActivitySelection()
    @State private var showActivitySelectionView: Bool = false
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: DateInterval(
                start: Calendar.current.startOfDay(for: Date()),
                end: Date()
            )
        ),
        users: .all,
        devices: .all,
        applications: [],
        categories: [],
        webDomains: []
    )

    var body: some View {
        NavigationStack {
            
            VStack {
                
                Button(action: {
                    showActivitySelectionView = true
                }, label: {
                    Text("Pick Activities")
                })
                .onChange(of: self.selection, {
                    print(self.selection)
                    self.filter.applications = self.selection.applicationTokens
                    self.filter.categories = self.selection.categoryTokens
                    self.filter.webDomains = self.selection.webDomainTokens
                })
                
                
                DeviceActivityReport(context, filter: filter)

            }
            .sheet(isPresented: $showActivitySelectionView, content: {
                FamilyActivitySelectionView(selection: $selection)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationTitle("Device Activity Report")

        }

    }
}


struct FamilyActivitySelectionView: View {
    @Binding var selection: FamilyActivitySelection
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectionTemp = FamilyActivitySelection()
    
    var body: some View {
        NavigationStack {
            FamilyActivityPicker(selection: $selectionTemp)
                .ignoresSafeArea()
                .navigationTitle("Select Activity")
                .navigationBarTitleDisplayMode(.large)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(role: .cancel, action: {
                            self.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .buttonBorderShape(.circle)
                        .buttonStyle(.bordered)
                    })
                    .sharedBackgroundVisibility(.hidden)
                    
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(role: .confirm, action: {
                            selection = self.selectionTemp
                            self.dismiss()
                        }, label: {
                            Image(systemName: "checkmark")
                        })
                        .buttonBorderShape(.circle)
                        .buttonStyle(.glass)
                    })
                    .sharedBackgroundVisibility(.hidden)
                })
                .onAppear {
                    self.selectionTemp = selection
                }
        }

    }
}



#Preview {
    DeviceActivityReportView()
}
