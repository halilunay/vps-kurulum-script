
# VPS Kurulum Scripti

## İçindekiler

1. [Genel Bilgilendirme](#genel-bilgilendirme)
2. [Scriptler ve Detaylı Kullanım](#scriptler-ve-detaylı-kullanım)
   - [setup_vps.sh](#setup_vpssh)
   - [install_network3.sh](#install_network3sh)
   - [install_multiple.sh](#install_multiplesh)
   - [remove_vps.sh](#remove_vpssh)
3. [Projeler ve Referans Linkler](#projeler-ve-referans-linkler)
4. [Yararlı Komutlar](#yararlı-komutlar)

---

## Genel Bilgilendirme

Bu rehber, VPS üzerinde çalıştırılabilecek scriptlerin her biri için kurulum ve kullanım yönergeleri sunar. Eğer sadece bir projeye dahil olmak istiyorsanız, o projeye özel olan scriptin talimatlarını izleyebilirsiniz.

---

## Scriptler ve Detaylı Kullanım

### setup_vps.sh

#### Amaç
VPS'inizi optimize etmek ve gerekli araçları kurmak için tasarlanmıştır.

#### Kurulum
1. Scripti indirin:
    ```bash
    wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/setup_vps.sh
    ```

2. Çalıştırılabilir hale getirin:
    ```bash
    chmod +x setup_vps.sh
    ```

3. Scripti çalıştırın:
    ```bash
    ./setup_vps.sh
    ```

#### Önemli Not
Bu script, VPS'inizi hızlı bir şekilde yapılandırmak ve gerekli araçları kurmak için tasarlanmıştır. **Ancak, özellikle varsayılan kullanıcı adı ve şifrelerin güvenlik riskleri oluşturabileceğini unutmayın.** Kurulum sonrasında aşağıdaki talimatlarla bu bilgileri değiştirmeniz önerilir:

1. `docker-compose.yaml` dosyasını düzenleyin:
    ```bash
    nano docker-compose.yaml
    ```
2. Dosyada kullanıcı adı ve şifrenizi yeniden belirleyip değiştirin:
    ```yaml
      - CUSTOM_USER=<yeni_kullanıcı_adı>
      - PASSWORD=<yeni_şifre>
    ```
3. Dosyayı kaydedip çıkmak için `Ctrl+X`, ardından `Y` ve `Enter` tuşlarına basın.
4. Chromium servisini yeniden başlatın:
    ```bash
    (cd $HOME/chromium && docker compose up-d)
    ```

#### Özellikler
- **Swap Alanı:** 10 GB swap alanı oluşturur.
- **Docker ve Bağımlılıklar:** Docker ve Docker Compose kurulumunu gerçekleştirir.
- **Performans Araçları:** bpytop, hdparm, sysbench gibi sistem izleme ve test araçlarını yükler.
- **Performans Testleri:** Disk, bellek ve internet hızını test ederek sonuçları dosyalara kaydeder.
- **Cron Job:** Günlük önbelleği temizlemek için otomatik bir görev oluşturur.

---

### install_network3.sh

#### Amaç
Network3 projesine katılmak için gereken tüm bileşenleri yükler.

#### Kurulum
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_network3.sh
chmod +x install_network3.sh
./install_network3.sh
```

#### Kayıt Olma
[Network3 Kayıt Linki](https://account.network3.ai/register_page?rc=644903e7)

---

### install_multiple.sh

#### Amaç
Multiple projesine katılmak için gereken bileşenleri yükler.

#### Kurulum
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_multiple.sh
chmod +x install_multiple.sh
./install_multiple.sh
```

#### Kayıt Olma
[Multiple Kayıt Linki](https://www.app.multiple.cc/#/signup?inviteCode=F0435S5T)

---

### remove_vps.sh

#### Amaç
Tüm projeleri kaldırır ve VPS’inizi sıfırlamanıza olanak tanır.

#### Kaldırma İşlemi
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/remove_vps.sh
chmod +x remove_vps.sh
./remove_vps.sh
```

---

## Projeler ve Referans Linkler

### Referans Linklerim

- **Grass**: [Kaydol](https://app.getgrass.io/register/?referralCode=OvrLV9QgyWJRoHt)
- **Nodepay**: [Kaydol](https://app.nodepay.ai/register?ref=TfxCSlIHPEuHVi7)
- **Network3**: [Kaydol](https://account.network3.ai/register_page?rc=644903e7)
- **Gradient**: [Kaydol](https://app.gradient.network/signup?code=ZOCFP7)
- **Bless**: [Kaydol](https://bless.network/dashboard?ref=5ORSGD)
- **Oasis**: [Kaydol](https://r.oasis.ai/halilunay)
- **Blockmesh**: [Kaydol](https://app.blockmesh.xyz/register?invite_code=e5e83bbe-8c0c-4817-81b9-9f84f4ea9e62)
- **Dawn**: Referral Code: `bcwzlhxc`
- **Teneo**: Referral Code: `uowoj`
- **Functor**: [Kaydol](https://node.securitylabs.xyz/?from=extension&type=signin&referralCode=cm34uttd02174mo1br359bgp3)
- **Toggle**: [Kaydol](https://toggle.pro/sign-up/b15c57ba-6f4b-4f16-abb6-a9073dbdff69)
- **Pipe**: [Kaydol](https://pipecdn.app/signup?ref=aGxsdW5heU)
- **Kaisar**: [Kaydol](https://zero.kaisar.io/register?ref=fSDtHC012)
- **DataQuest**: [Kaydol](https://dataquest.nvg8.io//signup?ref=272459)
- **Kleo**: [Kaydol](https://chromewebstore.google.com/detail/kleo-network/jimpblheogbjfgajkccdoehjfadmimoo?refAddress=0x95A809E771E40fBa5b442B7850dcAFe04425dDaD)
- **AlphaOS**: [Kaydol](https://alphaos.net/point?invite=Q0FD2Y)
- **Threat Slayer**: [Kaydol](https://threatslayer.interlock.network/register?referral_code=oYJo2dqtlRNp3jTV)
- **Gaea**: [Kaydol](https://app.aigaea.net/register?ref=gayXVNm9Jbpk5q)
- **Meshchain**: [Kaydol](https://app.meshchain.ai?ref=F2AS3MHE7TR2)
- **Blockcast**: [Kaydol](https://app.blockcast.network?referral-code=i3QKe8)
- **Multiple**: [Kaydol](https://www.app.multiple.cc/#/signup?inviteCode=F0435S5T)

---

## Yararlı Komutlar

### Docker Yönetimi
- **Çalışan konteynerları listeleme**:
    ```bash
    docker ps
    ```
- **Tüm konteynerları (çalışmayanlar dahil) listeleme**:
    ```bash
    docker ps -a
    ```
- **Bir konteyneri durdurma**:
    ```bash
    docker stop <container_id>
    ```
- **Bir konteyneri başlatma**:
    ```bash
    docker start <container_id>
    ```
- **Konteyner günlüklerini görüntüleme**:
    ```bash
    docker logs <container_id>
    ```

### Sistem Yönetimi
- **Disk alanını kontrol etme**:
    ```bash
    df -h
    ```
- **Sistem kaynaklarını izleme**:
    ```bash
    bpytop
    ```
- **Aktif bağlantıları kontrol etme**:
    ```bash
    netstat -tuln
    ```
- **Sistemde çalışan tüm süreçleri listeleme**:
    ```bash
    ps aux
    ```

### Performans ve Testler
- **Disk okuma/yazma hızını test etme**:
    ```bash
    hdparm -Tt /dev/sda
    ```
- **Bellek testi yapma**:
    ```bash
    sysbench memory run
    ```
- **İnternet hızını test etme**:
    ```bash
    speedtest-cli
    ```
---

Herhangi bir sorun yaşarsanız, lütfen benimle iletişime geçin.
