package firmament.component.event;

import firmament.component.base.FEntityComponent;
import firmament.core.FEntityCollection;
import firmament.core.FEntity;
import firmament.core.FGame;
import firmament.core.FVector;
import firmament.event.FEventRelayEvent;
import firmament.filter.entity.FEntityFilterFactory;
import firmament.filter.entity.FEntityFilterInterface;
import firmament.util.FConfigHelper;
import firmament.util.FMisc;
import firmament.core.FEvent;

class FEventRelayComponent extends FEntityComponent{

	var _eventsToFire:Array<String>;
	var _fireEvent:String;

	public function new(){
		super();
	}

	override public function init(config:Dynamic){
		_config = config;
		var ch = new FConfigHelper(config);

		var events:Array<String> = ch.getNotNull("listenEvents",Array);
		for(e in events){
			on(_entity,e,eventFired);
		}
		
		_fireEvent = ch.getNotNull("fireEvent");

	}

	override public function getType(){
		return "eventRelay";
	}

	private function eventFired(e:FEvent){
		var c = FMisc.deepClone(_config);
		c['point'] = _entity.getPhysicsComponent().getPosition();
		if(Reflect.isObject(c['topLeft'])){
			c['topLeft'] = new FVector(c['topLeft.x'] + c['point.x'],c['topLeft.y']+c['point.y']);
		}

		if(Reflect.isObject(c['bottomRight'])){
			c['bottomRight'] = new FVector(c['bottomRight.x'] + c['point.x'],c['bottomRight'].y+c['point'].y);
		}

		var entities:FEntityCollection = FGame.getInstance().queryEntities(c);
		
		for (ent in entities){
			ent.trigger(new FEventRelayEvent(_fireEvent,_entity,_config));
		}

	}
}











































