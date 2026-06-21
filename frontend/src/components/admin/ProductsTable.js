import React, { useEffect, useState } from 'react';
import ProductSizes from './SizesTable';
import { useProduct } from '../../utils/hooks/useProduct';
import { useStock } from '../../utils/hooks/useUtil';
import productApi from '../../utils/api/productApi';

function Products() {
  const { products, fetchProducts, createProduct, updateExistingProduct, removeProduct, refreshProduct } = useProduct();
  const [localProduct, setLocalProduct] = useState({});
  const getStock = useStock();

  // 🆕 Khi chọn sản phẩm, fetch dữ liệu mới từ API
  const handleProductSelect = async (product) => {
    try {
      const freshProduct = await refreshProduct(product.productID);
      if (freshProduct) {
        setLocalProduct(freshProduct);
      } else {
        setLocalProduct(product);
      }
    } catch (error) {
      console.error('Error fetching fresh product:', error);
      setLocalProduct(product);
    }
  };

  useEffect(() => {
    fetchProducts();
  }, []);

  // 🆕 Refresh lại danh sách sau khi update/delete/create
  const handleUpdate = async (productData) => {
    await updateExistingProduct(productData);
    await fetchProducts();
    // Refresh lại localProduct với dữ liệu mới
    if (localProduct?.productID) {
      const fresh = await refreshProduct(localProduct.productID);
      if (fresh) setLocalProduct(fresh);
    }
  };

  const handleDelete = async (productId) => {
    if (window.confirm("Are you sure you want to delete this product?")) {
      await removeProduct(productId);
      await fetchProducts();
      setLocalProduct({});
    }
  };

  const handleCreate = async () => {
    if (!localProduct.name || !localProduct.brand) {
      alert('Vui lòng điền đầy đủ thông tin!');
      return;
    }
    await createProduct(localProduct);
    setLocalProduct({});
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLocalProduct(prevState => ({ ...prevState, [name]: value }));
  };

  return (
    <div className="admin-product">
        <table className='product-table'>
            <thead>
                <tr>
                  <th>ID</th>
                  <th>Model</th>
                  <th>Stock</th>
                </tr>
            </thead>
            <tbody>
                {products.map((product, index) => (
                <tr key={index} onClick={() => handleProductSelect(product)}>         
                    <td>{product.productID}</td>
                    <td>{product.brand} {product.name}</td>
                    <td>{getStock(product.inStock)}</td>
                  </tr>
                ))}
            </tbody>
        </table>
        <div className='product-panel'>
              <h2>{localProduct?.brand} {localProduct?.name}</h2>
              {localProduct?.productID && (
                <div className='product-panel-img'>
                  <img src={localProduct?.imageURL} alt="" key={localProduct.imageURL} />
                </div>
              )
              }
              <div className="product-panel-info">
                { localProduct?.productID && ( <label className='label-small'>
                  ID
                  <input value={localProduct?.productID} readOnly/>
                </label>)}
                <label>
                    Brand
                  <input id="productBrand" name="brand" maxLength="50" value={localProduct?.brand || ''} onChange={handleInputChange} />
                </label>
                <label>
                  Model
                  <input id="productName" name="name" maxLength="100" value={localProduct?.name || ''} onChange={handleInputChange}/>
                </label>
              </div>
              <label htmlFor="">
                  Description
                  <textarea id="productDescription" name="description" maxLength="500" rows="4" value={localProduct?.description || ''} onChange={handleInputChange}></textarea>
              </label>
            <label>
                Image URL
                <input id="productImageURL" name="imageURL" maxLength="100" value={localProduct?.imageURL || ''} onChange={handleInputChange}/>
            </label>
            <div className='divider'>
                <button className='second-button' onClick={() => setLocalProduct({}) }>CLEAR</button>
                { localProduct?.productID && (<button className='second-button' onClick={() => handleDelete(localProduct.productID)}>DELETE</button>)}
                { localProduct?.productID && (<button onClick={() => handleUpdate({ productId: localProduct.productID, product: localProduct })}>SAVE CHANGES</button>)}
                { !localProduct?.productID && (<button onClick={handleCreate}>Add Product</button>)}
            </div>
            {localProduct?.productID && (<ProductSizes product={localProduct} />)}
        </div> 
    </div>
  );
}

export default Products;