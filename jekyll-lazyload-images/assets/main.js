/* LAZY LOADING: https://www.sitepoint.com/five-techniques-lazy-load-images-website-performance/ - also used for YouTube videos (aka iframes) */
function preloadAssets(asset) {
    asset.src = asset.getAttribute("data-src");
}

const config = {
    rootMargin: '0px 0px 50px 0px',
    threshold: 0
};

let observer = new IntersectionObserver(function(entries, self) {
    entries.forEach(entry => {
        if(entry.isIntersecting) {
            preloadAssets(entry.target);
            self.unobserve(entry.target);
        }
    });
}, config);

const assets = document.querySelectorAll('[data-src]');
assets.forEach(asset => {
    observer.observe(asset);
});