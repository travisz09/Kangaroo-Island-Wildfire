# Kangaroo-Island-Wildfire

This original code is the product of Travis Zalesky's <a href = "https://sites.google.com/view/traviszaleskyprojectportfolio/home?authuser=1">Final Project in U. of AZ MS GIST class 601B - Remote Sensing</a>. It is being provided publicly in the interest of transparity and repeatability. Any part of this work may be used or modified, but please credit my work. Thank you.



Copyright 2023 Travis Zalesky

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Data sources!!!
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Nickname  | Source                               | Registration Required? | Satelite    | Path | Row | Center (lat/long)   | Date                   | Product                     | Filename                                     |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Fire      | https://earthexplorer.usgs.gov/      | Y                      | Landsat 8   | 98   | 85  | NA                  | 1/9/2020               | Landsat Colletion 2 Level-2 | LC08_L2SP_098085_20200109_20200823_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Prefire1  | https://earthexplorer.usgs.gov/      | Y                      | Landsat 8   | 98   | 85  | NA                  | 2/23/2019              | Landsat Colletion 2 Level-2 | LC08_L2SP_098085_20190223_20200829_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Prefire2  | https://earthexplorer.usgs.gov/      | Y                      | Landsat 8   | 98   | 85  | NA                  | 12/8/2019              | Landsat Colletion 2 Level-2 | LC08_L2SP_098085_20191208_20200824_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Postfire1 | https://earthexplorer.usgs.gov/      | Y                      | Landsat 8   | 98   | 85  | NA                  | 2/10/2020              | Landsat Colletion 2 Level-2 | LC08_L2SP_098085_20200210_20200823_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| Postfire2 | https://earthexplorer.usgs.gov/      | Y                      | Landsat 8   | 98   | 85  | NA                  | 12/26/2020             | Landsat Colletion 2 Level-2 | LC08_L2SP_098085_20201226_20210310_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| 2023      | https://earthexplorer.usgs.gov/      | Y                      | Landsat 9   | 98   | 85  | NA                  | 10/8/2023              | Landsat Colletion 2 Level-2 | LC09_L2SP_098085_20231008_20231009_02_T1.tar |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+
| MOD13Q1   | https://modis.ornl.gov/globalsubset/ | Y                      | MODIS Terra | NA   | NA  | -35.88905/136.81271 | 2/18/2000 to 11/1/2023 | MOD13Q1                     | statistics_250m_16_days_NDVI.csv             |
+-----------+--------------------------------------+------------------------+-------------+------+-----+---------------------+------------------------+-----------------------------+----------------------------------------------+

