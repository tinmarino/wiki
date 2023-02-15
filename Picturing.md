# Casa


# Astropy

```python
from astropy.io import fits 
fits_in = fits.open('./Test703.fits') 
a_in = fits_in[0].data

fits_out = fits.HDUList(a_out)


```

# Numpy

```python
np.zeros((2,3,4), dtype=np.int16)

array.shape
```

np.int64     # Signed 64-bit integer types
np.float32   # Standard double-precision floating point
np.complex   # Complex numbers represented by 128 floats
np.bool      # Boolean type storing TRUE and FALSE values
np.object    # Python object type
np.string_   # Fixed-length string type
np.unicode_  # Fixed-length unicode type







