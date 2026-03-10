# Workflow Dosyaları

## assembly_workflow.sh
Spironucleus salmonicida için kullandığım komutları içeren script.
GenoDiplo'nun tam pipeline'ı yerine direkt Flye kullandım.

## config.yaml  
GenoDiplo formatında config dosyası.
Orijinal GenoDiplo config'inden adapte ettim.

## Neden Bu Yöntemi Kullandım?

### Apple Silicon M Serisi Uyumsuzluğu
- **Conda paketleri** M1/M2 işlemci için mevcut değildi
- **QUAST boost dependency** Apple Silicon'da çalışmadı  
- **Environment.yml** dosyası GenoDiplo'da yoktu
- **Pip alternatifleri** kullanmak zorunda kaldım

### Sonuç
Apple Silicon sınırları içinde GenoDiplo'nun bilimsel yaklaşımını uyguladım.
Aynı kalitede assembly elde ettim (N50: 258kb, 225 contig).

## Kullanım
```bash
chmod +x assembly_workflow.sh
./assembly_workflow.sh
```
