
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

### Amaç
VPS'inizi optimize etmek ve çeşitli araçları kurmak için aşağıdaki adımları gerçekleştirir:

#### Swap Alanı Oluşturma
- 10 GB boyutunda bir swap alanı oluşturur ve sisteme tanıtarak otomatik olarak kullanıma alır.

#### Sistem Güncellemesi
- Paket listelerini günceller ve mevcut paketleri en son sürümlerine yükseltir.

#### Docker ve Bağımlılıklarının Kurulumu
- Gerekli bağımlılıkları yükler.
- Docker'ın resmi GPG anahtarını ekler ve Docker deposunu sisteme tanıtarak Docker Engine'i kurar.

#### Docker Compose Kurulumu
- Docker Compose'un belirtilen sürümünü indirir ve çalıştırılabilir hale getirir.

#### Chromium için Docker Compose Yapılandırması
- Kullanıcı adı ve şifresi varsayılan olarak **admin** olan bir Chromium servisi için Docker Compose dosyası oluşturur.
- Bu servis, 3010 ve 3011 numaralı portlar üzerinden erişilebilir.

#### Chromium Servisinin Başlatılması
- Oluşturulan Docker Compose yapılandırmasını kullanarak Chromium servisini başlatır.

#### İzleme ve Performans Araçlarının Kurulumu
- `bpytop`, `hdparm`, `sysbench` ve `speedtest-cli` gibi sistem izleme ve performans test araçlarını yükler.

#### Performans Testlerinin Gerçekleştirilmesi
- İnternet hızı, bellek ve disk performansını test eder ve sonuçları şu dosyalara kaydeder:
  - `speedtest.txt`
  - `ram_benchmark.txt`
  - `disk_benchmark.txt`

#### Günlük Önbellek Temizleme için Cron Job Eklenmesi
- Her gün saat 00:00'da `/root/.cache/` dizinindeki dosyaları temizlemek için bir cron job ekler.

---


#### Kurulum:
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/setup_vps.sh
chmod +x setup_vps.sh
./setup_vps.sh
```

### Önemli Not
Bu script, VPS'inizi hızlı bir şekilde yapılandırmak ve gerekli araçları kurmak için tasarlanmıştır. **Ancak, özellikle varsayılan kullanıcı adı ve şifrelerin güvenlik riskleri oluşturabileceğini unutmayın.** Kurulum sonrasında aşağıdaki talimatlarla bu bilgileri değiştirmeniz önerilir:

1. `docker-compose.yaml` dosyasını düzenleyin:
    ```bash
    nano docker-compose.yaml
    ```
2. Dosyada kullanıcı adı ve şifreyi şu şekilde değiştirin:
    ```yaml
      - CUSTOM_USER=<yeni_kullanıcı_adı>
      - PASSWORD=<yeni_şifre>
    ```
3. Dosyayı kaydedip çıkmak için `Ctrl+X`, ardından `Y` ve `Enter` tuşlarına basın.
4. Chromium servisini yeniden başlatın:
    ```bash
    cd $HOME/chromium
    docker compose up -d
    ```

#### Sistem İzleme:
Kurulum sonrası bpytop ile sisteminizi izleyebilirsiniz:
```bash
bpytop
```

---

### install_network3.sh

#### Amaç:
Network3 projesine katılmak için gereken tüm bileşenleri yükler.

#### Kurulum:
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_network3.sh
chmod +x install_network3.sh
./install_network3.sh
```

#### Kayıt Olma:
[Network3 Kayıt Linki](https://account.network3.ai/register_page?rc=644903e7)

---

### install_multiple.sh

#### Amaç:
Multiple projesine katılmak için gereken bileşenleri yükler.

#### Kurulum:
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_multiple.sh
chmod +x install_multiple.sh
./install_multiple.sh
```

#### Kayıt Olma:
[Multiple Kayıt Linki](https://www.app.multiple.cc/#/signup?inviteCode=F0435S5T)

---

### remove_vps.sh

#### Amaç:
Tüm projeleri kaldırır ve VPS’inizi sıfırlamanıza olanak tanır.

#### Kaldırma İşlemi:
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

- **Günlükleri Temizleme**:
    ```bash
    rm -rf /root/.cache/*
    ```

- **Disk Alanını Kontrol Etme**:
    ```bash
    df -h
    ```

- **Sistem İzleme**:
    Kurulum sonrası `bpytop` kullanabilirsiniz:
    ```bash
    bpytop
    ```

---

Herhangi bir sorun yaşarsanız, lütfen benimle iletişime geçin.
