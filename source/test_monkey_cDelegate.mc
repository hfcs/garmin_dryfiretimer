import Toybox.Lang;
import Toybox.WatchUi;

class test_monkey_cDelegate extends WatchUi.BehaviorDelegate {

    private var _timer_logic as timer_logic;

    function initialize(logic as timer_logic) {
        BehaviorDelegate.initialize();
        _timer_logic = logic;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new test_monkey_cMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }


    function onKey(keyEvent) {
        var key = keyEvent.getKey() as Toybox.Lang.Object;
        System.println(key);  // e.g. KEY_MENU = 7
        System.println(keyEvent.getType() as Toybox.Lang.Object); // e.g. PRESS_TYPE_DOWN = 0
        if (key == KEY_ESC) {
            return false;
        }            
        else {
            if (key == KEY_ENTER) {
                _timer_logic.handleStart();
                return false;
            } else if (key == KEY_DOWN) {
                _timer_logic.handleReset();
                return false;
            } else
            {
                return true;
            }
        }
    }

}