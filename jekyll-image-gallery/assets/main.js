/* GALLERY: custom code */
function changeImage(e) {
    let container = e.srcElement.tagName === "IMG" ? e.srcElement.parentElement : e.srcElement;

    let boundingBox = container.getBoundingClientRect();
    let midPoint = boundingBox.x + boundingBox.width / 2;
    let isBeforeMidPoint = e.clientX < midPoint;

    let nextImage = this.getNextImage(container.parentElement, isBeforeMidPoint);

    this.selectImage(container.children[0], nextImage);

    return false;
}

// Calculates what the next image will be given for the gallery, based on whether the user 'clicked' previous or next
function getNextImage(gallery, isPrevious) {
    let imageList = gallery.getElementsByClassName("thumbnails")[0].getElementsByTagName("img");
    let currentImageSrc = gallery.getElementsByClassName("full")[0].children[0].getAttribute("src");
    let lastImg = imageList.length - 1;

    for (let i = 0; i < imageList.length; i++) {
        if (imageList[i].getAttribute("data-full-src") === currentImageSrc) {
            if (isPrevious && i === 0) {
                return imageList[lastImg];
            }
            else if(!isPrevious && i === lastImg) {
                return imageList[0];
            }

            return imageList[isPrevious ? i - 1 : i + 1];
        }
    }
}

function imageSelected(event) {
    let selected = event.srcElement;
    let currentImage = selected.parentElement.parentElement.getElementsByClassName("full")[0].children[0];

    selectImage(currentImage, selected);

    return false;
}

function selectImage(currentImage, selectedImage) {
    currentImage.src = selectedImage.getAttribute("data-full-src");
    currentImage.alt = selectedImage.getAttribute("alt");
    currentImage.title = selectedImage.getAttribute("alt");

    // Remove the 'active' class from any current thumbnails
    let thumbnails = selectedImage.parentElement.getElementsByTagName("img");
    for (let i = 0; i < thumbnails.length; i++) {
        thumbnails[i].className = "";
    }

    // Apply the 'active' class to the selected thumbnail
    selectedImage.className = "active";
}

// Apply the click handler for all gallery images
let thumbnailLists = document.getElementsByClassName("thumbnails");
for (let i = 0; i < thumbnailLists.length; i++) {
    let imageLists = thumbnailLists[i].getElementsByTagName("img");
    for (let j = 0; j < imageLists.length; j++) {
        imageLists[j].addEventListener("click", imageSelected, false);
    }
}

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