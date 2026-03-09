# Spironucleus salmonicida Genom Assembly Projesi

## Proje Amacı
Between Data Dreams yarışmasında Kaşif kademesi ödülünü kazanmak amacıyla Spironucleus salmonicida'nın PacBio verilerinden genom assembly'si gerçekleştirilmiştir.

## Araştırma Metodolojisi

### Bilgi Toplama Süreci
- **ChatGPT ile konsültasyon:** Biyoinformatik terimlerini anlamak için
- **YouTube eğitim videoları:** Assembly sürecinin görsel olarak anlaşılması  
- **GenoDiplo GitHub deposu:** Pipeline'ın nasıl çalıştığını öğrenmek
- **NCBI dokümantasyonu:** SRA veritabanından veri indirme
- **Flye ve QUAST manual'ları:** Araç kullanımı için

### Öğrenme Sürecim
Bu projeye sıfır biyoinformatik bilgisi ile başladım. Her adımda:
- Hatalarla karşılaştığımda Stack Overflow ve GitHub issues'ları inceledim
- Terim anlamlarını AI asistanından öğrendim
- Assembly mantığını analojiler (puzzle, gazete parçaları) ile kavradım
- Her komutu çalıştırmadan önce ne yaptığını anlamaya çalıştım

### Yardım Aldığım Kaynaklar
- **Claude AI:** Süreç boyunca rehberlik ve açıklamalar
- **Conda/pip dokümantasyonları:** Dependency sorunları için
- **Biyoinformatik topluluk forumları:** Benzer hataları çözmek için

## Tür Seçimi ve Gerekçesi

### Neden Spironucleus salmonicida?
Başta hiçbir fikrim yoktu hangi organizmayı seçeceğim konusunda.

**Karar süreci:**
1. **Yarışma talimatlarını okudum:** "Diplomonadlar (Spironucleus, Hexamita, Giardia) mükemmeldir — GenoDiplo bunlar için yapıldı" yazılmıştı.
2. **NCBI SRA'da arama yaptım:** "Spironucleus" aradım, birkaç tür çıktı
3. **SRR8895275'i seçtim çünkü:**
   - PacBio RS II verisi vardı (GenoDiplo uzun okumalar için)
   - 4.1 Gb veri → yeterli coverage olacağını düşündüm => gpt seçim kriterlerimi önerdiği gibi belirlememe yardımcı oldu
   - Uppsala Üniversitesi yüklemiş → güvenilir kaynak
   - Genome size literature'dan ~12.9 MB → yönetilebilir boyut

**Alternatif düşündüklerim:**
- *Giardia* → çok büyük, ilk proje için zor olduğunu ve hata aldığımda anlayamayacağım için risksiz seçim yapmam gerekti.
- *Hexamita inflata* → çok yeni, karşılaştırma ve sonraki aşama olursa devam etmem çok zor olacaktı.
- Bakteriler → Hakkında bir fikrim yoktu ve genom büyüklüğü farklı olursa vs. zaman kaybı yaşayabilirdim.

**Sonuç:** Çok ne yaptığımı bilmesemde, gpt önerisi, yarışma talimatları ve veri özelliklerine göre Spironucleus salmonicida'yı seçtim, bu da iyi bir seçim oldu çünkü assembly süreci boyunca karşılaştığım hataları çözebildim ve sonunda başarılı bir assembly elde ettim.

## Veri Kaynağı
- **SRR Numarası:** SRR8895275
- **Platform:** PacBio RS II
- **Okuma sayısı:** 163,480
- **Toplam baz:** 1,225,611,356 bp
- **Coverage:** 95x
- **Kaynak:** Uppsala Üniversitesi

## Metodoloji
1. **Veri indirme:** fasterq-dump ile SRA'dan indirme (55 dakika) => Ham veri indirilmesi
2. **Assembly:** Flye 2.9.6 ile genom birleştirme (8 saat 11 dakika) => Parça parça gelen verinin, A-T-G-C harflerine göre birleştirilmesi
3. **Kalite analizi:** QUAST 5.2.0 ile değerlendirme => Birleştirilen genomun kalitesinin ölçülmesi

## Karşılaştığım Hatalar ve Çözümleri

### 1. Conda Environment Hatası
**Hata:** `EnvironmentFileNotFound: environment.yml file not found`
**Çözüm:** Manuel conda environment oluşturma: `conda create -n GenoDiplo flye`

### 2. QUAST Dependency Sorunu
**Hata:** `LibMambaUnsatisfiableError: boost >=1.66.0 needed`
**Çözüm:** pip kullanarak kurulum: `pip install quast` => Çünkü silicon M serisi işlemci için conda paketleri uyumsuzdu 1.66.1 sürümü vs. bulunmamaktaydı

### 3. Assembly Kesintisi
**Hata:** PC kapanması nedeniyle assembly yarıda kesildi (70% tamamlanmışken) 
**Çözüm:** Flye'nin `--resume` özelliği kullanılmadı, baştan başlatıldı => Kapanması durumunda Flye'nin `--resume` özelliği varmış, bunu kullanarak devam edebilirdim, ancak zaman kaybı yaşandı.

## Sonuçlar
- **Toplam uzunluk:** 14,658,661 bp
- **Contig sayısı:** 225
- **N50:** 258,722 bp
- **L50:** 17
- **En büyük contig:** 931,348 bp
- **GC içeriği:** 34.11%

## Terim Açıklamaları

**Assembly:** 163,480 küçük DNA parçasını alıp tek genom yaptık. => Yani elimizde kocaman bir resim var, bir çocuk oturup parçalara ayırmış, biz de bu parçalara bakarak resmi tekrar birleştirdik.

**Contig:** Birleştirilmiş tek parça. Hiç boşluk olmayan sürekli DNA dizisi. Bizde 225 tane çıktı, ideal 9 olurdu (9 kromozom). => Yani elimizde 225 küçük resim var, aslında tek bir büyük resim olması gerekiyordu.
Lakin bu kadar parçaya bölünmesi, bazı bölgelerin çok benzer olması veya yeterince uzun okunmaması gibi nedenlerden kaynaklanabiliyor, bu yüzden 225 contig var.

**N50:** "Parçaların ne kadar uzun?" sorusunun cevabı. 258,722 = ortalamada uzun parçalar var, iyi birleştirmişiz demek. => Yani elimizdeki parçaların yarısı 258,722 bp'den uzun, diğer yarısı daha kısa. Bu da parçaların genel olarak uzun olduğunu gösteriyor.

**Coverage:** Her DNA bölgesinin kaç kez okunduğu. 95x = her bölge 95 kez okunmuş. Çok okuma = çok güvenilir. => 95 kez okunmasına rağmen 225 parçaya bölünmesi, bazı bölgelerin çok benzer olması veya yeterince uzun okunmaması gibi nedenlerden kaynaklanabiliyorsa, hala güvenilir bir assembly olabilir, ancak ideal olarak daha az parçaya bölünmesi bekliyordum.

**GC Content:** DNA'daki G ve C harflerinin oranı. Her canlının kendine özgü yüzdesi var. %34 Spironucleus için normal. => Her canlının DNA'sında A,T,G,C harfleri var, bu harflerin oranı türler arasında farklılık gösterebilir. Spironucleus salmonicida'nın GC içeriği %34, bunun doğrulamasını ise, assembly sonucunda elde ettiğimiz GC içeriği ile literatürdeki referans genomun GC içeriği karşılaştırarak yapabiliriz. Eğer benzerse, assembly'mizin doğruluğu konusunda daha fazla güvenilir olabiliriz.

**FASTQ:** Ham DNA verilerinin tutulduğu dosya formatı. İçinde A,T,G,C harfleri ve kalite puanları var. => Yani DNA dizilerini ve bu dizilerin ne kadar güvenilir olduğunu gösteren kalite puanlarını içeren bir dosya formatı. Bunu gpt analizine bağlayarak self-critique yaparsak, ham verilerin kalitesi düşükse, assembly'nin doğruluğu da etkilenebilir, bu yüzden ham verilerin kalitesini kontrol etmek önemlidir. analiz sonucuna göre re-assembly yapmayı ya da kaliteli sonuç çıktıysa bunu direkt yollanma gibi projeler yapılabilir.

## Öğrendiklerim
## https://www.youtube.com/watch\?v\=MvuYATh7Y74 youtube videosu görsel destekleme ile anlatım için çok faydalı oldu, özellikle assembly sürecini görsel olarak anlamak açısından.

### DNA Okuma Süreci
- DNA çok uzun olduğu için makine parçalara kesip okuyor
- Sonication (ses dalgası) ile rastgele kesilip 5-50 bin harflik parçalar oluyor  
- PacBio makinesi her harfi eklerken ışık çıkarıyor, kamera yakalıyor. Her harf için A-T-G-C farklı ışık çıkarıyor, böylece hangi harf olduğunu anlıyor
- Flye algoritması bu parçaları puzzle gibi birleştiriyor

### Biyoinformatik Pipeline
- Conda ortam yönetimi kritik, dependency hell yaşanabilir
- Flye PacBio uzun okumalar için en iyi seçenek
- QUAST assembly kalitesini ölçmek için standart araç
- N50 yüksek = iyi, contig sayısı az = iyi

### Proje Yönetimi
- 8+ saatlik işlemler kesintisiz makine gerektirir
- Log dosyaları takip için hayati önem taşıyor => Hata aldığımda devam edip etmediğimi loglardan kontrol ettim, bu yüzden log dosyalarını düzenli olarak incelemek önemli
- Plan B (pip vs conda) her zaman bulundurmalı
- GitHub early commit yapmak çok mantıklı, böylece ilerlemeyi belgeleyebilir ve gerektiğinde geri dönebilirim.

## Sonuç
Spironucleus salmonicida genomu başarıyla 225 contig halinde assembly edilmiştir. Elde edilen genom gen annotasyonu ve karşılaştırmalı analiz için uygun kalitededir.

## Gelecekteki Araştırma Hedefleri

### Bir sonraki adımda ne keşfetmek isterdim?

**Benim aklıma takılan sorular:**
- **225 parçayı nasıl birleştiririm?** 9 kromozona indirgemek mümkün mü?
- **Boşluklar yüzünden hastalığı anlayamazsam ne olur?** Kritik genler eksik mi?
- **Bu DNA'dan hastalık nasıl anlaşılır?** Mutation detection nasıl yapılır?
- **İnsan genomu analizi nasıl farklı?** Babalık testi mantığı aynı mı?

**İş fırsatları açısından:**
- **Balık hastalığı tanısı servisi** gerçekten karlı olur mu?
- **Web scraping + biyoinformatik** kombinasyonu nasıl monetize edilir?
- **Mevcut data science becerilerim** bu alanda nasıl kullanılır?

**Teknik meraklar:**
- **DNA dizileme makineleri** nasıl çalışıyor? Türkiye'de neden yok?
- **Assembly algoritmaları** nasıl bu kadar akıllı puzzle çözebiliyor?
- **Coverage 95x'ten fazla** olsa daha iyi sonuç alır mıydım?

**Pratik endişeler:**
- Bu sonuçlar **gerçek bilim insanları** için yeterli mi?
- **QUAST skorlarım** literatürdeki diğer çalışmalarla karşılaştırıldığında nasıl?
- **Assembly süresi 8+ saat** normal mi, yoksa bir şey yanlış mı yaptım?

## Kaynakça

### Araçlar ve Yazılımlar
- Kolmogorov, M., Yuan, J., Lin, Y. & Pevzner, P. A. Assembly of long, error-prone reads using repeat graphs. Nature Biotechnology 37, 540-546 (2019). [Flye]
- Gurevich, A., Saveliev, V., Vyahhi, N. & Tesler, G. QUAST: quality assessment tool for genome assemblies. Bioinformatics 29, 1072-1075 (2013).
- Leinonen, R., Sugawara, H. & Shumway, M. The sequence read archive. Nucleic Acids Research 39, D19-D21 (2011). [SRA Database]

### Genom Referansları  
- Jerlström-Hultqvist, J. et al. Genome analysis of the diplomonad Spironucleus salmonicida. Molecular and Biochemical Parasitology 190, 66-74 (2013).
- NCBI Genome Database: https://www.ncbi.nlm.nih.gov/genome/

### Pipeline ve Metodoloji
- Akdeniz, Z. GenoDiplo: Genome Assembly Pipeline for Diplomonads. Uppsala University (2024). GitHub: https://github.com/zeyak/GenoDiplo
- Between Data Dreams Contest Tutorial: https://agent-69986f9dc45271a--neon-dieffenbachia-1baf4c.netlify.app/bdd_contest_tutorial_tr

### Veri Kaynağı
- Uppsala University. Spironucleus salmonicida Whole Genome Sequencing. SRA Accession: SRR8895275. NCBI Sequence Read Archive (2019).

---
*GitHub Repository: https://github.com/ugurcanyanik/MyGenome-Spironucleus*
