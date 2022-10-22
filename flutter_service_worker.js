'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "7f8546d73b3b7b8e0af8595f438fb441",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"favicon.png": "9a3f262e4d594963c302f68795d8d116",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "9da32da9f87c5f8b49a0345b591417d3",
"/": "9da32da9f87c5f8b49a0345b591417d3",
"manifest.json": "a0f4fed6e8b7ed3c95d47b0ae7d38ad1",
"main.dart.js": "96e0c2bb5ee7a276f3adc2caa4b2ee20",
"assets/AssetManifest.json": "13e44b0338aa564548173c34460733d2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "130b354de0c722399d2347be66d62443",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/speakers/speaker1.jpg": "7022b8c47fc9888d057b4abff4116ad3",
"assets/assets/images/speakers/speaker19.jpg": "b473b849478939789879bdef00ddf382",
"assets/assets/images/speakers/speaker21.jpg": "b57954ca0676db44b1090df055dce965",
"assets/assets/images/speakers/speaker10.jpg": "bde1c69fe202ff3d499bb61857ca11f4",
"assets/assets/images/speakers/speaker12.jpg": "6442a348d5095cde5beeaf0116205019",
"assets/assets/images/speakers/speaker8.jpg": "5a1fe05852005faebef81cab01e28130",
"assets/assets/images/speakers/speaker14.jpg": "4787856c77c50e3ae76529f325a6686c",
"assets/assets/images/speakers/speaker15.jpg": "d428728b1b09dfc08ca6a971a3b468bb",
"assets/assets/images/speakers/speaker22.jpg": "e6d11acd329219a219ac1eb377713c70",
"assets/assets/images/speakers/speaker4.jpg": "40a282e46ec725191e37a4d4d51ce00e",
"assets/assets/images/speakers/speaker7.jpg": "624e4d5a83044b48b215a5553679b3a7",
"assets/assets/images/speakers/speaker17.jpg": "43ee0e00002834a899353976d0f6be16",
"assets/assets/images/speakers/speaker16.jpg": "206d0b7303ec525485fd36b4d9c79ae9",
"assets/assets/images/speakers/speaker13.jpg": "b83a53d82edd2f39988893ecc504cedf",
"assets/assets/images/speakers/speaker11.jpg": "4ea6b6469c434378d1df97a1cdc38892",
"assets/assets/images/speakers/speaker6.jpg": "d3174b9904ddaa0d862601799cf093fd",
"assets/assets/images/speakers/speaker18.png": "c092fb92d49f9baf6d0c9267422fbe98",
"assets/assets/images/speakers/speaker2.jpg": "fd8a8e7603b85b8bf9726b1369dc0bf0",
"assets/assets/images/speakers/speaker9.jpg": "1e62786bb549b69946216665d548dc48",
"assets/assets/images/speakers/speaker3.jpg": "2f660474afa3046d6cfdcff9d27b3a2d",
"assets/assets/images/speakers/speaker20.jpg": "db6c572bec264f223c8473b7ecc5b234",
"assets/assets/images/speakers/speaker5.jpg": "3d9b6a9a91f00326bdede80673a675a5",
"assets/assets/svg/google-slides.svg": "92b1dcceebf83145ea6b8b931e9afbe2",
"assets/assets/svg/linkedin.svg": "f02014695f606010b728a9662047662e",
"assets/assets/svg/twitter.svg": "37caa6621fbf99d618c438b5a3c3ca5e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "bb6af69544daba10b8bb89e60edaa055",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
