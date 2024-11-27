
# VPS Kurulum Scripti

Bu script, bir VPS sunucusunun otomatik olarak yapılandırılması ve Chromium tarayıcısının Docker üzerinde çalıştırılması için tasarlanmıştır. Kullanımı kolaylaştırmak için tüm adımlar detaylı bir şekilde açıklanmıştır.

---

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

---

## Chromium'a Erişim

Docker konteynerinde çalışan Chromium'a erişim sağlamak için varsayılan kullanıcı adı ve şifre şunlardır:

- **Kullanıcı Adı:** admin
- **Şifre:** admin

---

### Chromium Kullanıcı Adı ve Şifreyi Değiştirme

Eğer varsayılan kullanıcı adı ve şifreyi değiştirmek isterseniz, aşağıdaki adımları takip edin:

#### 1. Docker Compose Dosyasını Düzenleyin
```bash
nano ~/chromium/docker-compose.yaml
```

#### 2. Kullanıcı Adı ve Şifreyi Değiştirin
Aşağıdaki satırları bulun ve `admin` yerine kendi kullanıcı adı ve şifrenizi yazın:
```yaml
    environment:
      - CUSTOM_USER=admin
      - PASSWORD=admin
```
Yeni hali:
```yaml
    environment:
      - CUSTOM_USER=yenikullanici
      - PASSWORD=yenişifre
```

#### 3. Değişiklikleri Kaydedin ve Çıkın
- **CTRL+O**: Kaydet
- **Enter**: Değişiklikleri onayla
- **CTRL+X**: Nano editöründen çıkın.

#### 4. Docker Konteynerini Yeniden Başlatın
```bash
docker-compose -f ~/chromium/docker-compose.yaml down
docker-compose -f ~/chromium/docker-compose.yaml up -d
```

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
