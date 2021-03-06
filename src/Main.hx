package;

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

class Main {
	// var canvas:CanvasElement;
	var renderer:Renderer;
	var scene:Scene;
	var camera:PerspectiveCamera;

	// var mesh:Group;
	// var cube:Mesh;
	// var line:LineSegments;
	var group:Group;

	public function new() {
		init();
	}

	function init() {
		var canvas = cast document.getElementById('test');
		var cW = canvas.width;
		var cH = canvas.height;

		// setup scene
		scene = new Scene();

		// camera
		var fov = 75;
		var aspect = cW / cH; // 2: the canvas default
		var near = 0.1;
		var far = 5;
		camera = new PerspectiveCamera(fov, aspect, near, far);
		camera.position.z = 3;

		// camera
		// var camera = new PerspectiveCamera(100, window.innerWidth / window.innerHeight, 10, 1000);
		// camera.position.z = 30;

		// render
		renderer = new WebGLRenderer({
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

		// box
		var boxWidth = 2;
		var boxHeight = 2;
		var boxDepth = 1;
		var geometry = new BoxGeometry(boxWidth, boxHeight, boxDepth);
		var material = new MeshLambertMaterial({color: 0xFF6B6B});
		var cube = new Mesh(geometry, material);
		cube.position.x = 0;

		// add cube to scene
		// scene.add(cube);

		var edges = new EdgesGeometry(geometry);
		var line = new LineSegments(edges, new LineBasicMaterial({
			color: 0x000000,
			linewidth: 5,
		}));
		// add line to scene
		// scene.add(line);

		group = new Group();
		group.add(cube);
		group.add(line);

		// add group to scene
		scene.add(group);

		// render scene
		window.requestAnimationFrame(render);
	}

	function render(?time:Float) {
		group.rotation.x += 0.01;
		group.rotation.y += 0.01;

		renderer.render(scene, camera);

		window.requestAnimationFrame(render);
	}

	static public function main() {
		var app = new Main();
	}
}
