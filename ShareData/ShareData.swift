//
//  ShareData.swift
//  ShareData
//
//  Created by qun on 2021/1/15.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        //let entry = SimpleEntry(date: currentDate, configuration: ConfigurationIntent())
        //entries.append(entry)
        
        ///*
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        //*/

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ShareDataEntryView : View {
    var entry: Provider.Entry
    @AppStorage("zombie", store: UserDefaults(suiteName: "group.com.qun.widget.Widget"))
    var zombie = ""
    var body: some View {
        //Text(entry.date, style: .time)
        Text(zombie != "" ? "\(zombie)就在你身邊" : "殭屍尚未出現")
        
    }
}

@main
struct ShareData: Widget {
    let kind: String = "ShareData"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ShareDataEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


struct ShareData_Previews: PreviewProvider {
    static var previews: some View {
        ShareDataEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
