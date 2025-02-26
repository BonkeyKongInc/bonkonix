require('neo-img').setup({
  supported_extensions = {
    ['png'] = true,
    ['jpg'] = true,
    ['jpeg'] = true,
    ['webp'] = true,
    ['svg'] = true,
    ['tiff'] = true,
    ['tif'] = true,
    ['docx'] = true,
    ['xlsx'] = true,
    ['pdf'] = true,
    ['pptx'] = true,
  },
  ----- Important ones -----
  window_size = "1920x1080", -- size of the window. in windows auto queries using windows api, linux in the TODO. see below how to get the size of window in linux
  size = "80%",              -- size of the image in percent
  center = true,             -- rather or not to center the image in the window
  ----- Important ones -----

  ----- Less Important -----
  auto_open = true,   -- Automatically open images when buffer is loaded
  oil_preview = true, -- changes oil preview of images too
  backend = "auto",   -- auto / kitty / iterm / sixel
  resizeMode = "Fit", -- Fit / Strech / Crop
  offset = "0x3"      -- that exmp is 0 cells offset x and 3 y. this options is irrelevant when centered
  ----- Less Important -----
})
