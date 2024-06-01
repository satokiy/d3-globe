inputDir ?= ne_110m_admin_0_countries
geojsonDir ?= geojson
topojsonDir ?= topojson

.PHONY: geojson
geojson:
	docker run --rm -v $$(pwd):/tmp osgeo/gdal:ubuntu-full-3.0.2 ogr2ogr -f GeoJSON -t_srs crs:84 /tmp/$(geojsonDir)/output.geojson /tmp/$(inputDir)/ne_110m_admin_0_countries.shp

.PHONY: topojson
topojson:
	docker build -t topojson .
	docker run --rm -v $$(pwd):/tmp topojson geo2topo -q 1e6 countries=/tmp/$(geojsonDir)/output.geojson > $(topojsonDir)/output.topojson

.PHONY: generate
generate: geojson topojson
