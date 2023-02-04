import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class DryFireTimerView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        var deviceSettings = System.getDeviceSettings();
        if (deviceSettings.screenHeight > 230) {
            // Regular Fenix 7s/Forerunner 955 got a 240 pixels or taller round screen
            setLayout(Rez.Layouts.MainLayoutLargeRound(dc));
        } else if (deviceSettings.screenHeight > 200) {
            // Forerunner 55 got a ~200 pixel round screen
            setLayout(Rez.Layouts.MainLayoutMediumRound(dc));
        } else {
            // Instinct 2 got a < 180 pixel screen
            setLayout(Rez.Layouts.MainLayoutSmallRound(dc));
        }
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var statusPromptLable = View.findDrawableById("StatusPromptLabel") as WatchUi.Text;
        statusPromptLable.setText($.DryFireTimerLogic.getInstance().getStatusPromptText());
        var timerLabel = View.findDrawableById("CountdownLabel") as WatchUi.Text;
        timerLabel.setText($.DryFireTimerLogic.getInstance().getTimerText());
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

class DryFireTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    protected function launchParTimePicker() as Void {
        WatchUi.pushView(new $.ParTimePicker(), new $.ParTimePickerDelegate(), WatchUi.SLIDE_RIGHT);
    }

    function onPreviousPage() as Boolean { // easier to trigger by "next" button, Menu action will keep incrementing
        launchParTimePicker();
        return true;
    }

    function onMenu() as Boolean {
        launchParTimePicker();
        return true;
    }

    function onKey(keyEvent) {
        var key = keyEvent.getKey() as Toybox.Lang.Object;
        if (key == KEY_ESC) {
            return false;
        }            
        else {
            if (key == KEY_ENTER) {
                $.DryFireTimerLogic.getInstance().handleStart();
                return false;
            } else if (key == KEY_DOWN) {
                $.DryFireTimerLogic.getInstance().handleReset();
                return false;
            } else {
                return true;
            }
        }
    }

}
