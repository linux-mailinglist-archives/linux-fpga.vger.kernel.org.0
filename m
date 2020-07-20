Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71396225B4C
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jul 2020 11:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGTJVs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jul 2020 05:21:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:16317 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGTJVr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 05:21:47 -0400
IronPort-SDR: o2etCD6HMACWJk6rWJ6oIPDMU0KDYJz/NjYXYBQlwGzD4vreXz9Z+MgdcySRff89h6qKbPg2mD
 tjCeVCD8p2XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="147832583"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="147832583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 02:21:46 -0700
IronPort-SDR: m0Tp605S/KwsZ1cSKrkYzLBlCSxz2//SgpQbZhsaMbyIy1qYGMqbw4TQYrHc0GOQTWZp+kvgSZ
 Hcd9QtfeydBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="317958272"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2020 02:21:46 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 02:21:45 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 02:21:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 02:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVaEJ16fSH1aBFGfoZkofkYYaKGglTBuzpxoNiZm2QUSKOw/qymvYTGsUAxcCXlTqxebj8tykga2IHeLk/Bz3gKwTYQT30dXbLaSiAeQZHoZrE0AVVaCS0RWyrvbkbTwvDKt7D/ZyVJRyI5Ojfft+bBRR1vabeZNT5Gd0mL96y1uHErfomfNS66v/8eLdyqrZiTfau5F9nkebWYhvQu2wuXUcc/Kj6WNeFtxMFJCDdSEUx32gOrvqgQ1XS44rp2YuFuWGRqk4q0UZcpbNOwBw6FHrpVaT67mR+fvZ/dtnCrIz+4txbXfCHD7nWKq0vLiRjSM2hmGH2NU/wcoFjWa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ursk0I1NfcdpCaMMPQMgBks4Sle1rpng9ZAOXX3t0qE=;
 b=H6wOugnOtdSlTN7goEoaJ6MFpHMDunjdKfp4Qk4l4Gdzrrq8DhNYPutaB0asvyPilL+jD1h1D/oPt5UihXcrvTVE8UTJ2+1eVPaIVqtG574vTO8Mm+1fCZ+4f8LAmnS0oCdTPgyg44kglnzT88tD9pzG+zkFlFZOADcOHfZvHE4HoDh+T8JnIzinm/PQRJHA1Al9m/JWpsbZlMnm4zSg/kmzQ/TnjJ7UhmfwQxT82AQdTvW9tiNiNsJCUDCNCYMjl0TnRLBt9aB7frRJ1Vu48YcvebMTwugFVQSGNaoWqNKWttCeuYu8+FwXzsQZFq1T5r4ez0a0GVM/rOhC8UyGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ursk0I1NfcdpCaMMPQMgBks4Sle1rpng9ZAOXX3t0qE=;
 b=Zl5NFhShNOYxT8NO6snBGB/zB54wDlCY3cMcAeI70er9cs76kNaTirTG5Rwa4ggdU7+Sptto7ZqRtleTUusGovx5jK15TLDczGBHHboUmTH6Bo3ON5srWsZkVP5oEZFz5v23J3NKwI1Lcc3rmKUJPgsSUN5ygPs6aadypmjv/Xk=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 09:21:43 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:21:43 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH 0/2] Modularization of DFL private feature drivers
Thread-Topic: [PATCH 0/2] Modularization of DFL private feature drivers
Thread-Index: AQHWWmrEJgXA6z6VKkSElM9m2kDwiKkK0kaAgABMTyCAAKoAAIAEbbbw
Date:   Mon, 20 Jul 2020 09:21:43 +0000
Message-ID: <DM6PR11MB3819828C1C193087AC6A4629857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
In-Reply-To: <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc89aa65-ad55-4ecf-8b6b-08d82c8e5160
x-ms-traffictypediagnostic: DM6PR11MB4627:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4627CB6848F04497EDBBE42D857B0@DM6PR11MB4627.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q674G8dkDlwe9b3M4+XskS+Au+u20db1OpkcXj+9ecDeVlLH+DGgUFWFA5vUpdvdqRKh9GdAez4OL0VMSEuFDrPYOEILk+5cHfZ9QSg2hX256XxG+h829gU+3TTXP/OxySP26Od1/P1jkhoiXCKUMdhnRJcNO4acH0GbX1HU2CY3Kxo+TvzdxMwjBecfLSL/anvIHgu+Unjo8GktzNMseJ8agke4itcB2viRf9eSAAddyvUK9XdL7k1/0IUeaxcUQDBQEoWl8mNevhfsNur/yp1BiPig1/eqxuvUJDGabr4aFeQ7n8LpnzmRJZ/OYwnrya80Uvhbwuqz7ena2mXMbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66556008)(66476007)(86362001)(76116006)(66946007)(71200400001)(9686003)(64756008)(7696005)(478600001)(6506007)(55016002)(53546011)(26005)(8676002)(8936002)(66446008)(83380400001)(110136005)(5660300002)(316002)(52536014)(33656002)(186003)(54906003)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pox3o7CVgXF/byd1BkYHTxnulAZa6yohMOtmeXTvm3B5pyK1pQ1dJaK9YFgpKt68OLNWfvLNoGgEKW3WaWKnaj5h6ukO4LvtrlsqDXMgr+n5hZekby4PY3f9u1BApwoRnRgBhgekm0ptvd+wv2sL1AqO700hcOQPWcflcNQWkw0DQbRp4nYx8EU5IGM8Iuj3mjCg2OJCJBwTlWSdONz0ZaVuzh28Hnxs49/APTvCgsqEcTgVmXLXg0kiJxdBxkCuR7fLO84Y944Yi8XL6UOCfGyCWpnhRKRfhzhbOKF+DcA96UhaURQSrR53sPSRi9Xjwd5OItM/FWPEAReHzYqlzc+/bOs0gXh+D8t1juZYDv/Q1Hvo9pjjD1WhYCq0DmUVuQOdY6UMWFbKLxX/psuNjiSOoK6gY82ZQ06bNwP3QT4B0Ua2NprSOhMJcS844vWVXzzcsAqWPq3/aHqcreampWaYfMj1gqxMTrT4A6NzwbMG2LjLCIi52aQgLFsijltA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89aa65-ad55-4ecf-8b6b-08d82c8e5160
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 09:21:43.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3DERINWXp5OGx2XeOu3CGA1fjttOowT9/I3HDD8bTAfbyE/0BY1Wq2ejwcRfGEkLUSqs+FiPrHIQ9u66vt/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA3LzE2LzIwIDg6NDggUE0sIFd1LCBIYW8gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMC8yXSBNb2R1bGFyaXphdGlvbiBvZiBERkwgcHJpdmF0ZSBmZWF0dXJlIGRyaXZlcnMN
Cj4gPj4NCj4gPj4gR2VuZXJhbGx5IGkgdGhpbmsgdGhpcyBpcyBhIGdvb2QgYXBwcm9hY2guDQo+
ID4+DQo+ID4+IEhvd2V2ZXIgSSBkbyBoYXZlIGNvbmNlcm4uDQo+ID4+DQo+ID4+IFRoZSBmZWF0
dXJlX2lkIGluIGRmbCBpcyBtYWdpYyBudW1iZXIsIHNpbWlsYXIgdG8gcGNpIGlkIGJ1dCB3aXRo
b3V0IGENCj4gdmVuZG9yDQo+ID4+IGlkLg0KPiA+Pg0KPiA+PiBJcyBpdCBwb3NzaWJsZSB0byBh
ZGQgc29tZXRoaW5nIGxpa2UgYSB2ZW5kb3IgaWQgc28gZGlmZmVyZW50IHZlbmRvcnMgd291bGQN
Cj4gPj4gbm90IGhhdmUgdG8gYmUgc28gY2FyZWZ1bCB0byB1c2UgYSB1bmlxdWUgaWQgPw0KPiA+
IEhpIFRvbSwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KPiA+DQo+ID4gSGVy
ZSBpcyBvbmx5IG9uZSBmaWVsZCBkZWZpbmVkIGluIHNwZWMsIHRoYXQgaXMgZmVhdHVyZSBpZCB0
byBkaXN0aW5ndWlzaCBvbmUNCj4gPiBmZWF0dXJlIHdpdGggYW5vdGhlciBvbmUuIFRoZXJlIGlz
IG5vIHZlbmRvciBpZCBoZXJlIEkgdGhpbmssIGFuZCBzZXZlcmFsDQo+ID4gY2FyZHMgYXJlIHVz
aW5nIHRoaXMgZm9yIG5vdyBhbmQgc2VlbXMgbm90IHBvc3NpYmxlIHRvIGNoYW5nZSBERkggZm9y
bWF0DQo+ID4gZm9yIHRoZXNlIHByb2R1Y3RzLiA6ICgNCj4gDQo+IFRoZXJlIGxvb2tzIGxpa2Ug
c29tZSB1bnVzZWQgYml0cyBpbiB0aGUgZmlyc3Qgd29yZCwgaG93IGFib3V0DQo+IA0KPiAjZGVm
aW5lIERGSF9FT0zCoMKgwqAgwqDCoMKgIMKgwqDCoCBCSVRfVUxMKDQwKcKgwqDCoCDCoMKgwqAg
LyogRW5kIG9mIGxpc3QgKi8NCj4gDQo+ICtkZWZpbmUgREZIX1ZFTkRPUsKgwqDCoCBHRU5NQUtF
X1VMTCg0OSw0MSkgLyogVmVuZG9yIElEICovDQo+IA0KPiAjZGVmaW5lIERGSF9UWVBFwqDCoMKg
IMKgwqDCoCBHRU5NQVNLX1VMTCg2MywgNjApwqDCoMKgIC8qIEZlYXR1cmUgdHlwZSAqLw0KPiAN
Cj4gQW5kIEludGVsIGdldHMgaWQgMC4NCj4gDQo+ID4NCj4gPiBJIGZ1bGx5IHVuZGVyc3RhbmQg
dGhlIGNvbmNlcm4gaXMgdGhlIGZlYXR1cmUgaWQgbWFuYWdlbWVudCwgYW5kIHBvdGVudGlhbA0K
PiA+IGNvbmZsaWN0cyB0aGVyZSBmcm9tIGRpZmZlcmVudCB2ZW5kb3JzLiBPbmUgcG9zc2libGUg
bWV0aG9kIHRvIHJlc29sdmUgdGhpcw0KPiA+IGlzIG1hbmFnaW5nIHRoZSBpZHMgaW4gYSBwdWJs
aWMgcGxhY2UgKHdlYj8gT3IganVzdCB0aGUgZHJpdmVyIGhlYWRlciBmaWxlIGZvcg0KPiA+IGZl
YXR1cmUgaWQgZGVmaW5pdGlvbiksIGFsbCB2ZW5kb3JzIGNhbiByZXF1ZXN0IHNvbWUgZmVhdHVy
ZSBpZHMsIGFuZCBvdGhlcg0KPiA+IHBlb3BsZSBjYW4gc2VlIHdoaWNoIGZlYXR1cmUgaWRzIGhh
dmUgYmVlbiB1c2VkIHNvIHRoYXQgdGhleSBjYW4gYXZvaWQNCj4gPiB1c2luZyBjb25mbGljdCBv
bmVzIHdpdGggb3RoZXIgcGVvcGxlLg0KPiANCj4gVGhlIGNvbmZsaWN0IHdpbGwgY29tZSBpbiBk
ZXZlbG9wbWVudCB3aGVuIHR3byB2ZW5kb3JzIHVzZSB0aGUgc2FtZQ0KPiB1bnB1Ymxpc2hlZCBm
ZWF0dXJlIGlkLg0KPiANCj4gQWxzbyBrZWVwaW5nIHRoZSB0cnV0aCBvZiBpZCdzIGluIHRoZSBr
ZXJuZWwgc291cmNlIGlzbid0IHRoYXQgZ3JlYXQgYmVjYXVzZSB0aGUNCj4gcHVibGljIGtlcm5l
bCBhbHdheXMgbGFncyBkZXZlbG9wbWVudCByZXBvc2l0b3JpZXMuDQoNCkkgZnVsbHkgdW5kZXJz
dGFuZCB5b3VyIHBvaW50LCBhbmQgaXQncyBhIGdvb2QgaWRlYSB0byBtZSwgYnV0IEkgYW0gbm90
IHN1cmUgaWYgDQp3ZSBjYW4gdXBkYXRlIHRoZSBzcGVjIGZvciBERkh2MCBhdCB0aGlzIG1vbWVu
dC4gTGV0IG1lIGNoZWNrIHdpdGggc3BlYw0Kb3duZXIgYWJvdXQgdGhpcy4gQWN0dWFsbHkgSSBi
ZWxpZXZlIHdlIGRvbid0IHdhbnQgdG8gYWRkIGFueXRoaW5nIGluIGRyaXZlcg0KY29kZSB3aGlj
aCBpcyBub3QgZGVmaW5lZCBpbiB0aGUgc3BlYyBhdCBhbGwuIDogKCANCg0KPiANCj4gPg0KPiA+
IEFuZCBpbiB0aGUgbGF0ZXIgdmVyc2lvbiBERkgsIHRoaXMgZmVhdHVyZSBpZCB3aWxsIGJlIHJl
cGxhY2VkIHdpdGggR1VJRA0KPiA+IEkgdGhpbmssIHNvIGl0IGNhbiByZXNvbHZlIHRoZSBjb25m
bGljdCBwcm9ibGVtcyBmcm9tIGRpZmZlcmVudCB2ZW5kb3JzPw0KPiA+IEJ1dCBub3csIHdlIHN0
aWxsIG5lZWQgdG8gaGFuZGxlIHRoZSBleGlzdGluZyBvbmVzLiA6ICkNCj4gDQo+IFRoaXMgaXMg
d2h5IEkgcHJvcG9zZWQgbmVlZGluZyB0byBnZW5lcmFsaXplIHRoZSBtYXRjaGluZy4NCg0KUGVy
c29uYWxseSBJIHByZWZlciB0aGF0IHdlIGNhbiBoYXZlIHN0YW5kYXJkIG1hdGNoaW5nIGZ1bmN0
aW9ucyBwZXIgREZIDQpzcGVjcy4NCg0KWWlsdW4sIGhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGhp
cz8NCg0KVGhhbmtzDQpIYW8NCg0K
