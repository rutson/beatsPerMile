using Toybox.WatchUi as Ui;
using Toybox.Math;

class beatsPerMileView extends Ui.SimpleDataField {

	// muiltiplication factor for metres/minute to minutes per [mile|kilometre]
	var factor;
	// system units for pace
	var paceUnits;
	
    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        // get paceunits (metric/imperial)
        paceUnits = System.getDeviceSettings().paceUnits;
        if (System.UNIT_METRIC == paceUnits) {
	        label = "bpKm";
	        // 1mps = 16.666666666667 min/km
	        factor = 16.666666666667;
		} else {
	        label = "bpMile";
	        // 1 mps = 26.8224 min/mile
	        factor = 26.8224;		
		}        
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
    	if(info.currentSpeed == null || info.currentHeartRate == null || info.currentSpeed == 0) {
	   		return "--";
	   	} else {
	        // See Activity.Info in the documentation for available information.
	        var vel = info.currentSpeed; // in metres/second
	        var mpm = factor/vel; // minutes per mile (or kilometre!)
			var output = mpm * info.currentHeartRate; 
	        return output.toNumber();
	   	}
    }

}