'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/amhariclearning.pdf": "826bb87cfe1c4776d3ce3c0ebf2e9007",
"assets/AssetManifest.bin": "8957c89b8a7d04d4ab89680484feb939",
"assets/AssetManifest.bin.json": "deed4d05d7c8f9ebe9b8ac4149120b37",
"assets/AssetManifest.json": "be200d83356d7164ff1aaac72ef81d45",
"assets/assets/animations/loading.json": "e644d6580e0732507105b635d48d3590",
"assets/assets/animations/success.json": "c9465b60f7432a8494874a1922572ffc",
"assets/assets/images/Axum.png": "e4c35524df29b28fe1eee422fb258bde",
"assets/assets/images/Bale.png": "d2894d8df539443cf4d9481ae1bbbf26",
"assets/assets/images/blue%2520nile.png": "67a8629179414a172682727f1eae72ba",
"assets/assets/images/coffee.png": "6655c55ca8b549cd9bc5e3fc5e5f6ea6",
"assets/assets/images/Danakil.png": "a623483851924b29f8529d69adea9c6d",
"assets/assets/images/debre%2520damo.png": "20a308f88f627353a11ccd0e2fc97eae",
"assets/assets/images/ethio_assist_logo.png": "ae941003bd13f86904b1762bd452b502",
"assets/assets/images/Fassil%2520Gimb.png": "c2716087afcec178939072a0e3f8d26c",
"assets/assets/images/food.png": "712c974341b631afef4415b14ea3f6ed",
"assets/assets/images/greetings.png": "4619a533ff0e645c29d02e915ceac0d3",
"assets/assets/images/hospital.png": "89f80184a56f1a3d1591c69bcec38ebb",
"assets/assets/images/hotel.png": "34ab0d2fbaafc5008f6e22dcd8af51da",
"assets/assets/images/injera.png": "7f2851bdd729ca6dcff20e4730a73a6b",
"assets/assets/images/Jugol.png": "ac2eb6c7bad9957aaaa12589a847efa1",
"assets/assets/images/konso.png": "c2486b473675e0332554eae9576a9aab",
"assets/assets/images/lake%2520tana.png": "8fcee786c2c540ae12b5f0ca1d038618",
"assets/assets/images/Lalibela.png": "2c170359c1c23ce6ded27cc2f6b6b28d",
"assets/assets/images/Logo.png": "fc4bfc66ca47d610361f52ec8302a893",
"assets/assets/images/milk.png": "01e7bf8077e601e75c504f7409b7d15a",
"assets/assets/images/National%2520museium.jpg": "4bd617f17ba3568656a004ccef958863",
"assets/assets/images/new_logo.png": "d7fd2bd18cee6d8a756d2bdf7e048094",
"assets/assets/images/one.png": "a39f032b64f8c1c5e0e15ef05bebb33f",
"assets/assets/images/polices.png": "599b7e12148c6917af90b6064b24c0a0",
"assets/assets/images/Restaurant.png": "e1014b3d87d52651660b7c71cfd3ef82",
"assets/assets/images/thank%2520you.png": "5f836e23eacaaaccdfc182a04733ed9c",
"assets/assets/images/three.png": "2bb641458409ab167bfc45dbe59245e5",
"assets/assets/images/two.png": "dd78f1a02875b2e4a3a2904167097b5d",
"assets/assets/images/water.png": "7124e398b9289b9a47385fbb194e69ae",
"assets/EthiopiaHandbook.pdf": "cf0d60b82e4652d7e4e20dc3fe41ce9c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "f754d776a457185201246aa614e5cc08",
"assets/NOTICES": "cf8bf5e29bfc7f2968278c27c437f34e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "bedb1cddc34178ecd4df294a24bbbbe8",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "161d9013d85ac000aebcad6da800ca70",
"index.html": "42bd8ffd136f7d76eee79832033e1cd6",
"/": "42bd8ffd136f7d76eee79832033e1cd6",
"main.dart.js": "de2aca3e2a8c49158c40ce2f8329a767",
"manifest.json": "3f8e258a524273271ebd9d0a610639b5",
"tts.js": "607eb439ba1543a99d49cb437b153405",
"version.json": "e3d6627ac0692e7b242b07b224f0e680"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
