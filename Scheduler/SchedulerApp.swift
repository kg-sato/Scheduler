import SwiftUI
import WebKit
import UniformTypeIdentifiers

// A small native shell; all scheduling logic remains in Application.html.
@main
struct SchedulerApp: App {
    var body: some Scene {
        WindowGroup { ScheduleScreen().preferredColorScheme(.dark) }
    }
}

struct ScheduleDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    var text: String
    init(text: String = "") { self.text = text }
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let value = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = value
    }
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}

struct ScheduleScreen: View {
    @StateObject private var bridge = ScheduleBridge()

    var body: some View {
        ScheduleWebView(bridge: bridge)
            .background(Color(red: 0.082, green: 0.078, blue: 0.114))
            .fileImporter(isPresented: $bridge.importing, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let url):
                    let access = url.startAccessingSecurityScopedResource()
                    defer { if access { url.stopAccessingSecurityScopedResource() } }
                    do {
                        let text = try String(contentsOf: url, encoding: .utf8)
                        bridge.dispatch("nativeScheduleImport", detail: text)
                    } catch {
                        bridge.status("Could not read this JSON file. Your schedule was not changed.", error: true)
                    }
                case .failure:
                    bridge.status("Import cancelled. Your schedule was not changed.")
                }
            }
            .fileExporter(isPresented: $bridge.exporting, document: bridge.document,
                          contentType: .json, defaultFilename: "week-by-week") { result in
                switch result {
                case .success: bridge.status("Schedule exported.")
                case .failure: bridge.status("Export was not completed. Your schedule is still saved on this device.", error: true)
                }
            }
    }
}

final class ScheduleBridge: NSObject, ObservableObject, WKScriptMessageHandler {
    @Published var importing = false
    @Published var exporting = false
    @Published var document = ScheduleDocument()
    weak var webView: WKWebView?

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Accept Files requests only from the bundled main document, not embedded or remote pages.
        guard message.frameInfo.isMainFrame, message.frameInfo.request.url?.isFileURL == true,
              let body = message.body as? [String: Any], let action = body["action"] as? String else { return }
        if action == "import" {
            importing = true
        } else if action == "export", let text = body["text"] as? String {
            document = ScheduleDocument(text: text)
            exporting = true
        }
    }

    func dispatch(_ event: String, detail: Any) {
        // JSON serialization keeps imported text as data, never JavaScript source.
        guard let data = try? JSONSerialization.data(withJSONObject: ["type": event, "detail": detail]),
              let json = String(data: data, encoding: .utf8) else { return }
        webView?.evaluateJavaScript("(() => { const message = \(json); window.dispatchEvent(new CustomEvent(message.type, {detail: message.detail})); })();", completionHandler: nil)
    }

    func status(_ message: String, error: Bool = false) {
        dispatch("nativeScheduleStatus", detail: ["message": message, "error": error])
    }
}

struct ScheduleWebView: UIViewRepresentable {
    let bridge: ScheduleBridge

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        // Persist web storage across launches. This remains device-local until account sync is implemented.
        configuration.websiteDataStore = .default()
        configuration.userContentController.add(bridge, name: "scheduleFiles")
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.navigationDelegate = context.coordinator
        view.isOpaque = false
        view.backgroundColor = .clear
        view.scrollView.backgroundColor = .clear
        view.scrollView.contentInsetAdjustmentBehavior = .never
        bridge.webView = view
        if let url = Bundle.main.url(forResource: "Application", withExtension: "html") {
            context.coordinator.allowedURL = url
            view.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        // Release the bridge registration when SwiftUI removes this web view.
        uiView.configuration.userContentController.removeScriptMessageHandler(forName: "scheduleFiles")
        uiView.navigationDelegate = nil
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        var allowedURL: URL?
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else { decisionHandler(.cancel); return }
            // Restrict navigation to the bundled app. Future web authentication needs a deliberate separate flow.
            decisionHandler(url.isFileURL && url.standardizedFileURL == allowedURL?.standardizedFileURL ? .allow : .cancel)
        }
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) { webView.reload() }
    }
}
