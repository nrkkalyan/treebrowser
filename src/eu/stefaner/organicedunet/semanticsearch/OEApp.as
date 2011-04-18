﻿package eu.stefaner.organicedunet.semanticsearch {	import flare.vis.data.NodeSprite;	import flare.vis.data.Tree;	import nl.demonsters.debugger.MonsterDebugger;	import org.osflash.thunderbolt.Logger;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.external.ExternalInterface;	/**	 * @author mo	 */	public class OEApp extends Sprite {		public var ontology : Tree = new Tree();		public var dataConnector : DataConnector = new DataConnector();		public var visualization : OEVisualization;		public var languageDict : LanguageDict = new LanguageDict();
		public var JSCallBack_selectionChange : String;
		public var JSCallBack_searchPointUpdate : String;		public static var mDebugger : MonsterDebugger;
		public function OEApp() {			Logger.info("App loaded");			mDebugger = new MonsterDebugger(this);			init();		}		protected function init() : void {			initStage();			initDataConnector();			getLoaderParams();			initVisualization();			dataConnector.startUp();		}		protected function initStage() : void {			//stage.scaleMode = StageScaleMode.NO_SCALE;			//stage.align = StageAlign.TOP_LEFT;
		}
		protected function initDataConnector() : void {			dataConnector.app = this;		}		protected function initVisualization() : void {		}		protected function getLoaderParams() : void {			var p : * = loaderInfo.parameters;						if(p.baseURL) {				dataConnector.BASE_URL = p.baseURL;			}						if(p.locale) {				languageDict.LOCALE = p.locale;			}						if(p.JSCallBack_selectionChange) {				JSCallBack_selectionChange = p.JSCallBack_selectionChange;			}						if(p.JSCallBack_searchPointUpdate) {				JSCallBack_searchPointUpdate = p.JSCallBack_searchPointUpdate;			}		}		protected function onNodeSelected(event : Event) : void {			Logger.info("Flash: onNodeSelected", visualization.selectedNode.data.id);			dataConnector.loadMoreData(visualization.selectedNode);			visualization.refreshView();						/*			if(JSCallBack_selectionChange) {				ExternalInterface.call(JSCallBack_selectionChange, [visualization.selectedNode.data]);			} 			 * 			 */		}		public function showLoading(loading : Boolean) : void {			//new Tween(loadingAni, 1, {visible:loading, alpha:(loading ? 1 : 0)}).play();		}		public function onOntologyLoaded() : void {			Logger.info("onOntologyLoaded");						visualization.init(ontology);			dataConnector.getInterestPoints();		}		public function onInterestPointLoaded(interestPoint : NodeSprite) : void {			Logger.info("App.onInterestPointsLoaded", interestPoint.data.id);			visualization.changeSelection(interestPoint);			if(JSCallBack_selectionChange) {				ExternalInterface.call(JSCallBack_selectionChange, [visualization.selectedNode.data]);			} 		}		public function onDataLoaded() : void {			Logger.info("onDataLoaded");			//visualization.refreshView();		}		public function createNodeSprite(nd : NodeData) : NodeSprite {			var ns : NodeSprite = new NodeSprite();			ns.data = nd;			return ns;
		}
	}}