Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAF3B7471
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhF2OkM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 10:40:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:45987 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234256AbhF2OkL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 10:40:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195450139"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="195450139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 07:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="408191643"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2021 07:37:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 07:37:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 07:37:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 07:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3m3gNBytaCx1zok8CBq5BqmkEp5g57+94gqZ5JjhmkVdWD4WwmlyA+te2YZTWmHNcHY8kWyDQX57rD60JnHLMubOfxstPBu+WPoEO1v5Ap67u22wOUpD/veJ6zZYu7FgWjSYEgBeHWd6xunc5eQTkOmu/J8VW0mZqE8SLsEqIF/rttfQuer5OEDwxp07P0DVkWdt++Z3RvsmWWDXMGnbBV7O5QjNfUSV2FYVFkuidINDFAaqlk3TVtxLFunxzDtGHCsQg/ezulhg+JcnyjAlRt0p4uvwK0KUT97tgpqchl1yRLxq4FdBr40ZaLDwTHroZvGr8zWSWZT2zsjGMMOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYFegPRssuBezvf1zOneP7e8WI/BdFPAWaGucveLVhU=;
 b=RXqSmRhEh2vS1konPsUpVp3T9D/txCBGH/9lCIZS/ACuB28ZrEVw0VBbEFyVb4H+y4IpxGzVWT64J1VN+ElHbe5K+CtsFvHMhec/oTd9CqYhdjkbmD90BTwvbqgKXoMuBG4wGiRCFdspo5zp+w4nqGbUlCI+KCkefOvCfs5T+dkC9ev6lKVSKezQlWR5Ek40xdlSoDCjExuHjUs0BMfNgEQk7QAPzQE18RSJfw75hLtNqcAvp+IfiFXZl8LFAqvnzIBj++l4vRFdPGeQm7A+4bU7Zq66nrbHGNqkCW3t0e3zwoAcpbmgwY8R1XYfBU4c5hArEnmjhPVPANLedB4r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYFegPRssuBezvf1zOneP7e8WI/BdFPAWaGucveLVhU=;
 b=BjZwEZ2iy/JZnrOIgeBNUSVV7108TDI90ypwXeWmTxWE+qF2tFot/qOOyV/yRUbCzS0cNFgRJ4CzlJe/WnnhlEDgri4hUExo6BPXvoybkhbwAVV54zElA4IHAdKj43AdVbRt4bcvnzkI67kiQewCRY4HujwXys4kLoszB5BP23A=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 14:37:36 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 14:37:36 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>,
        Moritz Fischer <mdf@kernel.org>,
        =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@geanix.com>
CC:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
Thread-Topic: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
Thread-Index: AQHXaZW5ey7GuEEWWECbwMvnBSZbQ6spteWAgAEwowCAAClDgA==
Date:   Tue, 29 Jun 2021 14:37:36 +0000
Message-ID: <DM6PR11MB38198441F212D6959B676C6D85029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-4-martin@geanix.com> <YNoJSxnm4g1vufbB@epycbox.lan>
 <e4f0b534-903c-c95d-876e-389c8fc4852c@silicom.dk>
In-Reply-To: <e4f0b534-903c-c95d-876e-389c8fc4852c@silicom.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: silicom.dk; dkim=none (message not signed)
 header.d=none;silicom.dk; dmarc=none action=none header.from=intel.com;
x-originating-ip: [124.64.84.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf95226e-d03c-49c1-af80-08d93b0b706e
x-ms-traffictypediagnostic: DM4PR11MB5359:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5359DE34B0010464112869F885029@DM4PR11MB5359.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W9ihIRsp3hlsvCn+7Vn7lUa0S0pmoFs8aRpIIAtf2Eo6F6OvMfhtkPYDcfYBygs+jUm16sNlPYylQmRQCSxSSLnEvKTxZ2OYyyuZ36+LkaqF442G0cLXey3b/REY81I2MaXj5YJn198wS6b6BctSMawvIk96cf05LPMUPCMbEa66I8o/3+H6nnycD/R3WCx27Bs2B9lnV/1s//hyD2SDnvzomCbLCF+inYJgejTc1UfoxdDi6nyEfVgsm33l62zSb9t6aiHHQt3WdOQZ3UOqWgFeBYSyeB74rlg4tx766rT4kHEqIPQV2cuRld/ORMwpc13VohL11710agk+zBLmZW2O3mO+KBoH4aulhjbOlk8xQGdgmuyqcClyd5uBOWn/rskLxXEUxjIFNiYj91S90V826NdK9kH1kX7ouXV10KV/lSzTnNohV1EUJy2b/7uoQsOkne6AUCzEHDJDRarh++6OUse5PAwocGlxm672SzGbmaHd59xFRPvoDg879KQXGz0CnPoSM7OMW5+QvqjdBwMLBS1HKNdbU4rEseOH9ZnqU51Kn7XBMx1TqOePL/NQwyOC78gVS4Jj05+EEoddc07Yy3P9bA9gimhw5nTakFtb90NGkEb3/LXXA7PQkF7Y/f9CnDv/fLDDvXqlaBO5oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(498600001)(7416002)(9686003)(33656002)(55016002)(83380400001)(66574015)(6506007)(8676002)(66446008)(64756008)(66476007)(66556008)(66946007)(26005)(76116006)(186003)(86362001)(38100700002)(8936002)(2906002)(7696005)(52536014)(110136005)(5660300002)(4326008)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1djbkN6R0k4L21xUFMyZkJaNzk1N0Q5MDh5SWlUU1RVT2luU1gwOTdpaVB4?=
 =?utf-8?B?ZWUzZjhFOVo0K1RkcEp2QkRVcUI3TnBZQUhmWXhLai9KeUhxOUJ6T09FMm1E?=
 =?utf-8?B?NzRKWllrdFR2MUMwNWpDUW94MWFWY2Y3ZnhFY1VnMUpsM1pUYnIxNnYrTUx0?=
 =?utf-8?B?QmJtN0E1VlVKVlZDVkd2b3JQdVBabkV4TXdJQlY4bm5KYklldnUxL3J0RHRt?=
 =?utf-8?B?dzRXVVpMZmtFTGdMMDFtNEJNTC9lSTl3dzJ2b0hjSGZscUdEaDJPZkhlR3Rr?=
 =?utf-8?B?UzFraTRtYTZDWjhnQ2dvcmIyVVRPR0VYclJ5NEY1Tm9hNHVtaFZ1Zy8reHpn?=
 =?utf-8?B?N3RGTEhBRDNlVEs1dTUvbzgrcmlxV3c0bjg5bUJxY1RZaWtxZm50YlBxZ1pB?=
 =?utf-8?B?MzZBS0dOdXZUbkx0eHRtYmhzN2lobjVrZlBTdXJKaWx0VS9sR3h5QWRMWDVJ?=
 =?utf-8?B?cGU4dUJVUUIrQ0krRUpnTlVURVpHdCtKZHE4NmV6T0FZQlI4a1NyZENGd3Mz?=
 =?utf-8?B?blpYdFgxS2MxNDUvT25OZHhOTmZKbnpkRk01NEFKcDlrTDNHbE1NYVhJSkZq?=
 =?utf-8?B?VnpmUFUxb0s1aEFGaE1uZUFnQkRzNExuQWY2NTljVjNkZWhBMGkxdlkvNFk1?=
 =?utf-8?B?bnZpM3NIVEhWc21MRkNvYXFwcGo5M2hDQy9rMityTmRGTzlTRzhSNk9VTGNZ?=
 =?utf-8?B?U1QyQWZGYlVYL2dyaEsyQ00xd2Exdm9mQW11ZUhrODFwUVlabGQ0VThFSFp1?=
 =?utf-8?B?TTljU2lLMEJzSm13alk4eDd1cWY2RVM3OE9tSGNxY0hhV2dKVEg5cWgwZElJ?=
 =?utf-8?B?ejVnMURVLzNZd3JBVVA1Y1A4VTRGSDlSRzlJRk5iSks2OFVqSTVzR3p2K1VB?=
 =?utf-8?B?QUNRRGlsODdPSnNPcnF5TkNrVlNhTnhkMVFkNDc4cFVGYzBqWGdtVzk3Q0xF?=
 =?utf-8?B?YXhNRU1lZlhHZFpvNmsyWHdVbzF2ck9kbFNQZ3IyUlp3TU1SdHcwRkhWclpo?=
 =?utf-8?B?RnVsOWtjaGFrcGhPRmh2dEt5RmtDYk5keUdnSzB0U2t6cDJTaG5RZTlTaEV5?=
 =?utf-8?B?cFVlR2xlYnJXeFlHMlErUmVNcUpxc1JyVXl2enlEcnc4KzEvaTM3b1Y3OUdR?=
 =?utf-8?B?MjFYQ3ljOG13TDhIeXUraDNqWlUrWHVrLzRsNmxGbDFUN3dLS09UbGVmUktY?=
 =?utf-8?B?dmd6aUJQeDdnSmZwSFFVRXRXTWt6c3hWQXh6Z0oyNllkNWo5ZFNDQ1EwT2wz?=
 =?utf-8?B?SlNWbk1EWHVFdHQyS2dxbUdQK0FNT2pQdDREcWpxNVd4QjVWd1JZTkVtMzls?=
 =?utf-8?B?N0l0eFZEYTJrSUJOdUFJclc1eDIyWWZqR1FwYkVJUS9Zdi91OWVPWTlvOTli?=
 =?utf-8?B?eE1iQ2UwdjJwK1g1OVBOSE91QWx3TC8zN3pGTFdkVEtkUkZ6bjExUGFVUHll?=
 =?utf-8?B?b3hOY2xGRGZYTjZMOWFLNjlwMjZMeDhDMWlIcHdRUE1UWHkvQ3hzZUJmTmdX?=
 =?utf-8?B?WGFCNlMwQlN5b2hzM3BDaU8vT3g5bGo1M3p5dHYycXNqaHBFNTByN2xnT2xN?=
 =?utf-8?B?WGQ3LzU3aGtkVExWNlpEVkpkUTFUV1FUYnRRR3BSazFubW1ZMkVuOWhxUFht?=
 =?utf-8?B?bk5SRUhWRkJNU01vUXZmejNjdkFPY0FHYlpiaEs2Ylh3c09EQlhvems1TXJ4?=
 =?utf-8?B?ODFndndUcHo2dVBKck1SSGV6bmlrS3NkNHY3VkdNN0dvS0hzVDh1b2puaCtx?=
 =?utf-8?Q?1+XRqwzLck800tmG8PIJFw4/lv1N4IesAGXPn5z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf95226e-d03c-49c1-af80-08d93b0b706e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 14:37:36.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMYe+xsrpmbAlLI7plJhLDmOfdy6crAYe3BNhylpT7spqA4cykurwHoL2fELgm/QXuFp4fx0+zvhriAfeBgfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5359
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiAyOC8wNi8yMDIxIDE5LjM5LCBNb3JpdHogRmlzY2hlciB3cm90ZToNCj4gPiBPbiBGcmks
IEp1biAyNSwgMjAyMSBhdCAwOTo0MjoxMUFNICswMjAwLCBNYXJ0aW4gSHVuZGViw7hsbCB3cm90
ZToNCj4gPj4gRnJvbTogTWFydGluIEh1bmRlYsO4bGw8bWh1QHNpbGljb20uZGs+DQo+ID4+DQo+
ID4+IFRoZSBNYXgxMCBCTUMgb24gdGhlIFNpbGljb20gbjUwMTAgUEFDIGlzIHNsaWdodGx5IGRp
ZmZlcmVudCB0aGFuIHRoZQ0KPiA+PiBleGlzdGluZyBCTUMncywgc28gdXNlIGEgZGVkaWNhdGVk
IGZlYXR1cmUgcmV2aXNpb24gZGV0ZWN0IGl0Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBN
YXJ0aW4gSHVuZGViw7hsbDxtaHVAc2lsaWNvbS5kaz4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+IENo
YW5nZXMgc2luY2UgdjE6DQo+ID4+ICAgKiB1c2UgZmVhdHVyZSByZXZpc2lvbiBmcm9tIHN0cnVj
dCBkZmxfZGV2aWNlIGluc3RlYWQgb2YgcmVhZGluZyBpdA0KPiA+PiAgICAgZnJvbSBpby1tZW0N
Cj4gPj4NCj4gPj4gICBkcml2ZXJzL3NwaS9zcGktYWx0ZXJhLWRmbC5jIHwgMTUgKysrKysrKysr
KysrKy0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktYWx0ZXJhLWRm
bC5jIGIvZHJpdmVycy9zcGkvc3BpLWFsdGVyYS1kZmwuYw0KPiA+PiBpbmRleCAzZTMyZTRmZTU4
OTUuLmY2Y2Y3YzhkOWRhYyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWFsdGVy
YS1kZmwuYw0KPiA+PiArKysgYi9kcml2ZXJzL3NwaS9zcGktYWx0ZXJhLWRmbC5jDQo+ID4+IEBA
IC0xMTEsNiArMTExLDEzIEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX2JvYXJkX2luZm8gbTEwX2JtY19p
bmZvID0gew0KPiA+PiAgIAkuY2hpcF9zZWxlY3QgPSAwLA0KPiA+PiAgIH07DQo+ID4+DQo+ID4+
ICtzdGF0aWMgc3RydWN0IHNwaV9ib2FyZF9pbmZvIG0xMF9uNTAxMF9ibWNfaW5mbyA9IHsNCj4g
Pj4gKwkubW9kYWxpYXMgPSAibTEwLW41MDEwIiwNCj4gPj4gKwkubWF4X3NwZWVkX2h6ID0gMTI1
MDAwMDAsDQo+ID4+ICsJLmJ1c19udW0gPSAwLA0KPiA+PiArCS5jaGlwX3NlbGVjdCA9IDAsDQo+
ID4+ICt9Ow0KPiA+IElzIHRoZXJlIG5vIHdheSB0byBxdWVyeSB0aGUgbWMgZm9yIHZlcnNpb24g
aW5mbz8NCj4gDQo+IERvIHlvdSBtZWFuIHJlYWRpbmcgdGhlIEJNQyB2YXJpYW50IChpLmUuIG41
MDEwIC8gZDUwMDUgLyBuMzAwMCkgZnJvbSBhDQo+IHJlZ2lzdGVyPw0KPiANCj4gTm90IGluIGEg
dW5pZm9ybSB3YXkgYWNyb3NzIHRoZSBkaWZmZXJlbnQgYm9hcmRzIHRoYXQgSSdtIGF3YXJlIG9m
LiBCdXQNCj4gaXNuJ3QgdGhpcyB3aGF0IHRoZSBERkwgZmVhdHVyZSByZXZpc2lvbiBpcyBtZWFu
dCBmb3I/DQoNCklmIHRoaXMgaXMgdXNlZCB0byBkaXN0aW5ndWlzaCBkaWZmZXJlbnQgYm9hcmRz
LCB0aGVuIHJldmlzaW9uICg0Yml0cz8pIG1heSBub3QNCmJlIGVub3VnaC4gTmV3IHZlcnNpb24g
REZIIG1heSBiZSBhYmxlIHRvIHJlc29sdmUgdGhpcyBsaW1pdGF0aW9uLCBidXQgaXQNCmlzIGFs
d2F5cyBlbmNvdXJhZ2VkIHRvIGhhdmUgaXRzIG93biBtZXRob2QgdG8gdGVsbCBpZiBwb3NzaWJs
ZSwgbm90IGRlcGVuZGluZw0Kb24gREZILCBpdCBtYWtlcyB0aGlzIElQIGVhc3kgdG8gYmUgcmV1
c2VkIGluIG5vbiBERkwgY2FzZS4gDQoNClRoYW5rcw0KSGFvDQoNCj4gDQo+IC8vIE1hcnRpbg0K
