# LCFSD
Code availability for Histochemistry and Cell Biology manuscript.  doi: 10.1007/s00418-023-02248-8 

# Brief explanation
Should be used for a dataset of planar images with meaningful pixel values, e.g. circularly polarized picrosirius red (PSR) or computed tomography (CT). 

Pixel values should be shifted/flipped so that the higher values represent more complex structure, e.g. thicker collagen (PSR) or denser material in the case of CT.

The whole dataset should be normalized by the highest value in all samples to h. You may need to normalize the lowest value to 0 for negative or relative scales like with Hounsfield Units.

One-by-one, give your image and h value to LCFSD_img, which will perform the calculation on the whole image. It will return the image with pixel values replace with their corresponding fractal dimension (FD). The borders where there were not enough pixels to calculate the FD will be cut off. The code will also cut out small clusters of pixels, size k (adjustable), to speed up the code and/or remove background/artifacts.  

# To keep in mind
You can get FD values above 3 because of it fits how the area around the pixel will scale. Hence, a few low-valued and or sparsely connected pixels surrounded by a lot of high-valued pixels could scale greater than 3. These pixels should be discarded.

This has not been tested on images greater than 1200 x 1600 pixels. Larger images may be time consuming.

For large batches of images, I recommend calling LCFSD_img in parallel. 

# CITE
Casey, D.T., Lahue, K.G., Mori, V. et al. Local fractal dimension of collagen detects increased spatial complexity in fibrosis. Histochem Cell Biol (2023). https://doi.org/10.1007/s00418-023-02248-8
