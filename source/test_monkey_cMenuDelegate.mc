import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class test_monkey_cMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("foo");
        } else if (item == :item_2) {
            System.println("bar");
        }
    }

}