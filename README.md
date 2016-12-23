# JPEG-Compression-Implementation
This was my 4th programming assignment for the course MM806-(Image and Video Processing) at University of Alberta. 
The aim of this assignment was to understand and appreciate the JPEG compression mechanism.
The Question for the Assignment (set by Professor Nilanjan Ray) is as follows:

Your encoder is a simplified version a real-world baseline system. First off, it assumes a grayscale input image. Let the user choose an image. So, there is no color conversion. Then it creates 8x8 blocks from the input image. If the image height and width are not a multiple of 8, zero-pad the image suitably. Then for each 8x8 block, the apply DCT. Next apply quantization to the DCT coefficients. For quantization use this table. Next, reorder quantized DCT coefficients in zig-zag order. Apply difference coding to DC coefficients and run length coding to AC coefficients. Write these difference coded DC and run length coded AC coefficients to a text file along with image height and image width. This completes your encoder. Notice that in reality you would further apply Huffman coding to the difference coded DC and run length coded AC coefficients. We are skipping Huffman coding here for simplicity.

Your decoder reads the text file and reverses every step of the encoder and finally displays the image.

Test you program with Matlab inbuilt "cameraman.tif", "pout.tif" etc. Your encoder and decoder should work on any input grayscale image. I will not test your program on a color image.


## Usage
TO those who are taking this course, please DO NOT copy this content in your assignment. Instead use this repository as a learning example and try to better your code based on this. You can extend this code and add in the Huffman coding and decoding part in the encoder and decoder part.

## Credits
The assignment problem has been created by Professor Nilanjan Ray, for the course MM806-(Image and Video Processing) at University of Alberta.

## License
MIT License

Copyright (c) 2016 Shrobon Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
