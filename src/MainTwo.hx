package;

import three.geometries.CylinderGeometry;
import js.Lib;
import three.materials.MeshBasicMaterial;
import three.materials.MeshLambertMaterial;
import three.materials.LineBasicMaterial;
import three.objects.LineSegments;
import three.geometries.EdgesGeometry;
import js.Browser.document;
import js.Browser.window;
import js.html.CanvasElement;
import three.cameras.PerspectiveCamera;
import three.geometries.BoxGeometry;
import three.lights.DirectionalLight;
import three.materials.MeshPhongMaterial;
import three.math.Color;
import three.objects.Group;
import three.objects.Mesh;
import three.renderers.Renderer;
import three.renderers.WebGLRenderer;
import three.scenes.Scene;

class MainTwo {
	// var renderer:Renderer;
	// var scene:Scene;
	// var camera:PerspectiveCamera;
	// var group:Group;
	public function new() {
		settingCanvas();
	}

	function settingCanvas() {
		var ids = [];
		var all = document.getElementsByClassName('paper-toy-shape');
		for (i in 0...all.length) {
			var el = all[i];
			trace(el);
			if (el == null)
				return;
			// trace(el.nodeName);
			// trace(el.dataset.paperToyShape);
			// ids.push(el.id);

			var c = document.createCanvasElement();
			c.width = 600;
			c.height = 600;
			// c.setAttribute('width', '600px');
			// c.setAttribute('height', '600px');
			c.id = 'wrapper-$i';
			c.className = 'paper-toy-shape img-fluid rounded';
			el.replaceWith(c);
			ids.push(c.id);
		}
		trace(ids);

		setup2('test');
		setup2(ids[0]);
		setup2(ids[1]);
	}

	function setup2(id:String) {
		var canvas:CanvasElement = cast document.getElementById(id);
		var cW = canvas.width;
		var cH = canvas.height;

		// setup scene
		var scene = new Scene();

		// camera
		var fov = 75;
		var aspect = cW / cH; // 2: the canvas default
		var near = 0.1;
		var far = 5;
		var camera = new PerspectiveCamera(fov, aspect, near, far);
		camera.position.z = 3;
		// camera
		// var camera = new PerspectiveCamera(100, window.innerWidth / window.innerHeight, 10, 1000);
		// camera.position.z = 30;

		// render
		var renderer = new WebGLRenderer({
			canvas: canvas,
			antialias: true,
		});
		// renderer.setSize(window.innerWidth, window.innerHeight);
		renderer.setClearColor(new Color('#CC7FE0'), 1);
		// document.body.appendChild(renderer.domElement);

		// light
		var color = 0xFFFFFF;
		var intensity = 1;
		var light = new DirectionalLight(color, intensity);
		light.position.set(-1, 2, 4);
		scene.add(light);

		var type = 'cuboid';

		// box
		var boxWidth = 2;
		var boxHeight = 2;
		var boxDepth = 1;

		var geometry = new BoxGeometry(boxWidth, boxHeight, boxDepth);
		switch (type) {
			case 'cylinder':
				var geometry = new CylinderGeometry(1, 1, 2, 60);
			case 'cuboid':
				var geometry = new BoxGeometry(boxWidth, boxHeight, boxDepth);
			default:
				trace("case '" + type + "': trace ('" + type + "');");
		}

		var material = new MeshLambertMaterial({color: 0xFF6B6B});
		var mesh = new Mesh(geometry, material);
		// mesh.position.x = 0;

		// add mesh to scene
		// scene.add(mesh);

		var edges = new EdgesGeometry(geometry);
		var line = new LineSegments(edges, new LineBasicMaterial({
			color: 0x000000,
			linewidth: 5,
		}));
		// add line to scene
		// scene.add(line);

		var group = new Group();
		group.add(mesh);
		group.add(line);

		// add group to scene
		scene.add(group);

		// render scene
		// window.requestAnimationFrame(update);
		// renderer.render(scene, camera);

		update(group, renderer, scene, camera);

		// removing weird style element...
		canvas.setAttribute('style', '');
	}

	function update(group:Group, renderer, scene, camera) {
		window.requestAnimationFrame(function(?time:Float) {
			update(group, renderer, scene, camera);
		});
		group.rotation.x += 0.01;
		group.rotation.y += 0.01;
		// group.rotation.z += 0.01;
		renderer.render(scene, camera);
	}

	static public function main() {
		var app = new MainTwo();
	}
}
