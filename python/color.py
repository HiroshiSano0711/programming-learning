def get_pixel_color(c):
  r = (c & 0x00FF0000) >> 16
  g = (c & 0x0000FF00) >> 8
  b = (c & 0x000000FF)
  return r, g, b

print(get_pixel_color(42968764))