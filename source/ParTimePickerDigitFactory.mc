import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class ParTimePickerDigitFactory extends WatchUi.PickerFactory {
    private var _start as Number;
    private var _stop as Number;
    private var _increment as Number;
    private var _subDecimal as Boolean;
    private var _font = Graphics.FONT_NUMBER_MEDIUM;

    public function initialize(start as Number, stop as Number, increment as Number, options as {
        :subDecimal as Boolean
    }) {
        PickerFactory.initialize();

        _start = start;
        _stop = stop;
        _increment = increment;

        var subDecimal = options.get(:subDecimal);
        if (subDecimal != null) {
            _subDecimal = subDecimal;
        } else {
            _subDecimal = false;
        }
    }

    public function getIndex(value as Number) as Number {
        return (value / _increment) - _start;
    }

    public function getDrawable(index as Number, selected as Boolean) as Drawable? {
        var value = getValue(index);
        var text = "No item";
        if (value instanceof Number) {
            text = value.format("%d");
        }
        if (_subDecimal) {
            text = "." + text;
        }
        return new WatchUi.Text({:text=>text, :color=>Graphics.COLOR_WHITE, :font=>_font,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
    }

    public function getValue(index as Number) as Object? {
        return _start + (index * _increment);
    }

    public function getSize() as Number {
        return (_stop - _start) / _increment + 1;
    }

}
