import XCTest

final class ComposedUITestsUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_AllUpdates() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()

        if #available(iOS 14, *) {
            app.navigationBars.buttons["Apply..."].tap()
            app.buttons["All Updates"].tap()
        } else {
            app.navigationBars.buttons["Apply"].tap()
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
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Update → Insert → Update → Remove → Update"].tap()
        app.navigationBars.buttons["Apply..."].tap()
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
        app.navigationBars.buttons["Apply..."].tap()
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
        app.navigationBars.buttons["Apply..."].tap()
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
            app.navigationBars.buttons["Apply..."].tap()
            app.buttons["All Updates"].tap()
        } else {
            app.navigationBars.buttons["Apply"].tap()
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
        app.navigationBars.buttons["Apply..."].tap()
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
        app.navigationBars.buttons["Apply..."].tap()
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
        app.navigationBars.buttons["Apply..."].tap()
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

    func testItemUpdatesWithSectionRemovals_1Update() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Removals"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (1) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 1, 1 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (original)",
                "[1] Item 3, 1 (original)",
                "[1] Item 4, 0 (original)",
                "[1] Item 4, 1 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionRemovals_2Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Removals"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (2) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 1, 1 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (original)",
                "[1] Item 3, 1 (original)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 4, 1 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionRemovals_3Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Removals"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (3) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (original)",
                "[1] Item 3, 1 (original)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 4, 1 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionRemovals_4Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Removals"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (4) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 4, 1 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionRemovals_AllUpdates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Removals"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply All Updates"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (original)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 4, 1 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_1Update() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (1) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (original)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_2Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (2) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (updated)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_3Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (3) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (inserted)",
                "[1] Item 3, 1 (inserted)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (updated)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_4Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (4) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (inserted)",
                "[1] Item 3, 1 (inserted)",
                "[1] Item 4, 0 (inserted)",
                "[1] Item 4, 1 (inserted)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (updated)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_5Updates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply First (5) update(s)"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (inserted)",
                "[1] Item 3, 1 (inserted)",
                "[1] Item 4, 0 (inserted)",
                "[1] Item 4, 1 (inserted)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 7, 0 (inserted)",
                "[1] Item 7, 1 (inserted)",
            ],
            app: app
        )
    }

    func testItemUpdatesWithSectionInserts_AllUpdates() throws {
        if #unavailable(iOS 14) {
            throw XCTSkip("This test requires iOS 14+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Item Reloads → Section Inserts"].tap()
        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["Apply All Updates"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (inserted)",
                "[1] Item 0, 0 (original)",
                "[1] Item 1, 0 (original)",
                "[1] Item 2, 0 (original)",
                "[1] Item 2, 1 (updated)",
                "[1] Item 3, 0 (inserted)",
                "[1] Item 3, 1 (inserted)",
                "[1] Item 4, 0 (inserted)",
                "[1] Item 4, 1 (inserted)",
                "[1] Item 3, 0 (original)",
                "[1] Item 4, 0 (updated)",
                "[1] Item 7, 0 (inserted)",
                "[1] Item 7, 1 (inserted)",
            ],
            app: app
        )
    }

    func testRemove_RemoveLast_ReloadLast_Composed() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Remove, Remove Last, Reload Last"].tap()
        app.navigationBars.firstMatch.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (updated)",
                "[1] Item 0, 3 → 0, 2 (updated)",
            ],
            app: app
        )
    }

    func testRemove_ReloadLast_Composed() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Composed] Remove, Reload Last"].tap()
        app.navigationBars.firstMatch.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 3 → 0, 1 (updated)",
                "[1] Item 0, 4 → 0, 2 (updated)",
            ],
            app: app
        )
    }

    func testRemove_ReloadLast_Manual() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Remove, Reload Last"].tap()
        app.navigationBars.firstMatch.buttons["Apply"].tap()

        // This validates that the bug was introduced in iOS 15 (which is when the reconfigure API
        // was also introduced)
        if #available(iOS 15, *) {
            AssertDisplayingCells(
                cellText: [
                    "[1] Item 0, 0 (original)",
                    "[1] Item 0, 1 (updated)",
                    "[1] Item 0, 3 (original)",
                ],
                app: app
            )
        } else {
            AssertDisplayingCells(
                cellText: [
                    "[1] Item 0, 0 (original)",
                    "[1] Item 0, 1 (updated)",
                    "[1] Item 0, 3 → 0, 2 (updated)",
                ],
                app: app
            )
        }
    }

    func testRemove_ReconfigureLast_Manual() throws {
        if #unavailable(iOS 15) {
            throw XCTSkip("This test requires iOS 15+")
        }

        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.staticTexts["[Manual] Remove, Reconfigure Last"].tap()
        app.navigationBars.firstMatch.buttons["Apply"].tap()

        // This is not the outcome we want but validates the understanding of the API (that items
        // reconfigured in a batch updates are updated immediately and do not account for other
        // changes to the indexes).
        AssertDisplayingCells(
            cellText: [
                "[1] Item 0, 0 (original)",
                "[1] Item 0, 1 (updated)",
                "[1] Item 0, 3 (original)",
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
    XCTAssertEqual(app.collectionViews.cells.count, cellText.count, "Expected \(cellText.count), but found \(app.collectionViews.cells.count)", file: file, line: line)
    let allCellTexts = app.collectionViews.cells.allElementsBoundByIndex.map(\.staticTexts.firstMatch.label)
    XCTAssertEqual(allCellTexts, cellText, message(), file: file, line: line)
}
