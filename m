Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3148E2DF7B7
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Dec 2020 03:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLUCpr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 20 Dec 2020 21:45:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:11438 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLUCpq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 20 Dec 2020 21:45:46 -0500
IronPort-SDR: Py71TY7MlboVXUvAeAPXLf55hAwCVpoNx1YeiAxsXWQ/uf4fTON3EVkPs57hbDA+qsVBDSE9vk
 jpy4CbOFzSEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="239758217"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="239758217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 18:45:04 -0800
IronPort-SDR: xU+HjV6XKATRs9WPGxsDdoEbSR6gVwtPi1H5uC4veHnK8x64PbFP5mCvBRyk58jXZGPecbToh8
 EHcY9vUCWZtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="455787890"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2020 18:45:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Dec 2020 18:45:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Dec 2020 18:45:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 20 Dec 2020 18:45:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+5Ks88psd+szG4cIjcq3PayH6ArszprVAIrrhjfDui3XQnqQ6ToSC2cxVjCI4tLledvv2H9+tC+hqIKaSY7fVKG1A1Hl0jJDgK+5WtfZYkEfWvBxteCPLqvFb/CoLLIx7lwrYHqaS7YGJiR1Nuxsgku4euMKVlNFGCkHB/xQOS+0Gmm2MtrhAGFFQb30BBbbVED+Gca99mK+qjbIoWvg6DGSDn+asIJy0+GveF50ZO41WNFZ+QcExr6tlVOSFRWJn0PkmIwM2AGPwd0UwbNL+hxqmBMeQCAmxXOrrNh0enZQONiH/DXKf/ytxo0YLJehePv1A9GQtocPNvHzcvcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufVv7RVrsZSGG+zUO5OewjXgg1fTNsRtPBdNoCGvbJc=;
 b=ZGm+bK9eo4A8HRJum/IIwvKUsDF05XAjR30QW0KsqWNfnulolVCv/75kc3kRArhh1bJzLkr6SpmkKpKoO2yVDJjzTO+WOTdwQyUryeZ0rAeCoJ1duw/SvYqc4EXrfol+A8i5mZsZIKGvHKOkCVdJ+FIDEDk+tM73wGyker4rYOXHVSUnDAYsHM501MQ975dRcX4zD2V9HqbtpzEERkjVScwxGKzkuq/R6ZAK4I85XN3+rE6LVfUSe7gilvFPhm6HGMOJ391SWDmGsf0DJY5e3H2EUdacXZDRvuVrgFcJPGCct9uB6e6BacJVsu2ows7f/fvnPgssBgoicuFl+mCwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufVv7RVrsZSGG+zUO5OewjXgg1fTNsRtPBdNoCGvbJc=;
 b=RbacTxIJSGv8UYq4AKrlN5CH53NH9ewadWMzDDgsEqpCsTrXrtzcBrcERr9RWN/Qt355cv2zTFWlihuDNthCEQZaPtWgnztWw0AbZH84nH4u8VpLDS2fcjjF/buAM8Br5tfOB+mkU53kgMKoxgHLJjOG7gGToCOsHOh8BbZT0x0=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3817.namprd11.prod.outlook.com (2603:10b6:5:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 02:44:59 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 02:44:58 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Topic: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Index: AQHW1DhiFXQvRNubJU6hP8U7m1i7W6n8ewGggABogYCAA/gPMA==
Date:   Mon, 21 Dec 2020 02:44:58 +0000
Message-ID: <DM6PR11MB38194D88C20FDFC33CC5BDDB85C00@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
 <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
In-Reply-To: <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743636b0-91c1-4c62-dce9-08d8a55a6853
x-ms-traffictypediagnostic: DM6PR11MB3817:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB381716BD9C7383A0BCAD260785C00@DM6PR11MB3817.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdcgO/+XYLYcA/VEXM1s1JumhK0pkNusAx2tPQEqK/tcEanq4LKaboH/QSCPkP589l/zJqHkEEzi5GbV+HEYQOrlo1nVqaSm4R41sgjuKsr9ZueUfha6QYAeLfZQc6JNiNBi9GTzI5UT2qXZwRuxXfl9tiGHHM86+cqHbylmHv+R+WoR6ephtwY3mJYkh8RNdWlsz9GCYJI9PuBiBeT+A1hOZmaYVTGuiQD3GoYJI9p8Hl1bHmxniZCrvDJe92cKiM3HI3B/5uYMwRhrA49YrxNxJrtGxPw3V9/64gau/Y+UdXK3XswuqzSqdRjbLP5izy0NQ77Q0u3exJ18tTqZk8wjWJGNim3fjvmOgRPIxobvqU5Mew8EYzjXs8mbIrIo8BP7EDCBxpNbuJYkrETwYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(33656002)(316002)(76116006)(8936002)(2906002)(52536014)(83380400001)(53546011)(478600001)(110136005)(5660300002)(54906003)(6506007)(71200400001)(7696005)(86362001)(8676002)(9686003)(26005)(4326008)(186003)(66446008)(66476007)(66556008)(64756008)(55016002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cEJNQ2xzbGY1ZmR6MjhBK1FtaG5ZWFBVVzg2L0kxVllzM21qa09wcHdBV1ZG?=
 =?utf-8?B?OFV0SnZsVjdvdUovd1lKTVZGTmlpbUZBSXlOQzViUHB4bG1HY3k1ZGpEdWRm?=
 =?utf-8?B?S3hVWmNsMUgwalFQQ2ZuMkZSM3p0WkhwS2RjMDRQL0FEb2FBcGQ5dVZzeUF6?=
 =?utf-8?B?Y0NRMUZHOStqdFMwL01UakFHTGY0WWlHUThGdTZNVkdFenplVWE3MGp0MDdE?=
 =?utf-8?B?WUhGTGxub2pocEtydWtkT1RmSWJZQ3o2VU50NFVlUWQzb25Fem5OdGZveE9C?=
 =?utf-8?B?VW53bUhRTHRYS0p4NFAxamx6SkRobSt1TFYzcEU5amJIR1pQMldGQXVGUDhH?=
 =?utf-8?B?N3pqSm5EcXdjZTJOS0h3S2NRMlpxQVhCOFB0ZGZySkZtWWRVcUxLOXI0bFNG?=
 =?utf-8?B?RWVvTm5RWncwT3BKZWtxUzlDalJxbTgxblJ2dnVOL04yQUJHTFdYZ3IxRDho?=
 =?utf-8?B?dHQrb1hqVGFIUTJKTjc1WFRjeHZQUlZwWWFnZzdlRWRVRUtwL3JFZG8yNWd2?=
 =?utf-8?B?MDlPKzJIRUlGSXdVaUVjMEtpQkVaSVRZZmUzOHRHbmRLSThyU1dvazVlZnlQ?=
 =?utf-8?B?cU53Z2JFcWx1UmhRdWYwOElzY3JzN1ZPd0ZyM21mUncvQ0FaQlh5V0k1ZVV0?=
 =?utf-8?B?ZlFoMjRVSEdPS3MxQlVqYUdsQ2M5azJKRC9pTFlnOThhcFBHOUljUGt0ZGZV?=
 =?utf-8?B?SGZyYUEzTGYxK0JpV2pZTjRodFRDSnpndXFISnRCWlc5ajJUeVovU1FPWVpu?=
 =?utf-8?B?UThZbHI3QWhmVnlDYU9hZWxUcVlQWHY4RWJEa0JsWmZXczJLdllvc2kwcVdn?=
 =?utf-8?B?YzhMSGw4dEgrdjlFMzdrNk9VQ1JaYi9ycHBrRDlpa25vbTVDSmtockFHQVZV?=
 =?utf-8?B?Q2w3OUFNMzc3a2hwOGRtT2FNTThqbTllYXFRdDNWR09xTzVjSENBVzdaK2Uw?=
 =?utf-8?B?amxjS3JYSWZmMmxmK2FWNGp0aHphTllIcVk4M0lsa0J5VUxKRGU2cW1MblJC?=
 =?utf-8?B?TDZQNzlWaXdjYUkrclNpM3lqQjRFaHkzWTZpdGU1M0YvTjcyQmJBOHF2SzRX?=
 =?utf-8?B?NFV2UmlEWVk5ZElBRjBNc2k1S1V0NGNvWU0zNkx0dEoyWWFSUHYzRE9vRWt5?=
 =?utf-8?B?a0EzYUZiSXF0bXNnbnlnMjZlaHBqSG5HemxlNmNobGpZWjZMZlp4MTVOY2ll?=
 =?utf-8?B?QTJPYzQ4cUJCMW9qVUtMZ3Q0SlFJd1UwbUNFWEpXNk5qYWlSUlMvWWpaYktH?=
 =?utf-8?B?U1gvaURvaCs4KzJha0Vqc0dhOWFRQ0Mzck0rV3UwNVo5cldtcUdVcktScUJS?=
 =?utf-8?Q?cnBTwBY0NAlBE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743636b0-91c1-4c62-dce9-08d8a55a6853
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 02:44:58.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Spg7n5r4O5VVN4ZeTbHTGaZgE2TDyy7KVJhvyoLsjN2U7dEcT6pAO2LnInegOnPOM1Be/V0S2nM6F98HUBPlRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3817
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSBmcGdhOiBkZmw6IGFkZCB0aGUgdXNlcnNw
YWNlIEkvTyBkZXZpY2Ugc3VwcG9ydA0KPiBmb3IgREZMIGRldmljZXMNCj4gDQo+IE9uIDEyLzE4
LzIwIDEyOjA1IEFNLCBXdSwgSGFvIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMi8z
XSBmcGdhOiBkZmw6IGFkZCB0aGUgdXNlcnNwYWNlIEkvTyBkZXZpY2Ugc3VwcG9ydA0KPiBmb3IN
Cj4gPj4gREZMIGRldmljZXMNCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBzdXBwb3J0cyB0aGUgREZM
IGRyaXZlcnMgYmUgd3JpdHRlbiBpbiB1c2Vyc3BhY2UuIFRoaXMgaXMNCj4gPj4gcmVhbGl6ZWQg
YnkgZXhwb3NpbmcgdGhlIHVzZXJzcGFjZSBJL08gZGV2aWNlIGludGVyZmFjZXMuDQo+ID4+DQo+
ID4+IFRoZSBkcml2ZXIgbGV2ZXJhZ2VzIHRoZSB1aW9fcGRydl9nZW5pcnEsIGl0IGFkZHMgdGhl
IHVpb19wZHJ2X2dlbmlycQ0KPiA+PiBwbGF0Zm9ybSBkZXZpY2Ugd2l0aCB0aGUgREZMIGRldmlj
ZSdzIHJlc291cmNlcywgYW5kIGxldCB0aGUgZ2VuZXJpYyBVSU8NCj4gPj4gcGxhdGZvcm0gZGV2
aWNlIGRyaXZlciBwcm92aWRlIHN1cHBvcnQgdG8gdXNlcnNwYWNlIGFjY2VzcyB0byBrZXJuZWwN
Cj4gPj4gaW50ZXJydXB0cyBhbmQgbWVtb3J5IGxvY2F0aW9ucy4NCj4gPj4NCj4gPj4gVGhlIGRy
aXZlciBtYXRjaGVzIERGTCBkZXZpY2VzIGluIGEgZGlmZmVyZW50IHdheS4gSXQgaGFzIG5vIGRl
dmljZSBpZA0KPiA+PiB0YWJsZSwgaW5zdGVhZCBpdCBtYXRjaGVzIGFueSBERkwgZGV2aWNlIHdo
aWNoIGNvdWxkIG5vdCBiZSBoYW5kbGVkIGJ5DQo+ID4+IG90aGVyIERGTCBkcml2ZXJzLg0KPiA+
IExvb2tzIGxpa2Ugd2Ugd2FudCB0byBidWlsZCBVSU8gZHJpdmVyIGFzIHRoZSBkZWZhdWx0L2dl
bmVyaWMgZHJpdmVyIGZvciBERkwsDQo+ID4gaXQgc2VlbXMgZmluZSBidXQgbXkgY29uY2VybiBp
cyB0aGF0IFVJTyBoYXMgaXRzIG93biBsaW1pdGF0aW9uLCBpZiBzb21lIGRheSwNCj4gPiBkZmwg
ZGV2aWNlIGlzIGV4dGVuZGVkLCBidXQgVUlPIGhhcyBsaW1pdGF0aW9uLCB0aGVuIHdlIG1heSBu
ZWVkIHRvIHNlbGVjdA0KPiA+IGFub3RoZXIgb25lIGFzIHRoZSBkZWZhdWx0IGRyaXZlci4uIG9y
IHdlIGNhbiBqdXN0IG1hdGNoIHRoZW0gdXNpbmcNCj4gPiBpZF90YWJsZSBhcyB3ZSBrbm93IFVJ
TyBtZWV0cyB0aGUgcmVxdWlyZW1lbnQgZm9yIHRob3NlIERGTCBkZXZpY2VzPw0KPiANCj4gV2hl
biB3ZSBoYXZlIG11bHRpcGxlIGRlZmF1bHRzLCBjb3VsZCB0aGlzIGJlIGhhbmRsZWQgaW4gdGhl
IGNvbmZpZ3VyeSA/DQoNCkRvIHlvdSBtZWFuIHNlbGVjdCBpdCB1c2luZyBjb25maWd1cmF0aW9u
IG9wdGlvbnM/IEJ1dCBpZiBwZW9wbGUgaGF2ZSBhbHJlYWR5DQpjcmVhdGVkIHRoZSBzb2Z0d2Fy
ZSBzdGFjayBvbiB0aGUgb2xkIG9uZSwgdGhlbiBpdCdzIGEgdmFsaWQgcmVxdWlyZW1lbnQgdGhh
dA0Kd2UgbmVlZCBib3RoIG9sZCBhbmQgbmV3IGRlZmF1bHRzIHdvcmtpbmcgYXQgdGhlIHNhbWUg
dGltZS4uLiBpdCdzIGhhcmQgdG8NCmFzayBldmVyeWJvZHkgdG8gc3dpdGNoIHRvIHRoZSBuZXcg
b25lLg0KDQpIYW8NCg0KPiANCj4gVG9tDQo+IA0K
