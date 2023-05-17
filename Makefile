SITEMAP_DOMAIN_IN=example.com
SITEMAP_DOMAIN_OUT=example.com
SITEMAP_FILENAME=sitemap.xml

IN_DIR=import
OUT_DIR=docs
COPY_DIR=copy

.PHONY: all import build serve commit deploy

all: import deploy

import:
	mkdir -p $(IN_DIR)
	cp ~/Downloads/simply-static-*.zip ./import || true

build:
	rm -rf $(OUT_DIR)
	mkdir -p $(OUT_DIR)
	unzip -d $(OUT_DIR) ./$(IN_DIR)/$(shell ls -1 $(IN_DIR) | sort -r | head -1)
	sed -i 's/http:\/\/$(SITEMAP_DOMAIN_IN)\/$(SITEMAP_FILENAME)/https:\/\/$(SITEMAP_DOMAIN_OUT)\/$(SITEMAP_FILENAME)/g' $(OUT_DIR)/robots.txt || true
	cp -a $(COPY_DIR)/. $(OUT_DIR)/
	rm $(OUT_DIR)/.gitkeep

serve:
	@echo "INFO: serving static wordpress export in docs folder locally"
	@echo "INFO: once you are done checking everything for correctness, run $$ make deploy"
	(sleep 0.5 && xdg-open http://localhost:8000 &)
	python3 -m http.server -d $(OUT_DIR) 8000

commit:
	git reset
	git add $(OUT_DIR)
	git diff --cached --exit-code || git commit -m "$(shell date +"export %Y-%m-%d %H:%M:%S")"

deploy: build commit
	git push -u origin main
