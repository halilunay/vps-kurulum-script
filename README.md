
# VPS Kurulum Scriptleri

Bu repoda, bir VPS üzerinde çeşitli işlemleri otomatik olarak gerçekleştiren scriptler bulunmaktadır. Kullanıcıların her adımı takip ederek kolayca kurulum yapabilmesi için detaylı rehberler eklenmiştir.

---

## İçerikler

1. **VPS Hazırlık Scripti (setup_vps.sh)**: VPS için gerekli temel yapılandırma ve Chromium kurulumunu içerir.
2. **Network3 Node Kurulum Scripti (install_network3.sh)**: Network3 node'unu kolayca kurar.
3. **Multiple Node Kurulum Scripti (install_multiple.sh)**: Multiple node'unu kurar ve yapılandırır.
4. **VPS Kaldırma Scripti (remove_vps.sh)**: VPS üzerindeki tüm yapılandırmayı kaldırır.

---

## Kullanım Rehberi

### Multiple Node Kurulumu

1. Script'i indirin:
   ```bash
   wget https://raw.githubusercontent.com/halilunay/vps-kurulum-script/main/install_multiple.sh
   ```

2. Script'i çalıştırılabilir hale getirin:
   ```bash
   chmod +x install_multiple.sh
   ```

3. Script'i çalıştırın:
   ```bash
   sudo ./install_multiple.sh
   ```

4. Kurulum tamamlandıktan sonra, aşağıdaki adımları izleyin:

   - **Node'u Arka Planda Başlatın**:
     ```bash
     nohup ./multiple-node > output.log 2>&1 &
     ```

   - **Hesabınızı Bağlayın**:
     ```bash
     multiple-cli bind --bandwidth-download 100 --identifier HESAP_ID --pin PIN --storage 200 --bandwidth-upload 100
     ```
     > **Not:** `HESAP_ID` ve `PIN` değerlerini kendi bilgilerinizle değiştirin.

5. **Kontrollerinizi Yapın**:
   ```bash
   multiple-cli status
   ```

6. **Bağlantı Detaylarınızı Doğrulayın**:
   Script'in verdiği bağlantı veya bilgiler üzerinden hesabınızı kontrol edin.

---

## Node'u Kapatma veya Silme

1. Multiple için oluşturulan yapılandırmayı kaldırmak için şu komutları çalıştırın:
   ```bash
   sudo rm -rf multiple
   ```

2. Ek bir temizleme işlemi gerekirse, VPS kaldırma scriptini kullanabilirsiniz.

---

## Ek Bilgi

Multiple kurulumu tamamlandıktan sonra aşağıdaki projelere göz atabilirsiniz:

- **Grass**: [Kayıt Linki](https://app.getgrass.io/register/?referralCode=OvrLV9QgyWJRoHt)
- **Nodepay**: [Kayıt Linki](https://app.nodepay.ai/register?ref=TfxCSlIHPEuHVi7)
- **Network3**: [Kayıt Linki](https://account.network3.ai/register_page?rc=644903e7)
- **Gradient**: [Kayıt Linki](https://app.gradient.network/signup?code=ZOCFP7)
- **Bless**: [Kayıt Linki](https://bless.network/dashboard?ref=5ORSGD)
- **Oasis**: [Kayıt Linki](https://r.oasis.ai/halilunay)
- **Blockmesh**: [Kayıt Linki](https://app.blockmesh.xyz/register?invite_code=e5e83bbe-8c0c-4817-81b9-9f84f4ea9e62)
- **Dawn**: Referral Code: bcwzlhxc
- **Teneo**: Referral Code: uowoj

OpenLayer ve Blockcast projelerinin indirme bağlantıları henüz mevcut değildir, bağlantılar oluşturulduğunda README.md dosyasına eklenecektir.

---

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır.
