Ext.define('Sbi.chart.designer.Designer', {
    extend: 'Ext.Base',
    alternateClassName: ['Designer'],
	requires: [
        'Sbi.chart.rest.WebServiceManagerFactory',
        'Sbi.chart.designer.ChartUtils',
        'Sbi.chart.designer.ChartTypeSelector',
        'Sbi.chart.designer.AxisesContainerStore',
        'Sbi.chart.designer.AxisesPicker',
        'Sbi.chart.designer.ChartTypeColumnSelector',
        'Sbi.chart.designer.ChartCategoriesContainer',
        'Sbi.chart.designer.AxisStylePopup',
        'Sbi.chart.designer.ChartStructure',
        'Sbi.chart.designer.ChartConfigurationModel',
        'Sbi.chart.designer.ChartConfiguration',
        'Sbi.chart.designer.AdvancedEditor',
    ],

    statics: {
		jsonTemplate: null,
		chartLibNamesConfig: null,
		
		jsonTemplateHistory: [],
		jsonTemplateHistoryIterator: null,
	
    	chartServiceManager: null,
    	coreServiceManager: null,
    	docLabel: null,
    	
		// Left designer panel 
		chartTypeColumnSelector: null,
		
		selectedChartType: '',
		// chart types
    	chartTypes : [{
			name: 'Bar chart', 
			type: 'BAR',
			iconUrl:'/athenachartengine/js/src/ext4/sbi/cockpit/widgets/extjs/barchart/img/barchart_64x64_ico.png',
		}, {
			name: 'Column chart',
			type: 'COLUMN',
			iconUrl:'/athenachartengine/js/src/ext4/sbi/cockpit/widgets/extjs/barchart/img/barchart_64x64_ico.png',
		}, {	
			name: 'Line chart', 
			type: 'LINE',
			iconUrl:'/athenachartengine/js/src/ext4/sbi/cockpit/widgets/extjs/linechart/img/linechart_64x64_ico.png',
		}, {
			name: 'Pie chart', 
			type: 'PIE',
			iconUrl:'/athenachartengine/js/src/ext4/sbi/cockpit/widgets/extjs/piechart/img/piechart_64x64_ico.png',
		}, {
			name: 'Sun burst chart', 
			type: 'SUNBURST',
			iconUrl:'/athenachartengine/js/src/ext4/sbi/cockpit/widgets/extjs/piechart/img/piechart_64x64_ico.png',
		}],
		
		chartTypeStore: null,
		chartTypeSelector: null,
		
		// columns and categories pickers
		columnsPickerStore: null,
		categoriesPickerStore: null,
		columnsPicker: null,
		categoriesPicker: null,
		
		/* * * * * * START STEP 1 * * * * * */
		// main central preview panel
		mainPanel: null,
		
		// right designer vertical axes container
		rightYAxisesPanel: null,
		// left designer vertical axes container
		leftYAxisesPanel: null,
		
		// bottom designer horizontal axis
		categoriesStore: null,
		bottomXAxisesPanel: null,
		
		chartStructure: null,
		/* * * * * * END STEP 1 * * * * * */
		
		/* * * * * * START STEP 2 * * * * * */
		// data bundle for step 2 storing
		cModel: null,
		cViewModel: null,
		chartConfiguration: null,
		/* * * * * * END STEP 2 * * * * * */
		
		/* * * * * * START STEP 3 * * * * * */
		advancedEditor: null,
		/* * * * * * END STEP 3 * * * * * */
		
		// step panel
		stepsTabPanel: null,
		
		// designer main panel
		designerMainPanel: null,
		
		
		initialize: function(sbiExecutionId, userId, hostName, serverPort, docLabel, jsonTemplate, datasetLabel, chartLibNamesConfig) {
			
			this.docLabel = docLabel;
			this.jsonTemplate = jsonTemplate;
			
			this.jsonTemplateHistory.push(jsonTemplate);
			this.jsonTemplateHistoryIterator = 0;
			
			this.chartLibNamesConfig = chartLibNamesConfig;
			
			this.chartServiceManager = Sbi.chart.rest.WebServiceManagerFactory.getChartWebServiceManager('http', hostName, serverPort, sbiExecutionId, userId);
			this.coreServiceManager = Sbi.chart.rest.WebServiceManagerFactory.getCoreWebServiceManager('http', hostName, serverPort, sbiExecutionId, userId);
			
			// Creating left panel
			var chartTypes = this.chartTypes;
			var chartTypeStore = Ext.create('Ext.data.Store', {
				fields: [
					{name: 'name', type: 'string'},
					{name: 'type', type: 'string'},
					{name: 'iconUrl', type: 'string'},
				],
	 			data: chartTypes
		    });
			this.chartTypeStore = chartTypeStore;
			this.chartTypeSelector = Ext.create('Sbi.chart.designer.ChartTypeSelector', {
 				region: 'north',
 				minHeight: 50,
 				store: chartTypeStore
 			});
			var selectedChartType = jsonTemplate.CHART.type;
			this.chartTypeSelector.setChartType(selectedChartType);
			
			this.columnsPickerStore = Ext.create('Sbi.chart.designer.AxisesContainerStore', {
 				data: [],
 				sorters: [{
 					property: 'serieColumn',
 					direction: 'ASC'
 				}],
 				listeners: {
 					dataReady: function(jsonData) {
 						var jsonDataObj = Ext.JSON.decode(jsonData);
 						var theData = [];
 		  				Ext.each(jsonDataObj.results, function(field, index){
 		  					if(field != 'recNo' && field.nature == 'measure'){
 		  						theData.push({
 		  							serieColumn : field.alias,
 		  							axisType: 'ATTRIBUTE'
 		  						});
 		  					}
 		  				});
 		  				this.setData(theData);
 		  			}
 				}
 			});
			var columnsPickerStore = this.columnsPickerStore;
			
			this.categoriesPickerStore = Ext.create('Sbi.chart.designer.AxisesContainerStore', {
 				data: [],
 				sorters: [{
 					property: 'categoryColumn',
 					direction: 'ASC'
 				}],
 				listeners: {
 					dataReady: function(jsonData) {
 		  				var jsonDataObj = Ext.JSON.decode(jsonData);
 						var theData = [];
 		  				Ext.each(jsonDataObj.results, function(field, index){
 		  					if(field != 'recNo' && field.nature == 'attribute'){
 		  						theData.push({
 		  							categoryColumn : field.alias,
 		  							axisType: 'MEASURE'
 		  						});
 		  					}
 		  				});
 		  				this.setData(theData);
 		  			}
 				}
 			});
			var categoriesPickerStore = this.categoriesPickerStore;
			
			// loading measures and attributes
  			this.chartServiceManager.run('loadDatasetFields', {}, [datasetLabel], function (response) {
  				columnsPickerStore.fireEvent('dataReady', response.responseText);
  				categoriesPickerStore.fireEvent('dataReady', response.responseText);
			});
			
			this.columnsPicker = Ext.create('Sbi.chart.designer.AxisesPicker', {
  				region: 'center',
  				flex:  1,
  				margin: '0 0 5 0',
  				store: columnsPickerStore,
  				viewConfig: {
  					copy: true,
  					plugins: {
  						ptype: 'gridviewdragdrop',
  						containerScroll: true,
  						dragGroup: Sbi.chart.designer.ChartUtils.ddGroupMeasure,
  						dropGroup: Sbi.chart.designer.ChartUtils.ddGroupMeasure,
  						dragText: 'Drag from Columns Picker',
  						enableDrop: false
  					},
  					listeners: {
  						drop: function(node, data, dropRec, dropPosition) {
  							var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('serieColumn') : ' on empty view';
  							Ext.log('Drag from Columns Picker', 'Dropped ' + data.records[0].get('name') + dropOn);
  						}
  					}
  				},
  				columns: [
  					{
  						text: 'Measures list', 
  						dataIndex: 'serieColumn',
  						sortable: false,
  						flex: 1
  					}
  				]
  			});
			this.categoriesPicker = Ext.create('Sbi.chart.designer.AxisesPicker', {
  				region: 'south',
  				flex: 1,
  				margin: '0 0 5 0',
  				store: categoriesPickerStore, 
  				viewConfig: {
  					copy: true,
  					plugins: {
  						ptype: 'gridviewdragdrop',
  						containerScroll: true,
  						dragGroup: Sbi.chart.designer.ChartUtils.ddGroupAttribute,
  						dropGroup: Sbi.chart.designer.ChartUtils.ddGroupAttribute,
  						dragText: 'Drag from Categories Picker',
  						enableDrop: false
  					},
  					listeners: {
  						drop: function(node, data, dropRec, dropPosition) {
  							var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('categoryColumn') : ' on empty view';
  							Ext.log('Drag from Categories Picker', 'Dropped ' + data.records[0].get('name') + dropOn);
  						}
  					}
  				},
  				columns: [
  					{
  						text: 'Elenco attributi', 
  						dataIndex: 'categoryColumn',
  						sortable: false,
  						flex: 1
  					}
  				]
  			});
			
			this.chartTypeColumnSelector = Ext.create('Sbi.chart.designer.ChartTypeColumnSelector', {
  				chartTypeSelector: this.chartTypeSelector,
  				columnsPicker: this.columnsPicker,
  				categoriesPicker: this.categoriesPicker,
  				region: 'west'
  			});
			
			// Creating step 1 panel
  			this.mainPanel = Ext.create('Ext.panel.Panel', {
  				id: 'mainPanel',
  				height: 300,
  				html: '<div style="text-align:center">PREVIEW</div>'
  			});
			
			this.rightYAxisesPanel = Ext.create('Sbi.chart.designer.ChartAxisesContainer', {
  				id: 'chartRightAxisesContainer',
  				hidden : true
  			});
			
			this.leftYAxisesPanel = Ext.create('Sbi.chart.designer.ChartAxisesContainer', {
  				id: 'chartLeftAxisesContainer',
  				alias: 'Asse Y',
  				otherPanel: this.rightYAxisesPanel
  			});
			
			this.categoriesStore = Ext.create('Sbi.chart.designer.AxisesContainerStore', {
  				storeId: 'categoriesStore'
			});
			this.bottomXAxisesPanel = Ext.create("Sbi.chart.designer.ChartCategoriesContainer", {
  				id: 'chartBottomCategoriesContainer',
  				viewConfig: {
  					plugins: {
  						ptype: 'gridviewdragdrop',
  						containerScroll: true,
  						dragGroup: Sbi.chart.designer.ChartUtils.ddGroupAttribute,
  						dropGroup: Sbi.chart.designer.ChartUtils.ddGroupAttribute
  					},
  				},
  				store: this.categoriesStore,
  				axisData: Sbi.chart.designer.ChartUtils.createEmptyAxisData(),
				plugins: [{
					ptype:	 'cellediting',
					clicksToEdit: 1
				}],

				controller: Ext.create('Ext.app.ViewController', {
			        onTitleChange: function (barTextField, textValue) {
			        	this.view.axisData.titleText = textValue;
			        }
			    }),
			    listeners: {
			    	updateAxisTitleValue: function(textValue) {
			        	this.axisData.titleText = textValue;
			    		var textfieldAxisTitle = Ext.getCmp('textfieldAxisTitle');
			    		textfieldAxisTitle.setValue(textValue);
			    	}
			    },

				title: {
					hidden: true 
				}, 
				tools:[
				    
				    // TEXT AREA
				    {
				    	xtype: 'textfield',
				    	id: 'textfieldAxisTitle',
						flex: 10,
						allowBlank:  true,
			            emptyText: 'Insert axis title',
						selectOnFocus: true,
						value: 'titolo vuoto',
						listeners: {
				            change: 'onTitleChange',
				        }
					},
					
					// STYLE POPUP
					{
					    type:'gear',
					    tooltip: 'Set axis style',
					    flex: 1,
					    handler: function(event, toolEl, panelHeader) {
					    	var thisChartColumnsContainer = panelHeader.ownerCt;
					    	
					    	var axisStylePopup = Ext.create('Sbi.chart.designer.AxisStylePopup', {
					    		axisData: thisChartColumnsContainer.getAxisData(),
							});
							
					    	axisStylePopup.show();
						}
					}					
				],
			    
				hideHeaders: true,
  				columns: [{
					text: 'Column Name', 
					dataIndex: 'categoryColumn',
					sortable: false,
					flex: 10
				}, {
					text: 'Column Alias', 
					dataIndex: 'axisName',
					sortable: false,
					flex: 10,
					editor: {
						xtype: 'textfield',
						selectOnFocus: true,
					}
					
				}, {
					menuDisabled: true,
					sortable: false,
					xtype: 'actioncolumn',
					align : 'center',
					flex: 1,
					items: [{
						icon: '/athena/themes/sbi_default/img/delete.gif',
						tooltip: 'Remove',
						handler: function(grid, rowIndex, colIndex) {
							var rec = grid.getStore().removeAt(rowIndex);
						}
					}]
				}],
  				
  				setAxisData: function(axisData) {
  					this.axisData = axisData;
  					this.fireEvent('updateAxisTitleValue', axisData.titleText);
  				},
  				getAxisData: function() {
  					return this.axisData;
  				}
  				
  			});
		
			this.chartStructure = Ext.create('Sbi.chart.designer.ChartStructure', {
  				title: 'Step 1',
  				leftYAxisesPanel: this.leftYAxisesPanel,
  				previewPanel: this.mainPanel,
  				rightYAxisesPanel: this.rightYAxisesPanel,
  				bottomXAxisesPanel: this.bottomXAxisesPanel
  			});
		
			// Creating step 2 panel
			this.cModel = 
				Sbi.chart.designer.ChartUtils.createChartConfigurationModelFromJson(jsonTemplate);
			this.cViewModel = Ext.create('Ext.app.ViewModel',{
  				data: {
  					configModel: this.cModel
				}
  			});
			this.chartConfiguration = Ext.create('Sbi.chart.designer.ChartConfiguration', {
  				title: 'Step 2',
  				viewModel: this.cViewModel
  			});

			// Creating step 3 panel
			this.advancedEditor = Ext.create('Sbi.chart.designer.AdvancedEditor', {
  				id: 'advancedEditor',
  				title: 'Step 3'
  			});
			
			// tabs integration
			var cModel = this.cModel;
			var coreServiceManager = this.coreServiceManager;
			this.stepsTabPanel = Ext.create('Ext.tab.Panel', {
  				bodyBorder: false,
  				width: '100%',
  				region: 'center',
				title: {hidden: true },
				previousTabId: '',
  				tools:[{ 
  		            xtype: 'button',
  		            text : 'Save',
  		            handler: function(){
  		            	var exportedAsOriginalJson = Sbi.chart.designer.Designer.exportAsJson();
  		            	
  		            	var parameters = {
  		      				jsonTemplate: Ext.JSON.encode(exportedAsOriginalJson),
  		      				docLabel: docLabel
  		      			};
  		            	coreServiceManager.run('saveChartTemplate', parameters, [], function (response) {
  		      				
  		      				console.log('chartConf', response.responseText);
  		      				
  		      				//renderChart(chartConf);
  		      			});

  		            }
  		        }],
				listeners: {
				    tabchange: function(tabPanel, tab){
				    	if(tab.getId() == 'advancedEditor') {
				    		Sbi.chart.designer.Designer.chartTypeColumnSelector.disable();
				    		
				    		var json = Sbi.chart.designer.Designer.exportAsJson();
				    		
							tab.setChartData(json);
							
						} else if(tabPanel.previousTabId == 'advancedEditor') {
							Sbi.chart.designer.Designer.chartTypeColumnSelector.enable();
							
							var advancedEditor = Ext.getCmp('advancedEditor');
							if(advancedEditor.dataChanged == true) {
								var json = advancedEditor.getChartData();
								
								Sbi.chart.designer.Designer.update(json);
							}
						}
						tabPanel.previousTabId = tab.getId();
					}
				},  
  				items: [
  					this.chartStructure,
  					this.chartConfiguration,
  					this.advancedEditor,
  				]
  			});
			
			// Creating designer main panel
			this.designerMainPanel = Ext.create('Ext.panel.Panel', {
  				renderTo: Ext.getBody(),
  				xtype: 'layout-border',
  				requires: [
  					'Ext.layout.container.Border'
  				],
  				layout: 'border',
  				height: '100%',                            
  				bodyBorder: false,
  				defaults: {
  					collapsible: false,
  					split: true,
  					bodyPadding: 10
  				},
  				items: [
  					this.chartTypeColumnSelector,
  					this.stepsTabPanel,
  				]
  			});
			
			
  			/*  LOADING CONFIGURATION FROM TEMPLATE >>>>>>>>>>>>>>>>>>>> */
 			Ext.log({level: 'info'}, 'CHART: IN CONFIGURATION FROM TEMPLATE');
  			/**
  				START LOADING Y AXES, X AXIS AND SERIES >>>>>>>>>>>>>>>>>>>>
  			*/
  			this.loadAxesAndSeries(jsonTemplate);
  			/**
				END LOADING Y AXES, X AXIS AND SERIES <<<<<<<<<<<<<<<<<<<<
			*/
  			
			/**
				START LOADING CATEGORIES >>>>>>>>>>>>>>>>>>>>
			*/
			this.loadCategories(jsonTemplate);
			
			/**
				END LOADING CATEGORIES <<<<<<<<<<<<<<<<<<<<
			*/
  			
 			Ext.log({level: 'info'}, 'CHART: OUT CONFIGURATION FROM TEMPLATE');
  			
  			/*  LOADED CONFIGURATION FROM TEMPLATE <<<<<<<<<<<<<<<<<<<< */
 			
 			Ext.log({level: 'info'}, 'CHART: OUT');
		},
		
		loadCategories: function(jsonTemplate) {
			var categoriesStore = this.categoriesStore;
			// Reset categoriesStore
			categoriesStore.loadData({});
			
			var category = jsonTemplate.CHART.VALUES.CATEGORY;
			var mainCategory = Ext.create('Sbi.chart.designer.AxisesContainerModel', {
				axisName: category.name != undefined ? category.name: category.column,
				axisType: 'ATTRIBUTE', 
				
				categoryColumn: category.column,
				categoryGroupby: category.groupby, 
				categoryStacked: category.stacked, 
				categoryStackedType: category.stackedType, 
				categoryOrderColumn: category.orderColumn, 
				categoryOrderType: category.orderType
			});
			categoriesStore.add(mainCategory);

			var groupBy = category.groupby;
			var groupByNames = category.groupbyNames;

			if(groupBy) {
				var gbyCategories = groupBy.split(',');
				var gbyNames = groupByNames ? groupByNames.split(',') : groupBy.split(',');

				Ext.Array.each(gbyCategories, function(gbyCategory, index) {
					var newCat = Ext.create('Sbi.chart.designer.AxisesContainerModel', {
						axisName: gbyNames[index],
						axisType: 'ATTRIBUTE', 

						categoryColumn: gbyCategory,
						categoryStacked: ''
					});
					categoriesStore.add(newCat);
				});
			}
		},
		
		loadAxesAndSeries: function(jsonTemplate) {
			var leftYAxisesPanel = this.leftYAxisesPanel;
			var rightYAxisesPanel = this.rightYAxisesPanel;
			var bottomXAxisesPanel = this.bottomXAxisesPanel;
			
			Sbi.chart.designer.ChartColumnsContainerManager.resetContainers();

			var theStorePool = Sbi.chart.designer.ChartColumnsContainerManager.storePool;
			var yCount = 1;
			
			Ext.Array.each(jsonTemplate.CHART.AXES_LIST.AXIS, function(axis, index){
				if(axis.type.toUpperCase() == "SERIE"){

					var isDestructible = (yCount > 1);
					var panelWhereAddSeries = (yCount == 1) ? rightYAxisesPanel : null;
					if(axis.position.toLowerCase() == 'left') {

						var newColumn = Sbi.chart.designer.ChartColumnsContainerManager.createChartColumnsContainer(
								leftYAxisesPanel.id , '', panelWhereAddSeries, isDestructible, 
								Sbi.chart.designer.ChartUtils.ddGroupMeasure, 
								Sbi.chart.designer.ChartUtils.ddGroupMeasure, axis);
						leftYAxisesPanel.add(newColumn);

					} else {
						var newColumn = Sbi.chart.designer.ChartColumnsContainerManager.createChartColumnsContainer(
								rightYAxisesPanel.id , '', panelWhereAddSeries, isDestructible, 
								Sbi.chart.designer.ChartUtils.ddGroupMeasure, 
								Sbi.chart.designer.ChartUtils.ddGroupMeasure, axis);
						rightYAxisesPanel.add(newColumn);
						rightYAxisesPanel.show();
					}
					yCount++;

				} else if(axis.type.toUpperCase() == "CATEGORY"){
					var axisData = (axis && axis != null)? 
							Sbi.chart.designer.ChartUtils.convertJsonAxisObjToAxisData(axis) : 
								Sbi.chart.designer.ChartUtils.createEmptyAxisData();
					
					bottomXAxisesPanel.setAxisData(axisData);
				}
			});
				
			Ext.Array.each(jsonTemplate.CHART.VALUES.SERIE, function(serie, index){
				var axisAlias = serie.axis;
				Ext.Array.each(theStorePool, function(store, index){
					if(store.axisAlias === axisAlias) {

						var tooltip = serie.TOOLTIP ? serie.TOOLTIP : {};
						var tooltipStyle = serie.TOOLTIP ? serie.TOOLTIP.style : '';
						var jsonTooltipStyle = Sbi.chart.designer.ChartUtils.jsonizeStyle(tooltipStyle);
						
						var newCol = Ext.create('Sbi.chart.designer.AxisesContainerModel', {
							id: serie.id,
							axisName: serie.name,
							axisType: 'MEASURE',
							
							serieAxis: store.axisAlias,
							serieGroupingFunction: '',
							serieType: serie.type,
							serieOrderType: serie.orderType,
							serieColumn: serie.column,
							serieColor: serie.color,
							serieShowValue: serie.showValue,
							seriePrecision: serie.precision+'',
							seriePrefixChar: serie.prefixChar,
							seriePostfixChar: serie.postfixChar,
							
							serieTooltipTemplateHtml: tooltip.templateHtml,
							serieTooltipBackgroundColor: tooltip.backgroundColor,
							serieTooltipAlign: jsonTooltipStyle.align,
							serieTooltipColor: jsonTooltipStyle.color,
							serieTooltipFont: jsonTooltipStyle.font,
							serieTooltipFontWeight: jsonTooltipStyle.fontWeight,
							serieTooltipFontSize: jsonTooltipStyle.fontSize
						});
						
						store.add(newCol);
					}
				});
			});

		},
		
		update: function(jsonTemplate) {
			this.jsonTemplate = jsonTemplate;
			
			var selectedChartType = jsonTemplate.CHART.type;
			this.chartTypeSelector.setChartType(selectedChartType);
	
			this.jsonTemplateHistory.push(jsonTemplate);
			var jsonTemplateHistoryLen = this.jsonTemplateHistory.length;
			this.jsonTemplateHistoryIterator = jsonTemplateHistoryLen - 1;

			this.updateStep1Data(jsonTemplate);
			this.updateStep2Data(jsonTemplate);
		},
		
		updateStep1Data: function(jsonTemplate) {
			// Updating step 1 data
			this.loadCategories(jsonTemplate);
			this.loadAxesAndSeries(jsonTemplate);

		}, 
		
		updateStep2Data: function(jsonTemplate) {
			// Updating step 2 data
			this.cModel = 
				Sbi.chart.designer.ChartUtils.createChartConfigurationModelFromJson(jsonTemplate);

			this.cViewModel.setData({
				configModel: this.cModel
			});
		}, 
		
		exportAsJson: function() {
			// resulted json from 1st and 2nd designer steps (without properties catalogue)
			var exported1st2ndSteps = Sbi.chart.designer.ChartUtils.exportAsJson(this.cModel);
			
			// default properties catalogue by used chart library, depending on selected chart type 
    		var chartType = Sbi.chart.designer.Designer.chartTypeSelector.getChartType();
    		chartType = chartType.toLowerCase();
			var library = this.chartLibNamesConfig[chartType];
			var catalogue = propertiesCatalogue[library];
			
			// default properties catalogue by used chart library, depending on selected chart type 
			var oldJsonChartType = Sbi.chart.designer.Designer.jsonTemplate.CHART.type;
			oldJsonChartType = oldJsonChartType.toLowerCase();
			var oldLibrary = this.chartLibNamesConfig[oldJsonChartType];
			
			// last json template in memory
			var lastJsonTemplate = Sbi.chart.designer.Designer.jsonTemplate;
			
			// last json in memory with applied properties catalogue
			var appliedProperiesOnOldJson = Sbi.chart.designer.ChartUtils.mergeObjects(catalogue, lastJsonTemplate);
			
			// comparison and merge generated json template with the old one
			var overwrittenJsonTemplate = Sbi.chart.designer.ChartUtils.mergeObjects(appliedProperiesOnOldJson, exported1st2ndSteps);
			
			// add default catalogue properties in case there are new elements generated by designer
			var newJsonTemplate = (library === oldLibrary)?
				Sbi.chart.designer.ChartUtils.mergeObjects(catalogue, overwrittenJsonTemplate)
				: Sbi.chart.designer.ChartUtils.mergeObjects(catalogue, exported1st2ndSteps);
			return newJsonTemplate;
		}
    }
});