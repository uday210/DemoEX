/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
/**
 * The ConnectApps list resource shows all of the Connect Apps that you have
 * created within your Twilio account. The instance resource shows you the
 * permissions you are requesting for a single Connect App as well as
 * information about the Connect App itself.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/connect-apps
 */
global class TwilioConnectAppList extends TwilioResource.ListResource
	implements Iterable<TwilioConnectApp> {

	/**
	 * Instantiates a new ConnectApp list.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioConnectAppList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new ConnectApp list.
	 * 
	 * @param client
	 *            the client
	 * @param filters
	 *            the filters
	 */
	public TwilioConnectAppList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/ConnectApps.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client, Map<String, Object> params) {
		return new TwilioConnectApp(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'connect_apps';
	}
	
	/* returns the current response results page */
	public List<TwilioConnectApp> getPageData() {
		List<TwilioConnectApp> returnList = new List<TwilioConnectApp>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioConnectApp) {
				returnList.add((TwilioConnectApp) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioConnectApp> iterator() {
		return new TwilioIterator.ConnectAppIterator(this);
	}

}