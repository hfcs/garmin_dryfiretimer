import Toybox.WatchUi;
import Toybox.Lang;

const SECOND_FACTORY_INDEX = 0;
const SUB_SECOND_FACTORY_INDEX = 1;
const MAX_PAR_SECOND = 30;

class ParTimePicker extends WatchUi.Picker {
    public function initialize() {
        var title = new WatchUi.Text({:text=>$.Rez.Strings.ParTimePickerTitle, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});

        var factories = new Array<PickerFactory or Text>[SUB_SECOND_FACTORY_INDEX + 1];
        factories[SECOND_FACTORY_INDEX] = new $.ParTimePickerDigitFactory(0, MAX_PAR_SECOND, 1, {});
        factories[SUB_SECOND_FACTORY_INDEX] = new $.ParTimePickerDigitFactory(0, 9, 1, {:subDecimal=>true});

        var defaults = new Array<Number>[factories.size()];
        var defaultParTime = $.DryFireTimerLogic.getParTime();
        if (defaultParTime != null) {
            var parSecond = defaultParTime/1000;
            defaults[SECOND_FACTORY_INDEX] = (factories[SECOND_FACTORY_INDEX] as ParTimePickerDigitFactory).getIndex(parSecond);
            var parSubSecond = 0;
            if ((defaultParTime % 1000) != 0) {
                parSubSecond = (defaultParTime % 1000) / 100;
            }
            defaults[SUB_SECOND_FACTORY_INDEX] = (factories[SUB_SECOND_FACTORY_INDEX] as ParTimePickerDigitFactory).getIndex(parSubSecond);
        }
        
        //var nextArrow = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.nextArrow, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
        //var previousArrow = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.previousArrow, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
        //var brush = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.brush, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
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
        $.DryFireTimerLogic.setParTime(values[SECOND_FACTORY_INDEX]*1000 + values[SUB_SECOND_FACTORY_INDEX]*100);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}