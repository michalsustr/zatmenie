import multiprocessing
import os
from os.path import exists

import matplotlib
import numpy as np
from skimage import color
from skimage import feature, io
from skimage.draw import circle
from skimage.transform import hough_circle, hough_circle_peaks


def cropper(infile: str, outfile: str) -> None:
    if not exists(infile):
        print(f"skipping file {infile}, does not exist")
        return
    if exists(outfile):
        print(f"skipping file {infile}, already processed")
        return

    print(infile, outfile)
    orig_img = io.imread(infile, plugin='matplotlib')
    # najdi hrany v obrazku
    img = feature.canny(color.rgb2gray(orig_img), sigma=0.1).astype(np.uint8)
    img[img > 0] = 255 # binarne obrazky

    # experimentalne nastavene polomery, moze byt viac
    # hough_radii = [245]
    hough_radii = [277]
    hough_res = hough_circle(img, hough_radii)

    # najdi 5 najlepsich
    accums, cx, cy, radii = hough_circle_peaks(hough_res, hough_radii,
                                               total_num_peaks=5)

    # najdi ktory kruh ma najviac "jasnych" pixelov
    image = color.rgb2gray(orig_img)
    num_bright_pixels = []
    for center_y, center_x, radius in zip(cy, cx, radii):
        circy, circx = circle(center_y, center_x, radius)
        num_bright_pixels.append(np.sum(image[circy, circx] > 0.1))

    # ten vyber
    selected_circle = np.argmax(num_bright_pixels)
    y, x, r = cy[selected_circle], cx[selected_circle], radii[selected_circle]

    # debug:
    # pprint(list(zip(num_bright_pixels, cy, cx, radii)))
    # print(selected_circle, y, x, r)
    # circy, circx = circle_perimeter(y, x, r)
    # image[circy, circx] = 1
    # fig, ax = plt.subplots(ncols=1, nrows=1, figsize=(10, 4))
    # ax.imshow(image, cmap=plt.cm.gray)
    # plt.show()

    # a vycropuj.
    # todo: nefunguje ak to je blizko okraja
    # todo: rotacia slnka podla skvrn (obcas boli fotky zrotovane) - transformacia pomocou SIFTu
    crop = orig_img[int(y-r*4):int(y+r*4), int(x-r*4):int(x+r*4), :]
    matplotlib.image.imsave(outfile, crop)

if __name__ == '__main__':
    # ake obrazky sa maju spracovavat
    # in_images = range(1, 76)
    in_images = [f"data/matej/{f}" for f in os.listdir("data/matej/")]
    out_images = [in_image.replace("matej", "matej_out") for in_image in in_images]

    # cropuj v 7 procesoch naraz
    p = multiprocessing.Pool(processes=7)

    print("Processing:")
    # cropper("data/full/1.png", "data/cropped/1.png")
    # cropper("data/matej/DSC_0023.JPG", "data/matej_out/DSC_0023.JPG")
    # cropper("data/matej/DSC_0206.JPG", "data/matej_out/DSC_0206.JPG")
    p.starmap(cropper, zip(in_images, out_images))
