[r-wiki-get]
============

Công cụ tải xuống một trang [mediawiki](http://mediawiki.org) (chẳng hạn trang [Wikipedia tiếng Việt](vi.wikipedia.org)), rồi tải lên một wiki khác.

Ở đây tôi tải xuống trang [freeCAD wiki](http://www.freecadweb.org/wiki) rồi tải lên [localhost](http://localhost/freecad) (để sử dụng ngoại tuyến).

## Lấy nội dung các trang trên wiki

- Xem chương trình lấy tiêu đề trang ở tệp [getpages.R](getpages.R).

- Xuất trang theo tiêu đề tại [Special:Export](http://www.freecadweb.org/wiki/index.php?title=Special:Export).

- Nhập trang tại [Special:Import](http://localhost/freecad/index.php/Special:Import).

## Lấy ảnh từ wiki

- Xem chương trình lấy url ảnh ở tệp [getimages.R](getimages.R).

- Tải ảnh xuống bằng `wget`:

~~~bash
wget -i img-list.txt
~~~

- Nhập ảnh bằng `php`:

~~~bash
sudo chmod -R 777 ./images
php maintenance/importImages.php /path/to/downloaded/images/ svg png jpg jpeg gif bmp SVG PNG JPG JPEG GIF BMP --search-recursively
~~~

## Rebuild để hoàn thành nhập

~~~bash
php maintenance/rebuildall.php
~~~

---

Những chỉnh sửa cần thiết trong `LocalSettings.php` xem thêm tại [mediawiki.org](http://www.mediawiki.org/wiki/Manual:Configuration_settings).
