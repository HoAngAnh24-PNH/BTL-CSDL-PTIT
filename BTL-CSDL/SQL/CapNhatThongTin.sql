--Them, sua, xoa thong tin
	--them doi bong
	INSERT INTO DoiBong VALUES
	('Los Angeles Lakers', 'Yellow-Blue', 'Wesr', 'Pham Hoang');
	--sua doi bong
	UPDATE DoiBong
	SET MauAo = 'Blue-Green'
	WHERE TenDoi = 'Los Angeles Clippers';
	--xoa doi bong
	DELETE FROM DoiBong
	WHERE TenDoi = 'Los Angeles Lakers';
	--them 1 cau thu
	INSERT INTO CauThu (TenDoi, SoAo, QuocTich, Ten, NgaySinh, TenDoiDoiTruong, SoAoDoiTruong) 
	VALUES ('TenDoiCuaBan', 10, 'QuocTich', 'TenCauThu', '1990-01-01', 'TenDoiDoiTruong', 9);
	--sua thong tin cua 1 cau thu
	UPDATE CauThu
	SET QuocTich = 'QuocTichMoi', Ten = 'TenMoi', NgaySinh = '1990-01-02', TenDoiDoiTruong = 'TenDoiDoiTruongMoi', SoAoDoiTruong = 8
	WHERE TenDoi = 'TenDoiCuaBan' AND SoAo = 10;
	--xoa 1 cau thu
	DELETE FROM CauThu 
	WHERE TenDoi = 'TenDoiCuaBan' AND SoAo = 10;

	-- Các bảng khác tương tự

-- Cap nhap thong tin giai dau
UPDATE GiaiDau
SET TheThucThiDau = 'TheThucMoi', BanToChuc = 'BanToChucMoi'
WHERE TenGiai = 'TenGiai' AND MuaGiai = 'MuaGiai';

-- Cap nhap thong tin nha tai tro
UPDATE TaiTro
SET BatDau = '2023-09-01', KetThuc = '2024-06-01', HinhThuc = 'HinhThucMoi'
WHERE TenGiai = 'TenGiai' AND MuaGiai = 'MuaGiai' AND MaNhaTaiTro = 'NTT001';

DELETE TaiTro
WHERE KetThuc < 'Thoi gian hien tai';