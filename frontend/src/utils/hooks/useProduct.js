import { useDispatch, useSelector } from 'react-redux';
import { fetchProducts, createProduct, updateExistingProduct, removeProduct } from '../../store/actions/productActions';

export const useProduct = () => {
  const dispatch = useDispatch();
  const products = useSelector((state) => state.product.products);
  const loading = useSelector((state) => state.product.loading);
  const error = useSelector((state) => state.product.error);
  const status = useSelector((state) => state.product.status);

  // 🔥 Thêm function refreshProduct
  const refreshProduct = async (productId) => {
    try {
      const response = await fetch(`/api/product/${productId}`);
      if (!response.ok) {
        throw new Error('Failed to fetch product');
      }
      const freshProduct = await response.json();
      return freshProduct;
    } catch (error) {
      console.error('Error refreshing product:', error);
      return null;
    }
  };

  const fetchProductsHandler = () => {
    dispatch(fetchProducts());
  };

  const createProductHandler = (product) => {
    dispatch(createProduct(product))
    .then(() => {
      alert("Product has been added.");
      dispatch(fetchProducts());
    })
  };

  const updateExistingProductHandler = (productId, product) => {
    dispatch(updateExistingProduct(productId, product))
    .then(() => {
      dispatch(fetchProducts());
    });
  };

  const removeProductHandler = (productId) => {
    if (window.confirm("Are you sure you want to delete this product?")) {
      dispatch(removeProduct(productId))
        .then(() => {
          alert("Product has been deleted.");
          dispatch(fetchProducts());
        });
    }
  };

  return {
    fetchProducts: fetchProductsHandler,
    createProduct: createProductHandler,
    updateExistingProduct: updateExistingProductHandler,
    removeProduct: removeProductHandler,
    refreshProduct, // 👈 THÊM DÒNG NÀY
    products,
    loading,
    error,
    status,
  };
};