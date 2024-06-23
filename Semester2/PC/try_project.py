import cv2
import numpy as np

def apply_kmeans(image_path, k):
    # Load image
    img = cv2.imread(image_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    # Reshape image to 2D array of pixels
    pixel_values = img.reshape((-1, 3))
    pixel_values = np.float32(pixel_values)

    # Define criteria and apply kmeans
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 100, 0.2)
    _, labels, centers = cv2.kmeans(pixel_values, k, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)

    # Convert centers to 8-bit values
    centers = np.uint8(centers)

    # Map labels to center colors
    segmented_image = centers[labels.flatten()]
    segmented_image = segmented_image.reshape(img.shape)

    # Display original and segmented images
    cv2.imshow('Original Image', cv2.cvtColor(img, cv2.COLOR_RGB2BGR))
    cv2.imshow(f'Segmented Image with {k} colors', cv2.cvtColor(segmented_image, cv2.COLOR_RGB2BGR))
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# Example usage
apply_kmeans('20220930_173040.jpg', k=2)
