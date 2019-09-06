float min(Table table, String prop) {
  float minVal = Float.MAX_VALUE;
  for (TableRow row : table.rows()) {
    float val = row.getFloat(prop);
    if (val<minVal) {
      minVal = val;
    }
  }
  return minVal;
}

float max(Table table, String prop) {
  float maxVal = Float.MIN_VALUE;
  for (TableRow row : table.rows()) {
    float val = row.getFloat(prop);
    if (val>maxVal) {
      maxVal = val;
    }
  }
  return maxVal;
}

void setupVideoMapping()
{
  syphonServer = new SyphonServer(this, "Processing Syphon");

  videoMapperAddress = new NetAddress("127.0.0.1", videoMapperPort);

  OscMessage videoMapperMessage = new OscMessage("/SwitchSyphonClient");
  videoMapperMessage.add(sketchName); //It must contain the same name as the Sketch
  videoMapperMessage.add("Processing Syphon");
  videoMapperMessage.add(1.0);
  
  oscP5 = new OscP5(this, trackerReceivePort);
  oscP5.send(videoMapperMessage, videoMapperAddress);
}


//async function loadData(file){

//	let theData = [];
//	await d3.csv(file, function (d) {
//		return autocast(d);
//	}).then(function (csv) {
//		theData = csv;

//	});

//	return theData;
//}


//function autocast(d) {
//	let keys = _.keys(d);

//	let obj = {};
//	keys.forEach(key => {
//	 if (!isNaN(d[key])) {
//		//we have a number
//		obj[key] = +d[key];
//	  } else {
//		obj[key] = d[key];
//	  }
//	});
//	return obj;
//  }
