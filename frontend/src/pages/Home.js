import React from 'react';
import hero from "../assets/icons/hero2.png"
import ProductGrid from '../components/product/ProductList';

function Home() {
  return (
    <>
      <div className='hero'>
        <div className='hero-circle'> </div>
        <img className='hero-img' src={hero} alt="" />
      </div>
      <div className='hero-about'>
        <div>
          <p>LIMITED OFFER</p>
          <h3> SAVE 30%</h3>
          <p>USE DISCOUNT</p>
          <button>10O FF</button>
        </div>
      </div>  
      <div className='container'>
        <h1>Products</h1>
        <ProductGrid />
      </div>
    </>
  );
}

export default Home;
