# News (Seviye: Zor)
Basit bir haberler app'i yapıyoruz. 

[API](https://newsapi.org/s/google-news-api)

**Splash:** İlk açılışta basit bir Splash ekranı bizi karşılıyor. Burada app icon'u ve app name olsun. 

**News:** App açıldığında bizi karşılayan ilk ekran. Burada API'dan çekilen haberler listelenmiş bir şekilde gösterilsin. Haberlerden birine basıldığında haber detayına gidilsin. Cell'deki 3 noktaya basınca alttan bottom sheet çıksın ve sheet'de paylaşma özelliği olsun. Haberi paylaş dediğinde haberin linkini native share sheet ile paylaşabilsin.
Navigation Bar'ın altında native search bar olsun. Bu search bar ile arama yapabilsin (API'ın search desteği var). Arama sonuçları olabildiğince yumuşak bir animasyon ile gösterilsin. İlk 3 karakter için arama yapılmasın, 3. karakterden sonra her yazılan karakter için arama yapılsın.

**News Detail:** Bir haberin detay ekranı. Sağ üstteki paylaş butonu ile haber paylaşılabilsin. Haberin title'ı navigation bar'ın title'ında gösterilsin. Haberin image'inin gösterilmesi [Kingfisher kütüphanesi](https://github.com/onevcat/Kingfisher) ile yapılsın.

**Settings:** Native komponent'ler kullanılarak bir settings ekranı geliştirilsin. App Theme'de mod değişimi yapıldığında anlık olarak etki etsin (bunu yapmak zor, bu yüzden opsiyonel tutuyorum). Notification'daki switch on olduğunda bildirim izni istensin. Rate Us'a basınca herhangi bir app'in mağaza sayfasına yönlendirilsin (news app'i mağazada olmadığı için kendi app'imizin sayfasına yönlendiremeyiz). Privacy policy ve Terms of Use sayfaları da Safari'de herhangi bir linki açabilir (örnek: google.com).

## Tasarım
Tasarımı incelemek için .fig uzantılı [tasarım dosyasını](https://github.com/icommunitycomtr/reminder/blob/main/iCommunity-News.fig) indirip Figma'ya import alabilirsiniz.

Tasarımı olabildiğince koda dökmeye çalışın. Gerçek bir iş deneyimi gibi olsun.

Tasarımda iOS ekosistemine aykırı durum var ise düzelterek ekosisteme uygun hale getirin.

## Hedef
- MVVM'i en temiz şekilde kullanmak
- Reusable şekilde TableView/CollectionView kullanabilmek
- ViewModel'da mantıksal işlemler yapabilmek
- NavigationController ve TabController yapılarını anlamak
- Güzel bir network layer kurabilmek
- Localization desteği verebilmek
- Light/Dark mode desteği verebilmek

## Mimari
En basit şekilde **MVVM+Protocol** kullan.

## Dil / Framework
Swift ve UIKit

## Responsive Design
- İster **Storyboard** ister programmatically olarak UI'ı oluşturabilirsin. Eğer UI oluşturmada kendini zayıf hissediyorsan Storyboard kullanmanı tavsiye ederim
- News listesi için TableView/CollectionView kullanabilirsin. Eğer aksi bir durum yok ise **CollectionView** kullanmanı tavsiye ederim
- Tasarımın tüm iPhone'larda düzgün göründüğünden emin ol
- Landscape orientation desteği ver
- iPad desteği ver

## Akış
News listesini bir array ile kontrol et. Search mekanizmasını kullanırken bu listeyi iyi bir şekilde yönetmen lazım. Listeyi çekmek ve search yapmak için API'ı kullan.

## Anahtar Kelimeler
- MVVM
- Protocol
- Storyboard
- Auto Layout
- Programmatically
- Collection View
- Table View
- Network Layer
- Notification Permission
