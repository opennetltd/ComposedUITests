import XCTest

final class ComposedIntegrationTestsUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    func testComposedUpdateInsertUpdateRemoveUpdate_AllUpdates() throws {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["All Updates"].tap()

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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply..."].tap()
        app.buttons["All Updates"].tap()

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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Update → Insert → Update → Remove → Update\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Removals\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Removals\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Removals\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Removals\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Removals\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Reloads → Section Inserts\"",
        ]
        app.launch()
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
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Remove, Remove Last, Reload Last\"",
        ]
        app.launch()
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
        app.launchArguments = [
            "-StartingTest",
            "\"[Composed] Remove, Reload Last\"",
        ]
        app.launch()

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
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Remove, Reload Last\"",
        ]
        app.launch()
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
        app.launchArguments += [
            "-StartingTest",
            "\"[Manual] Remove, Reconfigure Last\"",
        ]
        app.launch()
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

    func testInsertThenFooter() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Footer\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Inserted",
                "Surviving item",
            ],
            footerText: [
                "Footer",
                "Updated market footer",
            ],
            app: app
        )

    }

    func testInsertThenFooterThenRemoveInserted() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Footer → Cancel Insert\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testFooterResize() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Resize Footer\"",
        ]
        app.launch()

        XCTAssertEqual(app.staticTexts["Market footer"].frame.height, 25, accuracy: 1)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

        XCTAssertEqual(app.staticTexts["Updated market footer"].frame.height, 75, accuracy: 1)

    }

    func testFooterOnly() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Footer\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Surviving item",
            ],
            footerText: [
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Updated market footer",
            ],
            app: app
        )

    }

    func testFooterThenRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Footer → Remove Sections\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testFooterThenMoveAndRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Footer → Move → Remove Sections\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testInsertThenFooterThenMoveAndRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Footer → Move → Remove\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testInsertThenFooterThenMoveAndRemoveWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Footer → Move → Remove\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testFooter390Visible() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Footer 390 → 63 Sections (Visible)\"",
        ]
        app.launch()

        XCTAssertTrue(app.staticTexts["Market footer"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            footerText: [
                "Updated market footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testFooter390VisibleWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Footer 390 → 63 Sections (Visible)\"",
        ]
        app.launch()

        XCTAssertTrue(app.staticTexts["Market footer"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            footerText: [
                "Updated market footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testFooter390Offscreen() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Footer 390 → 63 Sections (Offscreen)\"",
        ]
        app.launch()

        XCTAssertFalse(app.staticTexts["Market footer"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            footerText: [
                "Updated market footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testFooter390OffscreenWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Footer 390 → 63 Sections (Offscreen)\"",
        ]
        app.launch()

        XCTAssertFalse(app.staticTexts["Market footer"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            footerText: [
                "Updated market footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
                "Footer",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testFooterOutsideBatch() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Footer Outside Batch\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            footerText: [
                "Updated market footer",
            ],
            app: app
        )

    }

    func testFooterThenRemoveContainingSection() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Footer → Remove Containing Section\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [],
            footerText: [],
            app: app
        )

    }

    func testInsertThenHeader() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Header\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Inserted",
                "Surviving item",
            ],
            headerText: [
                "Header",
                "Updated market header",
            ],
            app: app
        )

    }

    func testInsertThenHeaderThenRemoveInserted() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Header → Cancel Insert\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testHeaderResize() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Resize Header\"",
        ]
        app.launch()

        XCTAssertEqual(app.staticTexts["Market header"].frame.height, 25, accuracy: 1)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

        XCTAssertEqual(app.staticTexts["Updated market header"].frame.height, 75, accuracy: 1)

    }

    func testHeaderOnly() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Header\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Surviving item",
            ],
            headerText: [
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Updated market header",
            ],
            app: app
        )

    }

    func testHeaderThenRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Header → Remove Sections\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testHeaderThenMoveAndRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Header → Move → Remove Sections\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testInsertThenHeaderThenMoveAndRemove() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Header → Move → Remove\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testInsertThenHeaderThenMoveAndRemoveWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Insert → Refresh Header → Move → Remove\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testHeader390Visible() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Header 390 → 63 Sections (Visible)\"",
        ]
        app.launch()

        XCTAssertTrue(app.staticTexts["Market header"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            headerText: [
                "Updated market header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testHeader390VisibleWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Header 390 → 63 Sections (Visible)\"",
        ]
        app.launch()

        XCTAssertTrue(app.staticTexts["Market header"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            headerText: [
                "Updated market header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testHeader390Offscreen() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Header 390 → 63 Sections (Offscreen)\"",
        ]
        app.launch()

        XCTAssertFalse(app.staticTexts["Market header"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            headerText: [
                "Updated market header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testHeader390OffscreenWithAnimations() {
        let app = XCUIApplication()
        app.launchArguments.append("--enable-regression-animations")
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Header 390 → 63 Sections (Offscreen)\"",
        ]
        app.launch()

        XCTAssertFalse(app.staticTexts["Market header"].exists)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
                "Section 0",
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
                "Section 5",
                "Section 6",
                "Section 7",
                "Section 8",
                "Section 9",
                "Section 10",
                "Section 11",
                "Section 12",
                "Section 13",
                "Section 14",
                "Section 15",
                "Section 16",
                "Section 17",
                "Section 18",
                "Section 19",
                "Section 20",
                "Section 21",
                "Section 22",
                "Section 23",
                "Section 24",
                "Section 25",
                "Section 26",
                "Section 27",
                "Section 28",
                "Section 29",
                "Section 30",
                "Section 31",
                "Section 32",
                "Section 33",
                "Section 34",
                "Section 35",
                "Section 36",
                "Section 37",
                "Section 38",
                "Section 39",
                "Section 40",
                "Section 41",
                "Section 42",
                "Section 43",
                "Section 44",
                "Section 45",
                "Section 46",
                "Section 47",
                "Section 48",
                "Section 49",
                "Section 50",
                "Section 51",
                "Section 52",
                "Section 53",
                "Section 54",
                "Section 55",
                "Section 56",
                "Section 57",
                "Section 58",
                "Section 59",
                "Section 60",
                "Section 61",
            ],
            headerText: [
                "Updated market header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
                "Header",
            ],
            scrollThroughContent: true,
            app: app
        )

    }

    func testHeaderOutsideBatch() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Header Outside Batch\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [
                "Surviving item",
            ],
            headerText: [
                "Updated market header",
            ],
            app: app
        )

    }

    func testHeaderThenRemoveContainingSection() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Refresh Header → Remove Containing Section\"",
        ]
        app.launch()

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(
            cellText: [],
            headerText: [],
            app: app
        )

    }

    func testItemRemovalThenSurroundingSectionRemovals() {
        let app = XCUIApplication()
        app.launchArguments += [
            "-StartingTest",
            "\"[Composed] Item Removal → Surrounding Section Removals\"",
        ]
        app.launch()
        AssertDisplayingCells(cellText: ["Earlier item", "Surviving item", "Later item"], app: app)

        app.navigationBars.buttons["Apply"].tap()

        AssertDisplayingCells(cellText: [], headerText: [], footerText: [], app: app)
    }
}

func AssertDisplayingCells(
    cellText: [String],
    headerText: [String]? = nil,
    footerText: [String]? = nil,
    scrollThroughContent: Bool = false,
    app: XCUIApplication,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    func firstStaticTextLabel(in snapshot: XCUIElementSnapshot) -> String? {
        if snapshot.elementType == .staticText {
            return snapshot.label
        }
        return snapshot.children.lazy.compactMap { firstStaticTextLabel(in: $0) }.first
    }

    let collectionView = app.collectionViews.firstMatch
    if scrollThroughContent {
        let updatesCompleted = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value == %@", "updates-complete"),
            object: collectionView,
        )
        guard XCTWaiter.wait(for: [updatesCompleted], timeout: 5) == .completed else {
            XCTFail("The fixture did not finish updating and scrolling to the top", file: file, line: line)
            return
        }
    }
    var allCellTexts: [String] = []
    var cellIDs: Set<String> = []
    var headerIDs: [String] = []
    var footerIDs: [String] = []
    var headers: [String: String] = [:]
    var footers: [String: String] = [:]

    // Large fixtures are virtualized: collect each snapshot while scrolling from the
    // top. Stable fixture identifiers distinguish reused views and survive section moves.
    for _ in 0..<(scrollThroughContent ? cellText.count + 1 : 1) {
        let previousCount = allCellTexts.count + headers.count + footers.count
        // Index-bound elements resolve again when read and can disappear during layout.
        // Read all attributes from the same immutable snapshot instead.
        let snapshot: XCUIElementSnapshot
        do {
            snapshot = try collectionView.snapshot()
        } catch {
            XCTFail("Could not snapshot collection view: \(error)", file: file, line: line)
            return
        }
        var descendants: [XCUIElementSnapshot] = []
        var remaining = Array(snapshot.children.reversed())
        while let element = remaining.popLast() {
            descendants.append(element)
            remaining.append(contentsOf: element.children.reversed())
        }
        let cells = descendants.filter { $0.elementType == .cell }
        if scrollThroughContent {
            for cell in cells where cellIDs.insert(cell.identifier).inserted {
                allCellTexts.append(firstStaticTextLabel(in: cell) ?? "")
            }
        } else {
            allCellTexts = cells.map { firstStaticTextLabel(in: $0) ?? "" }
        }
        for header in descendants where header.elementType == .staticText && header.identifier.hasPrefix("regression-header-") {
            if headers[header.identifier] == nil { headerIDs.append(header.identifier) }
            headers[header.identifier] = header.label
        }
        for footer in descendants where footer.elementType == .staticText && footer.identifier.hasPrefix("regression-footer-") {
            if footers[footer.identifier] == nil { footerIDs.append(footer.identifier) }
            footers[footer.identifier] = footer.label
        }
        if allCellTexts.count >= cellText.count,
           headers.count >= (headerText?.count ?? 0),
           footers.count >= (footerText?.count ?? 0) {
            break
        }
        if previousCount == allCellTexts.count + headers.count + footers.count { break }
        if scrollThroughContent {
            let start = collectionView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.75))
            let end = collectionView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.35))
            start.press(forDuration: 0.1, thenDragTo: end, withVelocity: .slow, thenHoldForDuration: 0.1)
        }
    }

    XCTAssertEqual(allCellTexts, cellText, message(), file: file, line: line)
    if let headerText {
        let actual = headerIDs.compactMap { headers[$0] }
        XCTAssertEqual(actual, headerText, message(), file: file, line: line)
    }
    if let footerText {
        let actual = footerIDs.compactMap { footers[$0] }
        XCTAssertEqual(actual, footerText, message(), file: file, line: line)
    }

}
