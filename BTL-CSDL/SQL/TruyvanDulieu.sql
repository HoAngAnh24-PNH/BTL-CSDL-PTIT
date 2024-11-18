-- Truy van thong tin ve doi bong
SELECT DoiBong.TenDoi, DoiBong.MauAo, DoiBong.KhuVuc, DoiBong.TenCSH, HuanLuyenVien.Ten AS TenHLV
FROM DoiBong
JOIN HuanLuyenVien ON DoiBong.TenDoi = HuanLuyenVien.TenDoiHuanLuyen;

-- Truy van thong tin ve HLV cua moi doi bong
SELECT *
FROM HuanLuyenVien;

-- Truy van thong tin ve cau thu cua tung doi
SELECT *
FROM CauThu
WHERE CauThu.TenDoi = 'Brooklyn Nets';

-- Truy van thong tin chi tiet ti so tran dau theo ten giai dau va mua giai dau
WITH TiSo AS (SELECT 
					ThamGia.MaTran,
					ThamGia.TenDoi,
					ThamGia.DiemGhiDuoc,
					TranDau.Thoigian,
					TranDau.SanDau
				FROM 
					ThamGia, TranDau
				WHERE 
					TranDau.TenGiaiThuoc = 'NBA Finals'
					AND TranDau.MuaGiaiThuoc = '2023-2024'
					AND ThamGia.MaTran = TranDau.MaTran
)
SELECT 
    T1.MaTran,
    T1.TenDoi AS Doi1,
    T2.TenDoi AS Doi2,
    T1.DiemGhiDuoc AS DiemDoi1,
    T2.DiemGhiDuoc AS DiemDoi2,
	T1.Thoigian,
	T1.SanDau
FROM 
    TiSo AS T1
JOIN 
    TiSo AS T2
ON 
    T1.MaTran = T2.MaTran AND T1.TenDoi < T2.TenDoi
ORDER BY T1.MaTran;

-- Truy van thong tin ve nha tai tro theo ma nha tai tro
SELECT 
	  TaiTro.MaNhaTaiTro, NhaTaiTro.TenNhaTaiTro,
	  NhaTaiTro.QuocGiaXuatXu, TaiTro.TenGiai,
	  TaiTro.BatDau, TaiTro.KetThuc,
	  TaiTro.HinhThuc
FROM 
	  TaiTro JOIN NhaTaiTro ON NhaTaiTro.MaNhaTaiTro = TaiTro.MaNhaTaiTro
WHERE 
	  TaiTro.MaNhaTaiTro = 'NTT01'

-- Truy van thong tin cac trong tai tham giao vao moi tran dau cua 1 mua giai
WITH TTTGDK AS (SELECT TranDau.MaTran, TranDau.SanDau, TranDau.Thoigian , TTTD.MaTrongTaiDieuKhienChinh, TTTD.MaTrongTaiHoTro1, TTTD.MaTrongTaiHoTro2, TranDau.TenGiaiThuoc
FROM 
	  TranDau JOIN (SELECT DieuKhien.MaTran, DieuKhien.MaTrongTai AS MaTrongTaiDieuKhienChinh, HT.MaTrongTaiHoTro1, HT.MaTrongTaiHoTro2
					FROM 
						 DieuKhien
						 JOIN(SELECT HT1.MaTran, HT1.MaTrongTaiHoTro AS MaTrongTaiHoTro1, HT2.MaTrongTaiHoTro AS MaTrongTaiHoTro2
							  FROM (SELECT *
									FROM HoTro 
									WHERE HoTro.MaTran IN (SELECT TranDau.MaTran
														   FROM TranDau
														   WHERE TranDau.TenGiaiThuoc = 'NBA Finals' AND
																 TranDau.MuaGiaiThuoc = '2023-2024')
									) AS HT1 JOIN (SELECT *
											 FROM HoTro
											 WHERE HoTro.MaTran IN (SELECT TranDau.MaTran
																	FROM TranDau
																	WHERE TranDau.TenGiaiThuoc = 'NBA Finals' AND
																	TranDau.MuaGiaiThuoc = '2023-2024')
													) AS HT2 
											 ON HT1.MaTran = HT2.MaTran AND HT1.MaTrongTaiHoTro < HT2.MaTrongTaiHoTro) AS HT
						 ON DieuKhien.MaTran = HT.MaTran) AS TTTD ON TranDau.MaTran = TTTD.MaTran)

SELECT  A1.MaTran, A1.SanDau, A1.Thoigian, A1.TenTTDKC, A1.QuocTichTTDKC, A2.TenTTHT1, A2.QuocTichTTHT1, A3.TenTTHT2, A3.QuocTichTTHT2
FROM
	(SELECT 
			MTTTGDK.MaTran, TrongTai.Ten AS TenTTDKC, 
			TrongTai.QuocTich AS QuocTichTTDKC, MTTTGDK.SanDau, MTTTGDK.Thoigian, MTTTGDK.TenGiaiThuoc
	 FROM 
			TrongTai JOIN TTTGDK AS MTTTGDK ON TrongTai.MaTrongTai = MTTTGDK.MaTrongTaiDieuKhienChinh
	) AS A1 JOIN (SELECT 
						MTTTGDK.MaTran, 
						TrongTai.Ten AS TenTTHT1, 
						TrongTai.QuocTich AS QuocTichTTHT1, MTTTGDK.SanDau, MTTTGDK.Thoigian, MTTTGDK.TenGiaiThuoc
				  FROM 
						TrongTai JOIN TTTGDK AS MTTTGDK
						ON TrongTai.MaTrongTai = MTTTGDK.MaTrongTaiHoTro1
				) AS A2 ON A1.MaTran = A2.MaTran
           JOIN (SELECT 
					   MTTTGDK.MaTran, TrongTai.Ten AS TenTTHT2, 
					   TrongTai.QuocTich AS QuocTichTTHT2, MTTTGDK.SanDau, MTTTGDK.Thoigian, MTTTGDK.TenGiaiThuoc
                  FROM TrongTai JOIN TTTGDK AS MTTTGDK
                       ON TrongTai.MaTrongTai = MTTTGDK.MaTrongTaiHoTro2
				 ) AS A3 ON A2.MaTran = A3.MaTran;



-- Dự đoán tỉ số giữa các đội
WITH ThongKeDoiBong AS (
    SELECT 
        TenDoi, 
        AVG(DiemGhiDuoc) AS DiemTrungBinh
    FROM 
        ThamGia
    GROUP BY 
        TenDoi
)
SELECT 
    TK1.TenDoi AS Doi1,
    TK2.TenDoi AS Doi2,
    TK1.DiemTrungBinh AS DiemDuDoanDoi1,
    TK2.DiemTrungBinh AS DiemDuDoanDoi2
FROM 
    ThongKeDoiBong AS TK1
JOIN 
    ThongKeDoiBong AS TK2 ON TK1.TenDoi <> TK2.TenDoi;

-- Truy van Đội vô địch của giai dau theo ten giai va mua giai
WITH TranChungKet AS (SELECT 
							THAMGIA.TenDoi, 
							ThamGia.DiemGhiDuoc, 
							A.TenGiaiThuoc AS TenGiai, 
							A.MuaGiaiThuoc AS MuaGiai
					  FROM 
							ThamGia, (SELECT MaTran, TenGiaiThuoc, MuaGiaiThuoc
									  FROM TranDau 
									  WHERE ThoiGian = (SELECT MAX(ThoiGian)
														FROM TranDau
														WHERE TranDau.TenGiaiThuoc = 'NBA Finals'
															  AND TranDau.MuaGiaiThuoc = '2023-2024'))AS A
					  WHERE ThamGia.MaTran = A.MaTran)
SELECT 
		a.TenGiai, 
		a.MuaGiai, 
		DoiBong.TenDoi AS NhaVoDich, 
		DoiBong.MauAo, 
		DoiBong.KhuVuc, 
		DoiBong.TenCSH
FROM DoiBong JOIN (SELECT CK1.TenDoi, CK1.TenGiai, CK1.MuaGiai
				   FROM TranChungKet AS CK1 
						JOIN TranChungKet AS CK2
						ON CK1.DiemGhiDuoc > CK2.DiemGhiDuoc) AS A
			 ON DoiBong.TenDoi = A.TenDoi;


