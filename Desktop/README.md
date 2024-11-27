# VPS Kurulum Scripti

Bu script, bir VPS sunucusunun otomatik olarak yapılandırılması ve Chromium tarayıcısının Docker üzerinde çalıştırılması için tasarlanmıştır.

## Script'in İçerdikleri
- 10 GB Swap alanı oluşturulması
- Sistem güncellemelerinin yapılması
- Docker ve Docker Compose kurulumu
- Chromium'un Docker üzerinde çalıştırılması
- İzleme ve performans araçlarının yüklenmesi (bpytop, hdparm, sysbench)
- RAM, Disk ve İnternet hız testleri

---

## Kullanım
1. Script'i indirin:
   ```bash
   wget https://raw.githubusercontent.com/kullaniciadi/vps-kurulum-script/main/setup_vps.sh
