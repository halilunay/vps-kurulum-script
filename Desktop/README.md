
# VPS Kurulum Scripti

Bu script, bir VPS sunucusunun otomatik olarak yapılandırılması ve Chromium tarayıcısının Docker üzerinde çalıştırılması için tasarlanmıştır.

## Script'in İçerikleri:
- **10 GB Swap alanı oluşturulması**
- **Sistem güncellemelerinin yapılması**
- **Docker ve Docker Compose kurulumu**
- **Chromium'un Docker üzerinde çalıştırılması**
- **İzleme ve performans araçlarının yüklenmesi (bpytop, hdparm, sysbench)**
- **RAM, Disk ve İnternet hız testleri**

---

## Kullanım

### 1. Script'i indirin:
Aşağıdaki komutla script'i VPS sunucunuza indirin:
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/main/setup_vps.sh
```

### 2. Script'i çalıştırılabilir hale getirin:
```bash
chmod +x setup_vps.sh
```

### 3. Script'i çalıştırın:
```bash
sudo ./setup_vps.sh
```

### 4. Kurulum sırasında ne olacak?
- **Swap Alanı:** 10 GB swap alanı oluşturulacak.
- **Docker ve Docker Compose:** Gerekli bileşenler kurulacak.
- **Chromium Docker'da Çalıştırılacak:** Tarayıcı otomatik olarak Docker'da başlatılacak.
- **Performans Testleri:** RAM, disk ve internet hız testleri yapılacak.

---

## Performans Testlerini Kontrol Edin

Kurulum tamamlandıktan sonra şu komutlarla test sonuçlarını inceleyebilirsiniz:

- **İnternet Hız Testi:**
  ```bash
  cat speedtest.txt
  ```

- **RAM Performans Testi:**
  ```bash
  cat ram_benchmark.txt
  ```

- **Disk Performans Testi:**
  ```bash
  cat disk_benchmark.txt
  ```

---

## Sık Karşılaşılan Sorunlar ve Çözümler

### 1. İzin hatası alıyorum.
Kurulum sırasında `Permission Denied` hatası alırsanız:
```bash
chmod +x setup_vps.sh
```

### 2. Script yarıda kesildi.
Kurulum sırasında bir hata alırsanız:
```bash
sudo ./setup_vps.sh
```

### 3. Docker çalışmıyor.
Docker'ın çalışıp çalışmadığını kontrol etmek için:
```bash
docker ps
```

---

## Katkıda Bulunun

Bu script'i geliştirmek için katkıda bulunabilirsiniz:
- [Issue oluştur](https://github.com/halilunay/vps-kurulum-script/issues)
- Pull Request gönderin.

---

## Lisans

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.
