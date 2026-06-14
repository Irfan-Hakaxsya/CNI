-- ==========================================
-- 1. CIPTA DATABASE UNIMARKET
-- ==========================================
CREATE DATABASE unimarket_db;
USE unimarket_db;

-- ==========================================
-- 2. TABLE PENGGUNA (Users / Students)
-- Menyimpan maklumat pendaftaran & profil pelajar
-- ==========================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,       -- e.g., student@university.edu.my
    student_id VARCHAR(20) UNIQUE NOT NULL,   -- e.g., TP054321
    faculty VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,          -- Untuk menyimpan password yang di-hash
    phone VARCHAR(20) NULL,
    bio TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. TABLE PRODUK / BARANGAN (Products / Listings)
-- Menyimpan barang yang ingin dijual oleh pelajar
-- ==========================================
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,                     -- ID Penjual (FK dari table users)
    title VARCHAR(255) NOT NULL,              -- Tajuk iklan produk
    category ENUM('Books', 'Electronics', 'Furniture', 'Clothing', 'Stationery', 'Sports', 'Kitchen', 'Other') NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    original_price DECIMAL(10, 2) NULL,       -- Harga asal produk
    `condition` ENUM('Like New', 'Good', 'Fair') NOT NULL,
    location VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NULL,              -- Laluan/URL gambar produk
    status ENUM('Available', 'Sold') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ==========================================
-- 4. TABLE TROLI (Cart Items)
-- Menyimpan barang yang dimasukkan ke dalam troli
-- ==========================================
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ==========================================
-- 5. TABLE SENARAI HAJAT (Wishlist Items)
-- Menyimpan barang kegemaran/bookmark pelajar
-- ==========================================
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ==========================================
-- 6. TABLE PESANAN (Orders Summary)
-- Maklumat semasa pelajar membuat Checkout
-- ==========================================
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,                    -- ID Pembeli (FK dari table users)
    full_name VARCHAR(100) NOT NULL,          -- Nama penerima semasa checkout
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    delivery_date DATE NOT NULL,
    delivery_time TIME NOT NULL,
    notes TEXT NULL,                          -- Nota tambahan pembeli
    payment_method VARCHAR(50) NOT NULL,      -- Kaedah pembayaran pilihan
    total_amount DECIMAL(10, 2) NOT NULL,     -- Jumlah keseluruhan harga
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ==========================================
-- 7. TABLE ITEM PESANAN (Order Items)
-- Menyimpan senarai produk di dalam sesuatu pesanan
-- ==========================================
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,            -- Harga produk ketika dibeli
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ==========================================
-- 8. TABLE HUBUNGI KAMI (Customer Service)
-- Menyimpan mesej borang maklum balas/bantuan
-- ==========================================
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);