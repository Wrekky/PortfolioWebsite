uniform sampler2D testImage;
uniform vec2 mousePos;

varying vec2 vUv;
void main() {
  //size of the strip splitting the image
  const float bandSize = 0.01;
  //attempting to apply blur: 
  //area around the pixel to sample.
  const float kernalSize = 8.0;
  const int halfSize = 4;

  const float coefficient = 1.0 / (kernalSize * kernalSize);

  //offsets the image, higher numbers here can show repeated images, maybe worth doing something with.
  //can also swap to horizontal or vertical blur by making only one of these smaller.
  const vec2 dx = vec2(0.002, 0.0);
  const vec2 dy = vec2(0.0, 0.002);

  vec4 pixel_color = vec4(0.0, 0.0, 0.0, 0.0);

  if(vUv.x > mousePos.x - bandSize) {
    for(int x = -halfSize; x <= halfSize; x++) {
      for(int y = -halfSize; y <= halfSize; y++) {
        pixel_color += coefficient * texture2D(testImage, vUv + (float(x) * dx) + (float(y) * dy));
      }
    }
  } else {
    pixel_color = texture2D(testImage, vUv);
  }
  if(mousePos.x > vUv.x - bandSize && mousePos.x < vUv.x + bandSize) {
    pixel_color *= vec4(0.18, 0.91, 0.18, 0.12);
  }
  gl_FragColor = pixel_color;
}