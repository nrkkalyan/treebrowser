﻿package eu.stefaner.organicedunet.semanticsearch {	/**	 * @author mo	 */	public class NodeData {		public var id : String;		public var label : String;		public function NodeData(id : String, label : String = null) {			this.id = id;			this.label = label ? label : getLabelFromID(id);		}		private function getLabelFromID(id : String) : String {			return id.split("#")[1] || "root";		}	}}