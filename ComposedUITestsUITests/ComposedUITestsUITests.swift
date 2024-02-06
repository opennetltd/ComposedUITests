import XCTest

final class ComposedUITestsUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_AllUpdates() throws {
        XCTFail("This will crash")

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()

        if #available(iOS 14, *) {
            app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
            app.buttons["All Updates"].tap()
        } else {
            app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply"].tap()
        }

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 → 10 (updated)",
                "[1] Item 7 → 11 (updated)",
            ],
            app: app
        )
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_OmitFinalUpdate() throws {
        XCTFail("This will crash")

        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
            ],
            app: app
        )
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_OmitFinalDeleteAndUpdate() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final delete and update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
                "[1] Item 8 (original)",
            ],
            app: app
        )
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_OmitFinalDeletesAndUpdate() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final deletes and update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
                "[1] Item 8 (original)",
                "[1] Item 9 (original)",
            ],
            app: app
        )
    }

    func testManualUpdateInsertUpdateRemoveUpdate_AllUpdates() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Update → Insert → Update → Remove → Update"].tap()

        if #available(iOS 14, *) {
            app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
            app.buttons["All Updates"].tap()
        } else {
            app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply"].tap()
        }

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 → 10 (updated)",
                "[1] Item 7 → 11 (updated)",
            ],
            app: app
        )
    }

    func testManualUpdateInsertUpdateRemoveUpdate_OmitFinalUpdate() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
            ],
            app: app
        )
    }

    func testManualUpdateInsertUpdateRemoveUpdate_OmitFinalDeleteAndUpdate() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final delete and update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
                "[1] Item 8 (original)",
            ],
            app: app
        )
    }

    func testManualUpdateInsertUpdateRemoveUpdate_OmitFinalDeletesAndUpdate() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars["Update → Insert → Update → Remove → Update"].buttons["Apply..."].tap()
        app.buttons["All Updates (omit final deletes and update)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0 (updated)",
                "[1] Item 1 (updated)",
                "[1] Item 2 (updated)",
                "[1] Item 3 (updated)",
                "[1] Item 4 (updated)",
                "[1] Item 5 (updated)",
                "[1] Item 6 (inserted)",
                "[1] Item 7 (inserted)",
                "[1] Item 8 (inserted)",
                "[1] Item 9 (inserted)",
                "[1] Item 6 (original)",
                "[1] Item 7 → 11 (updated)",
                "[1] Item 8 (original)",
                "[1] Item 9 (original)",
            ],
            app: app
        )
    }
}

func AssertDisplayingCells(
    cellText: [String],
    app: XCUIApplication,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(app.collectionViews.cells.count, cellText.count, message(), file: file, line: line)
    let allCellTexts = app.collectionViews.cells.allElementsBoundByIndex.map(\.staticTexts.firstMatch.label)
    XCTAssertEqual(allCellTexts, cellText, message(), file: file, line: line)
}
