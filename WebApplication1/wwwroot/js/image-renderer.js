// Enhanced Image Loading and Rendering Script
document.addEventListener('DOMContentLoaded', function() {
    
    // Function to ensure all images load properly
    function ensureImageLoading() {
        const images = document.querySelectorAll('img[src*="images/"]');
        
        images.forEach(function(img) {
            // Add loading event listeners
            img.addEventListener('load', function() {
                this.style.opacity = '1';
                this.classList.add('loaded');
                console.log('Image loaded successfully:', this.src);
            });
            
            img.addEventListener('error', function() {
                console.warn('Image failed to load:', this.src);
                this.classList.add('error');
            });
            
            // Force reload if image hasn't loaded after 5 seconds
            setTimeout(function() {
                if (!img.complete || img.naturalHeight === 0) {
                    console.log('Reloading image:', img.src);
                    const originalSrc = img.src;
                    img.src = '';
                    img.src = originalSrc + '?v=' + new Date().getTime();
                }
            }, 5000);
        });
    }
    
    // Function to check if images exist and are accessible
    function validateImagePaths() {
        const imagePaths = [
            '/images/pg-logo.png',
            '/images/scientist-lab.jpg',
            '/images/woman-laundry.jpg'
        ];
        
        imagePaths.forEach(function(path) {
            fetch(path, { method: 'HEAD' })
                .then(function(response) {
                    if (response.ok) {
                        console.log('✅ Image accessible:', path);
                    } else {
                        console.error('❌ Image not accessible:', path, 'Status:', response.status);
                    }
                })
                .catch(function(error) {
                    console.error('❌ Error checking image:', path, error);
                });
        });
    }
    
    // Function to add visual indicators for image loading
    function addLoadingIndicators() {
        const containers = document.querySelectorAll('.scientist-image-container, .laundry-image-container');
        
        containers.forEach(function(container) {
            const img = container.querySelector('img');
            if (img && !img.complete) {
                container.classList.add('loading');
                
                // Remove loading class when image loads
                img.addEventListener('load', function() {
                    container.classList.remove('loading');
                    container.classList.add('loaded');
                });
            }
        });
    }
    
    // Initialize all image enhancement functions
    ensureImageLoading();
    validateImagePaths();
    addLoadingIndicators();
    
    // Debug information
    console.log('🖼️ Image rendering enhancement script loaded');
    console.log('📂 Expected images location: /wwwroot/images/');
    console.log('🔍 Total images found:', document.querySelectorAll('img').length);
    
    // Add CSS for loading states if not already present
    if (!document.querySelector('#image-loading-styles')) {
        const style = document.createElement('style');
        style.id = 'image-loading-styles';
        style.textContent = `
            .loading::before {
                content: '🔄 Loading image...';
                display: flex;
                align-items: center;
                justify-content: center;
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(248, 249, 250, 0.9);
                color: #666;
                font-size: 14px;
                z-index: 1;
            }
            
            .loading {
                position: relative;
            }
            
            .loaded img {
                animation: fadeIn 0.5s ease-in;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
        `;
        document.head.appendChild(style);
    }
});

// Function to manually reload all images (useful for debugging)
function reloadAllImages() {
    const images = document.querySelectorAll('img[src*="images/"]');
    images.forEach(function(img) {
        const originalSrc = img.src;
        img.src = '';
        setTimeout(function() {
            img.src = originalSrc + '?v=' + new Date().getTime();
        }, 100);
    });
    console.log('🔄 Reloaded all images');
}

// Make reload function available globally for debugging
window.reloadAllImages = reloadAllImages;
