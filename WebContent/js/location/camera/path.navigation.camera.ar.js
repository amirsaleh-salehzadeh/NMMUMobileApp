//DEBUG = true;
function testARAlert(){
	alert("IT WORKS DUMBASS");
}
//	window.addEventListener('load', function() {
//	    // initialize awe after page loads
//	    window.awe.init({
//	      // automatically detect the device type
//	      device_type: awe.AUTO_DETECT_DEVICE_TYPE,
//	      // populate some default settings
//	      settings: {
//	      	container_id: 'container',
//	        fps: 30,
//	        default_camera_position: { x:0, y:0, z:0 },
//	        default_lights:[
//	          {
//	            id: 'point_light',
//	            type: 'point',
//	            color: 0xFFFFFF
//	          },
//	        ],
//	      },
//	      ready: function() {
//	        // load js files based on capability detection then setup the scene if successful
//	        awe.util.require([
//	          {
//	            capabilities: ['gum','gyro','webgl'],
//	            files: [ 
//	              [ '../../js/awe-standard-dependencies.js', '../../js/awe-standard.js' ], // core dependencies for this app 
//	              '../../js/awe-standard-window_resized.js', // window resize handling plugin
//	              '../../js/awe-standard-object_clicked.js', // object click/tap handling plugin
//	              'awe.geo_ar.js', // geo ar plugin
//	            ],
//	            success: function() { 
//	              // limit demo to supported devices
//	              // NOTE: only Chrome and Firefox has implemented the DeviceOrientation API in a workable way
//	              //       so for now we are excluding all others to make sure your first experience is a happy one
//	              var device_type = awe.device_type();
//	              var browser_unsupported = false;
//	              if (device_type != 'android') {
//	                browser_unsupported = true;
//	              } else if (!navigator.userAgent.match(/chrome|firefox/i)) {
//	                browser_unsupported = true;
//	              }
//	              if (browser_unsupported) {
//	                document.body.innerHTML = '<p>This demo currently requires a standards compliant Android browser (e.g. Chrome M33).</p>';
//	                return;
//	              }
//
//	              // setup and paint the scene
//				        window.awe.setup_scene();
//				
//	              // setup some code to handle when an object is clicked/tapped
//	              window.addEventListener('object_clicked', function(e) { 
//	                var p = awe.projections.view(e.detail.projection_id);
//	                awe.projections.update({ // rotate clicked object by 180 degrees around x and y axes over 10 seconds
//	                  data:{
//	                    animation: {
//	                      duration: 10,
//	                    },
//	                    rotation:{ y: p.rotation.y+180, x: p.rotation.x+180 }
//	                  },
//	                  where:{ id:e.detail.projection_id }
//	                });
//	              }, false);
//
//				        // add some points of interest (poi) for each of the compass points
//				        awe.pois.add({ id:'north', position: { x:0, y:0, z:200 } });
//				        awe.pois.add({ id:'north_east', position: { x:200, y:0, z:200 } });
//				        awe.pois.add({ id:'east', position: { x:200, y:0, z:0 } });
//				        awe.pois.add({ id:'south_east', position: { x:200, y:0, z:-200 } });
//				        awe.pois.add({ id:'south', position: { x:0, y:0, z:-200 } });
//				        awe.pois.add({ id:'south_west', position: { x:-200, y:0, z:-200 } });
//				        awe.pois.add({ id:'west', position: { x:-200, y:0, z:0 } });
//				        awe.pois.add({ id:'north_west', position: { x:-200, y:0, z:200 } });
//				
//				        // add projections to each of the pois
//				        awe.projections.add({ 
//				          id:'n', 
//				          geometry:{ shape:'cube', x:50, y:50, z:50 }, 
//	                rotation:{ x:30, y:30, z:0 },
//				          material:{ 
//				            type: 'phong',
//				            color:0xFF0000, 
//				          },
//				        }, { poi_id: 'north' });
//
//				        awe.projections.add({ 
//				          id:'ne', 
//				          geometry:{ shape:'sphere', radius:10 }, 
//				          material:{ 
//				            type: 'phong',
//				            color:0xCCCCCC, 
//				          },
//				        }, { poi_id: 'north_east' });
//
//				        awe.projections.add({ 
//				          id:'e', 
//				          geometry:{ shape:'cube', x:50, y:50, z:50 }, 
//	                rotation:{ x:30, y:30, z:0 },
//				          material:{ 
//				            type: 'phong',
//				            color:0x00FF00, 
//				          },
//				        }, { poi_id: 'east' });
//
//				        awe.projections.add({ 
//				          id:'se', 
//				          geometry:{ shape:'sphere', radius:10 }, 
//				          material:{ 
//				            type: 'phong',
//				            color:0xCCCCCC, 
//				          },
//				        }, { poi_id: 'south_east' });
//
//				        awe.projections.add({ 
//				          id:'s', 
//				          geometry:{ shape:'cube', x:50, y:50, z:50 }, 
//	                rotation:{ x:30, y:30, z:0 },
//				          material:{ 
//				            type: 'phong',
//				            color:0xFFFFFF, 
//				          },
//				        }, { poi_id: 'south' });
//
//				        awe.projections.add({ 
//				          id:'sw', 
//				          geometry:{ shape:'sphere', radius:10 }, 
//				          material:{ 
//				            type: 'phong',
//				            color:0xCCCCCC, 
//				          },
//				        }, { poi_id: 'south_west' });
//
//				        awe.projections.add({ 
//				          id:'w', 
//				          geometry:{ shape:'cube', x:50, y:50, z:50 }, 
//	                rotation:{ x:30, y:30, z:0 },
//				          material:{ 
//				            type: 'phong',
//				            color:0x0000FF, 
//				          },
//				        }, { poi_id: 'west' });
//
//				        awe.projections.add({ 
//				          id:'nw', 
//				          geometry:{ shape:'sphere', radius:10 }, 
//				          material:{ 
//				            type: 'phong',
//				            color:0xCCCCCC, 
//				          },
//				        }, { poi_id: 'north_west' });
//				
//	            },
//	          },
//	          { // else create a fallback
//	            capabilities: [],
//	            files: [],
//	            success: function() { 
//	              document.body.innerHTML = '<p>This demo currently requires a standards compliant mobile browser (e.g. Firefox on Android). NOTE: iOS does not currently support WebGL or WebRTC and has not implemented the DeviceOrientation API correctly. Please see <a href="http://lists.w3.org/Archives/Public/public-geolocation/2014Jan/0000.html">this post to the W3C GeoLocation Working Group</a> for more detailed information.</p>';
//	              return;
//	            },
//	          },
//	        ]);
//	      }
//	    });
//	  });

//function startAR() {
//	var video = document.getElementById('videoContent');
//	var canvas = document.createElement('canvas');
//	canvas.width = $("#cameraView").css('width');
//	canvas.height = $("#cameraView").css('height');
//	canvas.id = "ARPres";
//	var ctx = canvas.getContext('2d');
//	var debugCanvas = document.createElement('canvas');
//	debugCanvas.width = 320;
//	debugCanvas.height = 240;
//	debugCanvas.id = 'debugCanvas';
//	document.getElementById('cameraView').appendChild(debugCanvas);
//	var raster = new NyARRgbRaster_Canvas2D(canvas);
//	var param = new FLARParam($("#cameraView").css('width'), $("#cameraView")
//			.css('height'));
//	var resultMat = new NyARTransMatResult();
//	var detector = new FLARMultiIdMarkerDetector(param, 80);
//	detector.setContinueMode(true);
//	var glCanvas = document.createElement('canvas');
//	glCanvas.width = $("#cameraView").css('width');
//	glCanvas.height = $("#cameraView").css('height');
//	glCanvas.style.zIndex = 20001;
//	glCanvas.id = "ARPresGL";
//	// document.body.appendChild(glCanvas);
//	document.getElementById('cameraView').appendChild(glCanvas);
//
//	var display = new Magi.Scene(glCanvas);
//	// get the camera matrix from param and copy it to given 16-elem
//	// Float32Array
//	// 100 is near plane, 10000 is far plane
//	param.copyCameraMatrix(display.camera.perspectiveMatrix, 100, 10000);
//	display.camera.useProjectionMatrix = true;
//	var videoTex = new Magi.FlipFilterQuad();
//	// use the detect canvas as the video texture to keep video and detection in
//	// sync
//	videoTex.material.textures.Texture0 = new Magi.Texture();
//	videoTex.material.textures.Texture0.image = canvas;
//	videoTex.material.textures.Texture0.generateMipmaps = false;
//	display.scene.appendChild(videoTex);
//	var times = [];
//	var pastResults = {};
//	var lastTime = 0;
//	var cubes = {};
//	// video frame loop
//	display.scene.addFrameListener(function() {
//		console.log(canvas.width);
//		if (video.paused)
//			return;
//		if (window.paused)
//			return;
//		if (video.currentTime == lastTime)
//			return;
//		lastTime = video.currentTime;
//		ctx.drawImage(video, 0, 0, $("#cameraView").css('width'), $(
//				"#cameraView").css('height')); // draw video to canvas
//		var dt = new Date().getTime();
//		canvas.changed = true;
//		videoTex.material.textures.Texture0.changed = true;
//		videoTex.material.textures.Texture0.upload();
//		var t = new Date();
//		var detected = detector.detectMarkerLite(raster, 170);
//		for ( var idx = 0; idx < detected; idx++) {
//			var id = detector.getIdMarkerData(idx);
//			var currId;
//			if (id.packetLength > 4) {
//				currId = -1;
//			} else {
//				currId = 0;
//				for ( var i = 0; i < id.packetLength; i++) {
//					currId = (currId << 8) | id.getPacketData(i);
//				}
//			}
//			if (!pastResults[currId]) {
//				pastResults[currId] = {};
//			}
//			detector.getTransformMatrix(idx, resultMat);
//			pastResults[currId].age = 0;
//			pastResults[currId].transform = Object.asCopy(resultMat);
//			if (idx == 0)
//				times.push(new Date() - t);
//		}
//		// create cubes on top of the results
//		for ( var i in pastResults) {
//			var r = pastResults[i];
//			if (r.age > 5)
//				delete pastResults[i];
//			r.age++;
//		}
//		for ( var i in cubes)
//			cubes[i].display = false;
//		for ( var i in pastResults) {
//			if (!cubes[i]) {
//				var pivot = new Magi.Node();
//				pivot.transform = mat4.identity();
//				pivot.setScale(80);
//				var cube;
//				cube = new Magi.Cube();
//				cube.setZ(-0.125);
//				cube.scaling[2] = 0.25;
//				pivot.appendChild(cube);
//				var txt = new Magi.Text(i.toString());
//				txt.setColor('black');
//				txt.setFontSize(48);
//				txt.setAlign(txt.centerAlign, txt.bottomAlign).setZ(-0.6).setY(
//						-0.34).setScale(1 / 80);
//				cube.appendChild(txt);
//				pivot.cube = cube;
//				pivot.txt = txt;
//				display.scene.appendChild(pivot);
//				cubes[i] = pivot;
//			}
//			cubes[i].display = true;
//			cubes[i].txt.setText(i.toString());
//			var mat = pastResults[i].transform;
//			// set transform matrix for the cube
//			// using a copy of the resultMat we got back above
//			var cm = cubes[i].transform;
//			cm[0] = mat.m00;
//			cm[1] = -mat.m10;
//			cm[2] = mat.m20;
//			cm[3] = 0;
//			cm[4] = mat.m01;
//			cm[5] = -mat.m11;
//			cm[6] = mat.m21;
//			cm[7] = 0;
//			cm[8] = -mat.m02;
//			cm[9] = mat.m12;
//			cm[10] = -mat.m22;
//			cm[11] = 0;
//			cm[12] = mat.m03;
//			cm[13] = -mat.m13;
//			cm[14] = mat.m23;
//			cm[15] = 1;
//		}
//		if (detected == 0)
//			times.push(new Date() - t);
//		if (times.length > 100) {
//			if (window.console)
//				console.log(times.reduce(function(s, i) {
//					return s + i;
//				}) / times.length)
//			times.splice(0);
//		}
//	});
//}