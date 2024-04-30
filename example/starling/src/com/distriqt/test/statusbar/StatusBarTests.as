/**
 *        __       __               __
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / /
 * \__,_/_/____/_/ /_/  /_/\__, /_/
 *                           / /
 *                           \/
 * https://distriqt.com
 *
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		08/03/2024
 * @copyright	https://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.statusbar
{
	import com.distriqt.extension.statusbar.StatusBar;
	import com.distriqt.extension.statusbar.StatusBarItem;
	import com.distriqt.extension.statusbar.menu.Menu;
	import com.distriqt.extension.statusbar.menu.MenuItem;

	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	import starling.display.Sprite;

	/**
	 */
	public class StatusBarTests extends Sprite
	{
		public static const TAG:String = "";

		private var _l:ILogger;

		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}


		[Embed(source="/assets/icon.png")]
		private var Icon:Class;


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		public function StatusBarTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "StatusBar Supported: " + StatusBar.isSupported );
				if (StatusBar.isSupported)
				{
					log( "version:                " + StatusBar.service.version );
					log( "nativeVersion:          " + StatusBar.service.nativeVersion );
					log( "statusBarItemSupported: " + StatusBar.service.statusBarItemSupported );

					NativeApplication.nativeApplication.activeWindow.stage.addEventListener(
							KeyboardEvent.KEY_DOWN, keyDownHandler
					);
				}
			}
			catch (e:Error)
			{
				trace( e );
			}
		}


		////////////////////////////////////////////////////////
		//  
		//

		private var statusBarItem:StatusBarItem;

		public function createMenu():void
		{
			log( "createMenu()" );
			if (StatusBar.service.statusBarItemSupported)
			{
				var firstItem:MenuItem = new MenuItem( "test 1", "1" );
				firstItem.addEventListener( Event.SELECT, item_selectedHandler );

				var menu:Menu = new Menu();
				menu.addItem( firstItem );
				menu.addItem( new MenuItem( "test 2", "2" ) );
				menu.addItem( new MenuItem( "f d d", "fd" ) );

				statusBarItem = StatusBar.instance.createStatusBarItem();
				statusBarItem.setImage( (new Icon() as Bitmap).bitmapData );
				statusBarItem.setMenu( menu );
			}
		}


		public function addMenuItem():void
		{
			log( "addMenuItem()" );
			if (statusBarItem == null) return;
			statusBarItem.menu.addItem( MenuItem.SEPARATOR );
			statusBarItem.menu.addItem( new MenuItem( "test 2", "2" ) );
		}


		private function keyDownHandler( event:KeyboardEvent ):void
		{
			log( "keyDownHandler: " + String.fromCharCode( event.charCode ) + " (character code: " + event.charCode + ")" );
		}


		private function item_selectedHandler( event:Event ):void
		{
			log( "item_selectedHandler()" + event.currentTarget );
		}
	}
}
