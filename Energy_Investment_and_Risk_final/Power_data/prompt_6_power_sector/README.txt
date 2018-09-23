# Impact Hack
### Prompt 6: Foreign Investment and Physical Risk in the Global Power Sector


## Datasets:
* global_power_plant_database.csv : about 28000 power plants across the world
* nrdc_coal_renewable_financing_with_locations.csv : public financing related to the power sector
* aux_power_plant_elevation.csv : association between power plants and their elevation
* aux_water_stress.csv : association between power plants and water stress
* aux_power_plant_storm_surge.csv : association between power plants and 100 year storm surges
* aux_spei.csv : association between power plants and the precipitation-evaporation balance
* SPEI_grids/... : grids of SPEI data given in text format


### global_power_plant_database.csv 
Source: World Resources Institue
URL: https://github.com/wri/global-power-plant-database
Fields:
	- `country` (text): 3 character country code corresponding to the ISO 3166-1 alpha-3 specification
	- `country_long` (text): longer form of the country designation
	- `name` (text): name or title of the power plant, generally in Romanized form
	- `gppd_idnr` (text): 10 or 12 character identifier for the power plant
	- `capacity_mw` (number): electrical generating capacity in megawatts
	- `latitude` (number): geolocation in decimal degrees; WGS84 (EPSG:4326)
	- `longitude` (number): geolocation in decimal degrees; WGS84 (EPSG:4326)
	- `fuel1` (text): energy source used in electricity generation or export
	- `fuel2` (text): energy source used in electricity generation or export
	- `fuel3` (text): energy source used in electricity generation or export
	- `fuel4` (text): energy source used in electricity generation or export
	- `commissioning_year` (number): year of plant operation, weighted by unit-capacity when data is available
	- `owner` (text): majority shareholder of the power plant, generally in Romanized form
	- `source` (text): entity reporting the data; could be an organization, report, or document, generally in Romanized form
	- `url` (text): web document corresponding to the `source` field
	- `geolocation_source` (text): attribution for geolocation information
	- `year_of_capacity_data` (number): year the capacity information was reported
	- `generation_gwh_2013` (number): electricity generation in gigawatt-hours reported for the year 2013 
	- `generation_gwh_2014` (number): electricity generation in gigawatt-hours reported for the year 2014
	- `generation_gwh_2015` (number): electricity generation in gigawatt-hours reported for the year 2015 
	- `generation_gwh_2016` (number): electricity generation in gigawatt-hours reported for the year 2016
	- `estimated_generation_gwh` (number): estimated annual electricity generation in gigawatt-hours for the year 2014

### nrdc_coal_renewable_financing_with_locations.csv
Source: Natural Resources Defense Council (modified)
URL: https://www.nrdc.org/resources/power-shift-g20-international-public-finance-from-coal-to-renewables
Fields: Look at documentation from the original source file. Some additional columns have been added.
	- `GPPD ID` (text): control code for a power plant matching the project
	- `Latitude` (number): latitude of the power plant
	- `Longitude` (number): longitude of the power plant
	- `Location Source` (text): source of the location information, either WRI or GCPT

### aux_power_plant_elevation.csv
Fields:
	- `gppd_idnr` (text): control code for a power plant
	- `elevation_meters` (number): elevation in meters of the power plant 
	
### aux_water_stress.csv
Source: Aqueduct (modified)
URL: http://datasets.wri.org/dataset/aqueduct-global-maps-21-data
Fields:
	- `gppd_idnr` (text): control code for a power plant
	- `basin_id` (number): control code for a hydrologic basin
	- `basin_name` (text): name of the hydrologic basin
	- `overall_score` (number): value between 0 and 5 indicating the overall water stress
	- `overall_category` (text): an assigned category for the overall water stress
	- `baseline_water_stress_score` (number): value indicating competition over blue water
	- `baseline_water_stress_category` (text): an assigned category
	- `drought_severity_score` (number): value indicating frequency and severity of droughts
	- `drought_severity_category` (text): an assigned category
	- `groundwater_stress_score` (number): value indicating withdrawal-recharce imbalance
	- `groundwater_stress_category` (text): an assigned category

### aux_power_plant_storm_surge.csv
Source: Global Tide and Surge Reanalysis (modified)
URL: https://www.nature.com/articles/ncomms11969
Fields:
	- `gppd_idnr` (text): control code for a power plant
	- `100_year_surge_at_risk` (bool): 1 = at risk of 100 year storm surge, otherwise 0
	- `minimum_inundation_height_meters` (number): minimum depth of water at power plant during a 100 year storm surge 

### aux_spei.csv
Source: Consejo Superior de Investigaciones Cientificas
URL: http://spei.csic.es/index.html
Fields:
	- `gppd_idnr` (text): control code for a power plant
	- `25_year_avg` (number): average SPEI over the period 1991-2015
	- `spei_YEAR` (number): average SPEI over the specified year

### SPEI_grids/...
Source: Consejo Superior de Investigaciones Cientificas
URL: http://spei.csic.es/index.html
Each grid is 360 rows by 720 columns, covering the whole globe at 0.5-degree resolution.
Areas without data (like oceans) have a value of `nan`.


