
# VPS Kurulum Scripti Rehberi

Bu rehber, **VPS Kurulum Scriptleri** için kullanım, kurulum ve kaldırma işlemlerini detaylı bir şekilde açıklamaktadır. Ayrıca referans linkler ve ilgili projelere ait indirme bağlantıları da rehbere eklenmiştir.

## İçindekiler

- [Genel Bilgilendirme](#genel-bilgilendirme)
- [Script Dosyaları ve İşlevleri](#script-dosyaları-ve-işlevleri)
  - [setup_vps.sh](#setup_vpssh)
  - [install_network3.sh](#install_network3sh)
  - [install_multiple.sh](#install_multiplesh)
  - [remove_vps.sh](#remove_vpssh)
- [Kurulum](#kurulum)
- [Kaldırma İşlemleri](#kaldırma-işlemleri)
- [Yararlı Komutlar](#yararlı-komutlar)
- [Projeler ve Referans Linkler](#projeler-ve-referans-linkler)
  - [Referans Linklerim](#referans-linklerim)
  - [İndirme Bağlantıları](#indirme-bağlantıları)

## Genel Bilgilendirme

Bu rehber, belirli VPS projelerini kolayca kurmak ve yönetmek için hazırlanmıştır. Scriptler, farklı projelere hızlıca dahil olmanıza olanak tanır. İlgili komutlar ve referans linkler aşağıda detaylı bir şekilde verilmiştir.

## Script Dosyaları ve İşlevleri

### setup_vps.sh

Bu script, temel VPS kurulum işlemlerini içerir. Gereksinimler yüklenir ve VPS'in projelere hazır hale gelmesi sağlanır.

**İndirme Linki**: [setup_vps.sh](https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/setup_vps.sh)

### install_network3.sh

Network3 projesine katılmak için gereken tüm bileşenleri yükler.

**İndirme Linki**: [install_network3.sh](https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_network3.sh)

**Kayıt Linki**: [Network3 Kayıt Linki](https://account.network3.ai/register_page?rc=644903e7)

### install_multiple.sh

Multiple projesine katılmak için gereken tüm bileşenleri yükler.

**İndirme Linki**: [install_multiple.sh](https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_multiple.sh)

**Kayıt Linki**: [Multiple Kayıt Linki](https://www.app.multiple.cc/#/signup?inviteCode=F0435S5T)

### remove_vps.sh

Yüklenmiş tüm projeleri kaldırmak ve VPS'i sıfırlamak için kullanılır.

**İndirme Linki**: [remove_vps.sh](https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/remove_vps.sh)

## Kurulum

1. Scriptleri indirin:
    ```bash
    wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/<script_adı>.sh
    chmod +x <script_adı>.sh
    ```
    Örnek: `setup_vps.sh` için aşağıdaki komutu çalıştırabilirsiniz:
    ```bash
    wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/setup_vps.sh
    chmod +x setup_vps.sh
    ./setup_vps.sh
    ```

2. İlgili projeye özel scripti çalıştırın. Örneğin, Multiple için:
    ```bash
    wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/install_multiple.sh
    chmod +x install_multiple.sh
    ./install_multiple.sh
    ```

3. Kayıt işlemini gerçekleştirin ve ilgili referans linki kullanarak projeye dahil olun.

## Kaldırma İşlemleri

Tüm projeleri kaldırmak ve VPS'i sıfırlamak için aşağıdaki komutu çalıştırabilirsiniz:
```bash
wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/refs/heads/main/remove_vps.sh
chmod +x remove_vps.sh
./remove_vps.sh
```

## Yararlı Komutlar

- **Günlükleri Temizleme**: Günlük dosyalarını temizlemek için:
    ```bash
    rm -rf /root/.cache/*
    ```

- **Disk Alanını Kontrol Etme**:
    ```bash
    df -h
    ```

- **Çalışan Süreçleri Görüntüleme**:
    ```bash
    top
    ```

## Projeler ve Referans Linkler

### Referans Linklerim

Aşağıda farklı projelere ait referans linkler verilmiştir:

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
- **Multiple**: [Kaydol](https://www.app.multiple.cc/#/signup?inviteCode=F0435S5T)

### İndirme Bağlantıları

İlgili projelere ait indirme bağlantıları için [indirme bağlantıları](https://github.com/halilunay/vps-kurulum-script) sayfasını ziyaret edebilirsiniz.

---

Tüm scriptler ve kurulum adımlarıyla ilgili bir sorun yaşarsanız lütfen benimle iletişime geçin.
