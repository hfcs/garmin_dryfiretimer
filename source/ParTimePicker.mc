import Toybox.WatchUi;
import Toybox.Lang;

const SECOND_FACTORY_INDEX = 0;
const DOT_SEPERATOR_FACTORY_INDEX = 1;
const SUB_SECOND_FACTORY_INDEX = 2;
const MAX_PAR_SECOND = 30;
const PAR_ZERO_POINT_FIVE_SECOND = 5;

class ParTimePicker extends WatchUi.Picker {
    public function initialize() {
        var title = new WatchUi.Text({:text=>$.Rez.Strings.ParTimePickerTitle, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});

        var factories = new Array<PickerFactory or Text>[3];
        factories[SECOND_FACTORY_INDEX] = new $.NumberFactory(0, MAX_PAR_SECOND, 1, {});
        factories[DOT_SEPERATOR_FACTORY_INDEX] = new WatchUi.Text({:text=>$.Rez.Strings.ParTimeDotSeparator, :font=>Graphics.FONT_NUMBER_HOT,
           :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
        factories[SUB_SECOND_FACTORY_INDEX] = new $.NumberFactory(0, PAR_ZERO_POINT_FIVE_SECOND, PAR_ZERO_POINT_FIVE_SECOND, {});

        var defaults = new Array<Number>[factories.size()];
        var defaultParTime = $.timer_logic.getParTime();
        if (defaultParTime != null) {
            var parSecond = defaultParTime/1000;
            defaults[SECOND_FACTORY_INDEX] = (factories[SECOND_FACTORY_INDEX] as NumberFactory).getIndex(parSecond);
            var parSubSecond = 0;
            if ((defaultParTime % 1000) != 0) {
                parSubSecond = PAR_ZERO_POINT_FIVE_SECOND;
            }
            defaults[DOT_SEPERATOR_FACTORY_INDEX] = 0;
            defaults[SUB_SECOND_FACTORY_INDEX] = (factories[SUB_SECOND_FACTORY_INDEX] as NumberFactory).getIndex(parSubSecond);
        }
        
        //var nextArrow = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.nextArrow, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
        //var previousArrow = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.previousArrow, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
        //var brush = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.brush, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults, :nextArrow=>null, :previousArrow=>null, :confirm=>null});
    }
}

class ParTimePickerDelegate extends WatchUi.BehaviorDelegate {
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    public function onAccept(values as Array<Number?>) as Boolean {
        $.timer_logic.setParTime(values[0]*1000 + values[2]*100);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}