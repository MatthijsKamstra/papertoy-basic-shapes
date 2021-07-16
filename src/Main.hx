package;

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
	var canvas:CanvasElement;
	var renderer:Renderer;
	var scene:Scene;
	var camera:PerspectiveCamera;
	var mesh:Group;
	var cube:Mesh;

	var cubes:Array<Mesh> = [];

	// https://threejsfundamentals.org/threejs/lessons/threejs-fundamentals.html
	public function new() {
		// setup scene
		scene = new Scene();

		// camera
		var fov = 75;
		var aspect = window.innerWidth / window.innerHeight; // 2: the canvas default
		var near = 0.1;
		var far = 5;
		camera = new PerspectiveCamera(fov, aspect, near, far);
		camera.position.z = 3;

		// camera
		// var camera = new PerspectiveCamera(100, window.innerWidth / window.innerHeight, 10, 1000);
		// camera.position.z = 30;

		// render
		renderer = new WebGLRenderer({antialias: true});
		renderer.setSize(window.innerWidth, window.innerHeight);
		renderer.setClearColor(new Color('#CC7FE0'), 1);
		document.body.appendChild(renderer.domElement);

		// light
		var color = 0xFFFFFF;
		var intensity = 1;
		var light = new DirectionalLight(color, intensity);
		light.position.set(-1, 2, 4);
		scene.add(light);

		// box
		var boxWidth = 1;
		var boxHeight = 1;
		var boxDepth = 1;
		var geometry = new BoxGeometry(boxWidth, boxHeight, boxDepth);
		var material = new MeshPhongMaterial({color: 0x44aa88}); // greenish blue
		cube = new Mesh(geometry, material);
		cube.position.x = 0;

		// add cube to scene
		scene.add(cube);

		// render scene
		window.requestAnimationFrame(render);
	}

	function render(time:Float) {
		time *= 0.001; // convert time to seconds

		cube.rotation.x = time;
		cube.rotation.y = time;

		renderer.render(scene, camera);

		window.requestAnimationFrame(render);
	}

	static public function main() {
		var app = new Main();
	}
}
