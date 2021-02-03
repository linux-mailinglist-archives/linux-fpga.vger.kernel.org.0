Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0430D656
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Feb 2021 10:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBCJai (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 04:30:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:38286 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBCJ3I (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 04:29:08 -0500
IronPort-SDR: afN0LEAh+Vgq2NwmANvNJGeurDKVqorEqXX+yx23juu0nPzqe7vGw4j53p37YJaZ7+1KP3hksH
 AN97lpEBYa2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160773883"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="160773883"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:28:27 -0800
IronPort-SDR: UBqq/FX4vSP/48xx7HOF6l9P3j7cRTJ/FZtsjchgIUN9kdgJsNRNqILbYH9VZhqT+h6MPyRCVE
 bTLoeT8uLnIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="582512460"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2021 01:28:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 01:28:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 01:28:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 01:28:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXIQ7K8wSJFiNwKTdHQegO7wlzecFihhVacOMNknfAXka1FhflqNYgtlskjmO6NN/rMIS2QQiJgwcfwzNiH90BT7Tp4WtdmkpQU5MYothT2vxyniI8lt7diZFAbdgpeqnN8pwu8RrOAKKdN7isKOMHqTXRG/l5t59leWysi3+KJsg9WZNv3f+CG3gdqj15eXTMahyRt0vWgaYQK38ItkaIwfzME851hYNrzSYVL1nhPDxjxd4gfggnXtvo0k/a95v7v84lYGql8n+GevuR0RttIbN4uDZJnNmEyFSOZ8FsWVt+wh0Kl4brwO6AyaktxBFVLy/WSADQX5M9N8Ao66IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUboJMSiaXEFkbLeGMoLg0hVEWBMnKYSXYH+vx2dpHQ=;
 b=G/gJ2UmD3WtXP1PzdbMfkRZcJyguzorG/1FjfRETyb55iSnsq/TUz7ASWE/fBU2ew+NBRoHtdDRzffqA3iXnhjQq0oqOBOZ2CGz8/fIPD+kbrkrO+0jaMaE4jBZy3Go75DQ1s8WLGb+/sfk7R10iEMXHGtmHH0Q4YoZMEbhPUqq2eL5kaUljRrEFB31Er9xULwkxFJSw3sdDNtgcm7PC01qQzBevwTVBPq/Zf4w8r+9Su6ZqTZOiHhjdFzvp8PDi4qV/yd4+FhRuWUaD0KwtolTwX63VbXAplZ8/95dFnnTvR3ph8wRy123oIJjn45lupS9xxNy8mLkB/EwyC7G/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUboJMSiaXEFkbLeGMoLg0hVEWBMnKYSXYH+vx2dpHQ=;
 b=fHaYr/G7cye0S1tWPLy3vOT757lLVpAq9nRn5TBvVWF2z8rfs9LlNS9qaJxNNFmGVSCCEdDrYbNs+E2dcm6W72EEjDHzM8f74MOK6TdF+jAUeVCwuGgx9NnV27T9oTaIJnOmeVk2IOxn3cZRkgeRuwTH0gsSTWw22cx5dVI3ccA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3914.namprd11.prod.outlook.com (2603:10b6:5:197::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.26; Wed, 3 Feb
 2021 09:28:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 09:28:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHWjSD4LeMXUYhU00yzPOyYE3T3saltlsAAgNiPhQCAANXVMA==
Date:   Wed, 3 Feb 2021 09:28:21 +0000
Message-ID: <DM6PR11MB3819BC4BFE16A9CBE185EB1185B49@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com>
In-Reply-To: <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51fcc212-803c-45d7-dc95-08d8c8260c6e
x-ms-traffictypediagnostic: DM6PR11MB3914:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39145CE88E85705ECE02C55485B49@DM6PR11MB3914.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxPzqSzQBPfXqEY8HXqj6jom4f0AJHfB9rEoTXKD9T+bEKML1mks0Hp1vJHrkjwwlGPIudGew15Y3FaBJFFWWRNyITRV7WvaZ2WEgpt6Vzpmc+RewtgWEEHKiWMZqFCAdtt8xvgMIei/I9OlWaPF990L0LEQgds7toIKgqRr4AJ4/EYeDrXJ023rhbr7+FSiPfY65FDGPdftOizL0I0M2y7NMa9It5WSGpH1jdyXG1gfTiXvbNtMHPLl1s0Y3VzOQ40eBNwALvTwgg7x52tOITyVDwIAyXHFJbIaNmsCFF4E/oEL+u4irRZk3Oy6wQE5IRscLFsFbfhgXnt1Cka5BCB47e+0bhxVf3ezVcoo7uLHo1xUie4jcEcoKOEyLsDOgh8Yas8tFvkUT/FgcIuGUAu28u+t32SK5bsfcLtxGmAtkjaZqtUIMBPU9TQ52QyIf8ePkVB9HlaQTH7TNs98jeYVlgF3iEpExMYVa/I6pjaA0xv4TlkKWRs1UgoCPLERywrbSSBRbmOyHZNfJfZcfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(7696005)(76116006)(8936002)(33656002)(2906002)(83380400001)(53546011)(107886003)(66446008)(66476007)(64756008)(26005)(4326008)(71200400001)(6506007)(66556008)(66946007)(55016002)(478600001)(86362001)(110136005)(19627235002)(52536014)(54906003)(9686003)(8676002)(5660300002)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UlJma1k0OWtWMTRQWUlmRVVTM2FwV2R6SXY0eUIvaEpFVnN3bVZWbnRVMVVF?=
 =?utf-8?B?MlVsUTVScm5wc1N3TkM0V0tCMjdNQXNRZDFzdVZQK3l3Tkw5WWF0TkNkSFVR?=
 =?utf-8?B?QXo4ZjAxTDRTbmxaSGkyNDFUVDJEWnBsS3hubzJtMGREWXlCVFpuaW5Wb0No?=
 =?utf-8?B?NHUyYmhyVzNTY0JaS2ZyWW9KeHJxS2IzMEZMSS9DVWxnUGcxVHRYZ0hDVlU0?=
 =?utf-8?B?VThZL1psVk9VQ0toOHNBVWV5c3hpN2ZIMVZPY0ZpTXFJemsrTzMwL1hYekF6?=
 =?utf-8?B?aXpSYWhxcTNWQm9nQUdxN0tKVWZjL3pXWUZXVDhYNENyNGFLQklNUStkWG1C?=
 =?utf-8?B?YmdGVG54QTN1RnlRZHljeDM3d0VEYy9xRkNpNHV5RTJXWDZOMW90aUZEeGVq?=
 =?utf-8?B?RElIN0d0R3RRL2t4L2orK1VrNTZTb0NEQ0REWGl0VjNjM0NZcWlWWVVtNzlC?=
 =?utf-8?B?dkJaQ2wzS0tYcVhZMFgrNXdJa0hhOVpJNEIxUHRGZlIzMzdHSGpsa3BwOTVh?=
 =?utf-8?B?UnhEaGNJK0RESWpxRytZMm12ZnFLR25iUDMydmpYeFQ5RW9MODgzVlVlQVpI?=
 =?utf-8?B?aW1uRHI0RmF2RDltQ1NReHdPU3VveEtXSkQ3cFJzREk1VVE4aHRxYnR2UmtC?=
 =?utf-8?B?WGR1NERYc1F4U3k5SjloY3lvbUxmTDVzbXArUmtLRWhoVUIzeWYrcnZsblQr?=
 =?utf-8?B?ZkdCa1hEZGkrOGw0RzNra1MyUngwblA5cVlYVUJ1akZneFk5dm9tMWplbS9E?=
 =?utf-8?B?Y2l4VHhNVTRBZmM5Wk9SVE9GbEJXVjZ4N3ZYMVhzRVZESkhpVElvMWNRRW9n?=
 =?utf-8?B?QVcxOG9Ldk0xbVFPNlVLUjh4VjYwU2U5UEhtQlVxQlo0YmJrOHllZnJyRUNW?=
 =?utf-8?B?Nmp4bzBnOE8vbXZsVmtvV1F6SnVUQXhMeE5GMjlVaVoxZTRKTXY5ZFY0ZXgy?=
 =?utf-8?B?R2tFWXU4c3FvZkFMUWNIbmtVYkgwODR3VWR0UFRxd2RaMjQyYmQ0WldBNk1O?=
 =?utf-8?B?WlVjQTAvR3RCKy8rU0NoTVNKQnQyNStkY0dKUExOUS9SUDBiME9KSmhnYmhM?=
 =?utf-8?B?d0t3dnZzQVBLWlUxQk91SlJ4R3hqTkxzRWtEWHZOYzQ2NVk1Q1kyelZyMGJ6?=
 =?utf-8?B?U2E5UXc1N3VHUFB5OHNWdVpTY2RIQ2E2VE83V1pGbVE4UnJUZGJ5RUNlTGsr?=
 =?utf-8?B?Y3FuWFNwd2tZY3B1VTNxS1I4ajRhTm9WYzNlNThRWSt2S3RnS2tCb0pFb1JL?=
 =?utf-8?B?d3dkRlVUQWhTVnBHSzhwMXE2c3ViWDQ2MXBkaXpRRmVjcDZQb0xhdGpHVVBQ?=
 =?utf-8?B?OVhCbkd0RktFOVA2dnQzdFJ0OU1zMWVpSUREcFl4VHZnQU5KM1lRNWp2eHVy?=
 =?utf-8?B?QWpkTFM2SUcrd3BJWmluVGl1cDZBN2c2YUU0T2NDVzN1WU1SZHNVTUhxeThh?=
 =?utf-8?Q?YRZpC6TQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fcc212-803c-45d7-dc95-08d8c8260c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 09:28:21.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLym7/PmqwyzYN8HYn/t8IDdGVkan24Lp9y0c+tkc+Zp7MTIA5JfLrRs+KPmE3S4k2O/H+4Nld/H0aufdZfwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3914
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMV0gZnBnYTogZGZsOiBhZnU6IGhhcmRlbiBwb3J0
IGVuYWJsZSBsb2dpYw0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheSBvbiB0aGlzIHBhdGNoLiBJ
dCBzZWVtZWQgbGlrZSBhIGxvd2VyIHByaW9yaXR5IHBhdGNoIHRoYW4NCj4gb3RoZXJzLCBzaW5j
ZSB3ZSBoYXZlbid0IHNlZW4gYW55IGlzc3VlcyB3aXRoIGN1cnJlbnQgcHJvZHVjdHMuIFBsZWFz
ZSBteQ0KPiByZXNwb25zZXMgaW5saW5lLg0KPiANCj4gT24gOS8xNy8yMCA3OjA4IFBNLCBXdSwg
SGFvIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBS
dXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDE4LCAyMDIwIDI6MzIgQU0NCj4gPj4gVG86IG1kZkBrZXJuZWwub3JnOyBs
aW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gPj4gQ2M6IHRyaXhAcmVkaGF0LmNvbTsgbGdvbmNhbHZAcmVkaGF0LmNvbTsgWHUs
IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+Ow0KPiA+PiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwu
Y29tPjsgR2VybGFjaCwgTWF0dGhldw0KPiA+PiA8bWF0dGhldy5nZXJsYWNoQGludGVsLmNvbT47
IFdlaWdodCwgUnVzc2VsbCBIDQo+ID4+IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4g
Pj4gU3ViamVjdDogW1BBVENIIHYyIDEvMV0gZnBnYTogZGZsOiBhZnU6IGhhcmRlbiBwb3J0IGVu
YWJsZSBsb2dpYw0KPiA+Pg0KPiA+PiBQb3J0IGVuYWJsZSBpcyBub3QgY29tcGxldGUgdW50aWwg
QUNLID0gMC4gQ2hhbmdlDQo+ID4+IF9fYWZ1X3BvcnRfZW5hYmxlKCkgdG8gZ3VhcmFudGVlIHRo
YXQgdGhlIGVuYWJsZSBwcm9jZXNzDQo+ID4+IGlzIGNvbXBsZXRlIGJ5IHBvbGxpbmcgZm9yIEFD
SyA9PSAwLg0KPiA+IFRoZSBkZXNjcmlwdGlvbiBvZiB0aGlzIHBvcnQgcmVzZXQgYWNrIGJpdCBp
cw0KPiA+DQo+ID4gIiBBZnRlciBpbml0aWF0aW5nIGEgUG9ydCBzb2Z0IHJlc2V0LCBTVyBzaG91
bGQgbW9uaXRvciB0aGlzIGJpdC4gSFcNCj4gPiB3aWxsIHNldCB0aGlzIGJpdCB3aGVuIGFsbCBv
dXRzdGFuZGluZyByZXF1ZXN0cyBpbml0aWF0ZWQgYnkgdGhpcyBwb3J0DQo+ID4gaGF2ZSBiZWVu
IGRyYWluZWQsIGFuZCB0aGUgbWluaW11bSBzb2Z0IHJlc2V0IHB1bHNlIHdpZHRoIGhhcw0KPiA+
IGVsYXBzZWQuICINCj4gPg0KPiA+IEJ1dCBubyBkZXNjcmlwdGlvbiBhYm91dCB3aGF0IHRvIGRv
IHdoZW4gY2xlYXJpbmcgYSBQb3J0IHNvZnQgcmVzZXQNCj4gPiB0byBlbmFibGUgdGhlIHBvcnQu
DQo+ID4NCj4gPiBTbyB3ZSBuZWVkIHRvIHVuZGVyc3RhbmQgY2xlYXJseSBvbiB3aHkgd2UgbmVl
ZCB0aGlzIGNoYW5nZQ0KPiA+IChlLmcuIHdoYXQgbWF5IGhhcHBlbiB3aXRob3V0IHRoaXMgY2hh
bmdlKSwgYW5kIHdpbGwgaXQgYXBwbHkgZm9yIGFsbA0KPiA+IGV4aXN0aW5nIERGTCBkZXZpY2Vz
IGFuZCBmdXR1cmUgb25lcywgb3IganVzdCBmb3Igb25lIHNwZWNpZmljIGNhcmQuDQo+ID4gQ291
bGQgeW91IHBsZWFzZSBoZWxwPyA6ICkNCj4gSSB0b3VjaGVkIGJhc2VzIHdpdGggdGhlIGhhcmR3
YXJlIGVuZ2luZWVycy4gVGhlIHJlY29tbWVuZGF0aW9uIHRvIHdhaXQNCj4gZm9yIEFDSyB0byBi
ZSBjbGVhcmVkIGlzIG5ldyB3aXRoIE9GUyBhbmQgaXMgZG9jdW1lbnRlZCBpbiB0aGUgbGF0ZXN0
DQo+IE9GUyBzcGVjaWZpY2F0aW9uIGFzIGZvbGxvd3MgKHNlZSBzdGVwICM0KToNCj4gDQo+ID4g
My43LjEgQUZVIFNvZnQgUmVzZXRzDQo+ID4gU29mdHdhcmUgbWF5IGNhdXNlIGEgc29mdCByZXNl
dCB0byBiZSBpc3N1ZWQgdG8gdGhlIEFGVSBhcyBmb2xsb3dzOg0KPiA+IDEuIEFzc2VydCB0aGUg
UG9ydFNvZnRSZXNldCBmaWVsZCBvZiB0aGUgUE9SVF9DT05UUk9MIHJlZ2lzdGVyDQo+ID4gMi4g
V2FpdCBmb3IgdGhlIFBvcnQgdG8gYWNrbm93bGVkZ2UgdGhlIHNvZnQgcmVzZXQgYnkgbW9uaXRv
cmluZyB0aGUNCj4gPiBQb3J0U29mdFJlc2V0QWNrIGZpZWxkIG9mIHRoZSBQT1JUX0NPTlRST0wg
cmVnaXN0ZXIsIGkuZS4NCj4gUG9ydFNvZnRSZXNldEFjaz0xDQo+ID4gMy4gRGVhc3NlcnRpbmcg
dGhlIFBvcnRTb2Z0UmVzZXQgZmllbGQNCj4gPiA0LiBXYWl0IGZvciB0aGUgUG9ydCB0byBhY2tu
b3dsZWRnZSB0aGUgc29mdCByZXNldCBkZS1hc3NlcnRpb24gYnkgbW9uaXRvcmluZw0KPiB0aGUN
Cj4gPiBQb3J0U29mdFJlc2V0QWNrIGZpZWxkIG9mIHRoZSBQT1JUX0NPTlRST0wgcmVnaXN0ZXIs
IGkuZS4NCj4gUG9ydFNvZnRSZXNldEFjaz0wDQo+ID4NCj4gPiBUaGlzIHNlcXVlbmNlIGVuc3Vy
ZXMgdGhhdCBvdXRzdGFuZGluZyB0cmFuc2FjdGlvbnMgYXJlIHN1aXRhYmx5IGZsdXNoZWQgYW5k
DQo+ID4gdGhhdCB0aGUgRklNIG1pbmltdW0gcmVzZXQgcHVsc2Ugd2lkdGggaXMgcmVzcGVjdGVk
LiBGYWlsaW5nIHRvIGZvbGxvdyB0aGlzDQo+ID4gc2VxdWVuY2UgbGVhdmVzIHRoZSBBRlUgaW4g
YW4gdW5kZWZpbmVkIHN0YXRlLg0KPiANCj4gVGhlIE9GUyBzcGVjaWZpY2F0aW9uIGhhcyBub3Qg
YmVlbiBwb3N0ZWQgcHVibGljbHksIHlldC4NCj4gDQo+IEFsc28sIHRoaXMgaXMgaG93IGl0IHdh
cyBleHBsYWluZWQgdG8gbWU6DQo+IA0KPiA+IEluIG1vc3Qgc2NlbmFyaW8sIHBvcnQgd2lsbCBi
ZSBhYmxlIHRvIGdldCBvdXQgb2YgcmVzZXQgc29vbiBlbm91Z2gNCj4gPiB3aGVuIFNXIHJlbGVh
c2VzIHRoZSBwb3J0IHJlc2V0LCBlc3BlY2lhbGx5IG9uIGFsbCB0aGUgUEFDIHByb2R1Y3RzDQo+
ID4gd2hpY2ggaGF2ZSBiZWVuIHZlcmlmaWVkIGJlZm9yZSByZWxlYXNlLg0KPiA+DQo+ID4gUG9s
bGluZyBmb3IgSFcgdG8gY2xlYXIgdGhlIEFDSyBpcyBtZWFudCB0byBoYW5kbGUgdGhlIGZvbGxv
d2luZyBzY2VuYXJpb3M6DQo+ID4NCj4gPiAgICogRGlmZmVyZW50IHBsYXRmb3JtIGNhbiB0YWtl
IHZhcmlhYmxlIHBlcmlvZCBvZiB0aW1lIHRvIGdldCBvdXQgb2YgcmVzZXQNCj4gPiAgICogQnVn
IGluIHRoZSBIVyB0aGF0IGhvbGQgdGhlIHBvcnQgaW4gcmVzZXQNCj4gDQo+IFNvIHRoaXMgY2hh
bmdlIGlzIG5vdCByZXF1aXJlZCBmb3IgdGhlIGN1cnJlbnRseSByZWxlYXNlZCBQQUMgY2FyZHMs
DQo+IGJ1dCBpdCBpcyBuZWVkZWQgZm9yIE9GUyBiYXNlZCBwcm9kdWN0cy4gSSBkb24ndCB0aGlu
ayB0aGVyZSBpcyBhbnkgcmVhc29uDQo+IHRvIGhvbGQgb2ZmIG9uIHRoZSBwYXRjaCwgYXMgaXQg
aXMgc3RpbGwgdmFsaWQgZm9yIGN1cnJlbnQgcHJvZHVjdHMuDQoNCkFzIHlvdSBrbm93LCB0aGlz
IGRyaXZlciBpcyB1c2VkIGZvciBkaWZmZXJlbnQgY2FyZHMsIGFuZCB3ZSBuZWVkIHRvIG1ha2UN
CnN1cmUgbmV3IGNoYW5nZXMgaW50cm9kdWNlZCBpbiBuZXcgdmVyc2lvbiBzcGVjLCBkb24ndCBi
cmVhayBvbGQgcHJvZHVjdHMNCmFzIHdlIGFyZSBzaGFyaW5nIHRoZSBzYW1lIGRyaXZlci4gYW5k
IHdlIGFyZSBub3Qgc3VyZSBpZiBpbiB0aGUgZnV0dXJlIHNvbWUgDQpuZXcgcHJvZHVjdHMgYnV0
IHN0aWxsIHVzZXMgb2xkIHNwZWNzLCBhbmQgdGhlbiB0aGluZ3MgbWF5IGJlIGJyb2tlbiBpZiB0
aGUNCmRyaXZlciB3aGljaCBhbHdheXMgcGVyZm9ybSBuZXcgZmxvdy4gQW5vdGhlciBtZXRob2Qg
aXMgdGhhdCBpbnRyb2R1Y2UgMSANCmJpdCBpbiBoYXJkd2FyZSByZWdpc3RlciB0byB0ZWxsIHRo
ZSBkcml2ZXIgdG8gcGVyZm9ybSB0aGUgYWRkaXRpb25hbCBzdGVwcywgDQp0aGVuIGl0IGNhbiBh
dm9pZCBpbXBhY3RzIHRvIHRoZSBvbGQgcHJvZHVjdHMuIElmIHRoaXMgY2FuJ3QgYmUgZG9uZSwg
dGhlbg0Kd2UgYXQgbGVhc3QgbmVlZCB0byB2ZXJpZnkgdGhpcyBjaGFuZ2Ugb24gYWxsIGV4aXN0
aW5nIGhhcmR3YXJlIGFuZCBzdWdnZXN0DQp1c2VycyB0byBmb2xsb3cgbmV3IHNwZWMgb25seS4N
Cg0KSGFvDQo=
