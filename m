Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE620EB7E
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jun 2020 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgF3Cez (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Jun 2020 22:34:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:29433 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgF3Cey (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Jun 2020 22:34:54 -0400
IronPort-SDR: FlpPAYG8JwLBoT0Y6KGh88T+4H7JhfXNro70JSziXEoZmy/vkoF/8lFiEol0x6cIZbOPKovE89
 AVE7nIz1cqfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143605583"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="143605583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 19:34:53 -0700
IronPort-SDR: XW0yoECN78Iz7r1UECPYO0M7JO8xJ/yfq9f5dhTCUEFUgb3937t5aeyM6DRnBdpEsK1QNu5OCv
 VwnK2zNOWA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="313251392"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 19:34:53 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 19:34:53 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 19:34:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 19:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuXyZcCvFvMeFBt0/O1N/afBpQf9WGgiGC3t/pqem4yTSxH/orgTx4+jsPug79g1Lu1u56J8u6rU8Xtien2iCWTOlrmqYlvhZnoEPqjPBUQ75MBAcQQm5SP5/nLAHC6mLsYr3dcnJR/sw6KKx9+KmZDR+m7s1zeMfFVw0XHkQnZx1eU55NafklqLnGg2+KzAQdKUn7TBh92Y+3FgB0xyW4JIpHASypWoJcwjUR2Fgsz4Z69RY8tfIsyt79bYyNxhqlNa6RYpFji6xingtAcHt+lZJp+sptixY+jWRBWbVklBdMnL3mLjKug8tj1GrlZw8C6WzygY1sQPbhEl92arUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SDE7bBe5kEUVaAe59KdQCRQdEluSmsK+bUiMTaDA4U=;
 b=ZuoW7+68AtxhtNVUTPnd/asnygR54VvcB4GD07e6Rs1ETK7faJ2AW/L6OFnz8um7ua7/9RcRSdUvxAIhaE1Jvdt3MWh07JKmetwl8VMfGye94I5LbuQSn6bT2N5dtwROMog7o8NlZqdWWTpX428fnxKkA5AaswE3YIuv9qrOhPELI7r4ibHp3JLmREwD7XMaQHLFy/eBGklNXrsy16sPRo9mbBs8rldlbdhpKui4dHw3dfhhZnxWYwZaSw0EUlok5TBeeGU4CgDNLGkecm5V0eISrY5ab1Gkx2mZp9OBW9R/YrSccfVmCrgh6zI6Pz8z0FfuD3wkdxqxquF+YVC8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SDE7bBe5kEUVaAe59KdQCRQdEluSmsK+bUiMTaDA4U=;
 b=Zk8d8jeRwAKcA0VFCd94S3wc+vmOyPq6uvjenyDIjLHV15gR2r/IoYFx7HqNy/BThztqxs4TmybzNVW92Rk0ur8lzXRePbwb5zrNd/O/ekONHWbySPlqZgFZyWdR1Z1jmUBx/QNv/tBVasZl+8wzf1pRPhSAqI4CE0THRAdYhjQ=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 02:34:51 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 02:34:51 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Thread-Topic: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Thread-Index: AQHWTV9tEB8rGujJlkC0kwtfRn41f6ju3KoAgAAFiMCAALVLAIAA0AYw
Date:   Tue, 30 Jun 2020 02:34:51 +0000
Message-ID: <DM6PR11MB381974DF93997A787488AA02856F0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200628151813.7679-1-trix@redhat.com>
 <20200629021924.GB2620@yilunxu-OptiPlex-7050>
 <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <26b7c920-7b9f-b753-4a49-258e09b771fa@redhat.com>
In-Reply-To: <26b7c920-7b9f-b753-4a49-258e09b771fa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb442ec-5634-4c15-ac44-08d81c9e2a74
x-ms-traffictypediagnostic: DM6PR11MB4707:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4707E16ECCBFFE6B96870A51856F0@DM6PR11MB4707.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGiiWqBsDimp5CNz/Ddogk5RqIT7uLhYvLfdoHVPpUiIBncz0KRa/j/6t/OhZ871Vq64Pe2GeYp0oyY5Dey67c6fkTcdy9N88pV7m0LaJw4+5Rm0n+MJK3RCEjNbXVOFkrvUwX7GEP283Q/MLBAbGJqEboVChdDP0vKcM9OjkvO2b56ITPCIG+Xu1ZgO45yNY7M+4V6VghW1bp/XP0jDeZUnBhQ+H6u0psUk8NQGrodMqLXrrz+So7jKLLfJKO86Syc3dy7NXZreX/T7C5mQA5FSy2j/zMv6zIFNsZ4iWX7aDEDvYJj+1wX6/SIaLlh0gbuBuOk8B6sa6HQyNvJDOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(64756008)(66446008)(26005)(8936002)(6506007)(52536014)(66556008)(66476007)(66946007)(316002)(478600001)(2906002)(33656002)(76116006)(7696005)(86362001)(83380400001)(54906003)(186003)(71200400001)(8676002)(9686003)(6636002)(53546011)(4326008)(55016002)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hvxwgBAkDy9VHkD1dNNbosi/ip+1NN8Q1zQAqXFz6F3tntz6YxFP3lQAh3+g/cLYDcimk3YcOIlosiHABZrgbcjayyoaT4by9JilCN6qf6jZNkqwuk4eLcuTAcGDuzZBZgNzOnC9QehafASAQTk6v6572lwEXlBQmhXjn/Q8HV7zEkimmx9rHh1j5N3o2Th2yEclvFsNEI1ksmwaSTBYXA9eJfvZHsjk4ud7BAcOUsorJctF+u6QFMhXA+eCvl3WdBXJnTzvhUSognICvywh/06tlm5Mc3Y5KxACCuB9YHWpUlmKHao85tL0Zs6T1Im2Ne+Mag8FDCkF+Ucg8sNligDv6WhLfecvXjrZW4A7KBE2eKaMAF6gXe7na02WJfQPowJPPvxFjQG70wZiAScdLMsFZtp5ycxtRO9Ez3+jdVFQnsQE4KtBNW1Z6LkYDNY8K8fA1KbSNFoeJiIfndUZknJ7BZ9hE4r80H8FuYM+k27dFLLnon3bEPpd7pItRi1a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb442ec-5634-4c15-ac44-08d81c9e2a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 02:34:51.4525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQuzaOAf1/E3fou1tO8k6tfGrCmlsNqm/b9KpNE/L9H1T2V95AXP261uCXcqY7XByHHwvX2MyB4jmomtYRH4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA2LzI4LzIwIDg6MTIgUE0sIFd1LCBIYW8gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGxpbnV4LWZwZ2Etb3duZXJAdmdlci5rZXJuZWwub3Jn
IDxsaW51eC1mcGdhLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4+IE9uIEJlaGFsZiBP
ZiBYdSBZaWx1bg0KPiA+PiBTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjAgMTA6MTkgQU0NCj4g
Pj4gVG86IHRyaXhAcmVkaGF0LmNvbQ0KPiA+PiBDYzogbWRmQGtlcm5lbC5vcmc7IGxpbnV4LWZw
Z2FAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
V3UsIEhhbyA8aGFvLnd1QGludGVsLmNvbT47DQo+ID4+IG1hdHRoZXcuZ2VybGFjaEBsaW51eC5p
bnRlbC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZnBnYTogZGZsOiBpbXByb3ZlIGNv
bmZpZ3VyYXRpb24gb2YgZGZsIHBjaSBkZXZpY2VzDQo+ID4+DQo+ID4+IEkgdGhpbmsgbWF5YmUg
d2UgZG9uJ3QgaGF2ZSB0byBzZWxlY3QgdGhlbSBhbGwuIEl0IGlzIG5vdyBwb3NzaWJsZSBmb3IN
Cj4gPj4gRlBHQSBERkwgYm9hcmRzIHRvIHdvcmsgd2l0aG91dCBGTUUgb3IgQUZVLCBwcm92aWRp
bmcgbGltaXRlZA0KPiA+PiBmdW5jdGlvbmFsaXR5LiBJdCBpcyBwb3NzaWJsZSBkZXNpZ25lcnMg
dHJpbSB0aGUgYml0c3RyZWFtIGZvciB0aGVpcg0KPiA+PiBwdXJwb3NlLCBhbmQgYWxzbyBuZWVk
IGEgc21hbGxlciBkcml2ZXIgc2V0Lg0KPiA+Pg0KPiA+IFllcywgd2UgaG9wZSB0aGF0IHRoaXMg
ZGZsLXBjaSBjb3VsZCBiZSBhIGNvbW1vbiBtb2R1bGUgc2hhcmVkIGJ5DQo+ID4gZGlmZmVyZW50
IGNhcmRzLiBTb21lIGRldmljZSBkb2Vzbid0IGhhdmUgRk1FLCBlLmcuIHNvbWUgVkYgZGV2aWNl
DQo+ID4gd2l0aCBBRlUgb25seSwgc29tZSBkZXZpY2UgaGFzIEZNRSwgYnV0IG5vIFBSIHN1cHBv
cnQsIGFuZCBpbiB0aGUNCj4gPiBmdXR1cmUsIGl0J3MgcG9zc2libGUgdG8gYWRkIG5ldyBtb2R1
bGVzLCBvciBzb21ldGhpbmcgcmVwbGFjaW5nIEFGVQ0KPiA+IG9yIEZNRSwgc28gd2UgZG9uJ3Qg
aGF2ZSB0byBzZWxlY3QgYWxsIGhlcmUuDQo+ID4NCj4gPj4gSSB0aGluayB3ZSBtYXkgYWRkICJk
ZWZhdWx0IEZQR0FfREZMIiBmb3IgRlBHQV9ERkxfRk1FLA0KPiA+PiBGUEdBX0RGTF9GTUVfTUdS
IGFuZCBvdGhlcnMgdG8gbWFrZSBsaWZlIGVhc2llci4NCj4gPiBJdCdzIGhhcmQgdG8gc2F5IGl0
J3MgZWFzaWVyIGZvciBldmVyeWJvZHksIGUuZy4gSSBhbSBhIHVzZXIgb2YgTjMwMDAsIGJ1dA0K
PiA+IEkgaGF2ZSB0byB1bnNlbGVjdCB0aGUgUFIgbW9kdWxlcywgYXMgdGhleSBhcmUgZGVmYXVs
dCBZZXMgYXMgcHJvcG9zZWQ/DQo+ID4gTWF5YmUgaXQncyBiZXR0ZXIgdG8gbGV0IHVzZXIgc2Vs
ZWN0IHdoYXQgdGhleSB3YW50LCB1bmxlc3Mgd2UgZmluZA0KPiA+IHNvbWV0aGluZyByZWFsbHkg
Y29tbW9uIG5lZWRlZCB1bmRlciBERkwgZnJhbWV3b3JrLg0KPiANCj4gSSBnZXQgeW91ciBwb2lu
dCBhYm91dCBuMzAwMCwgYnV0IHRoYXQgY2FyZCBpcyBub3QgY3VycmVudGx5IHN1cHBvcnRlZCBp
biB0aGUNCj4gcHVibGljLiBDdXJyZW50bHkgdGhlcmUgaXMgcmVhbGx5IG9ubHkgcGFjMTAsIHRo
ZSAweDljNCBkZXZpY2UuwqAgT25jZSBuMzAwMA0KPiAoYW5kIGQ1MDA1KSBpcyBvdXQsIGl0IHdp
bGwgaGF2ZSBzZXZlcmFsIHN1YiBkZXZpY2VzIHRoYXQgd2lsbCBhbHNvIHNvIG5lZWQgdG8gYmUN
Cj4gbWFudWFsbHkgY29uZmlndXJlZC7CoCBXaGlsZSBhIGRldmVsb3BlciBvZiB0aGUgbjMwMDAg
d2lsbCBrbm93IHdoaWNoDQo+IHN1YmRldmljZXMgYXJlIG5lZWRlZCwgc29tZW9uZSBqdXN0IGJ1
aWxkaW5nIHRoZSBrZXJuZWwgd2lsbCBub3QuwqAgU28gd291bGQNCj4gZXhwZWN0IHRoZXJlIHRv
IGJlIHNvbWV0aGluZyBsaWtlDQo+IA0KPiBDT05GSUdfRlBHQV9ERkxfTjMwMDANCj4gDQo+IHNl
bGVjdCBDT05GSUdfREZMX1BDSQ0KPiANCj4gc2VsZWN0IENPTkZJR19ERkxfU1VCREVWXzENCj4g
DQo+IC4uDQoNCkhvdyBhYm91dCBub24gREZMIHN1YiBtb2R1bGVzPyBEbyB5b3UgbWVhbiBpdCdz
IGdvaW5nIHRvIHNlbGVjdCBldmVyeXRoaW5nDQp0aGlzIGNhcmQgbmVlZHMsIGluY2x1ZGluZyBz
cGksIGV0aGVybmV0LCBibWMgYW5kIG90aGVyIGNvbXBvbmVudHMgdXNlZCBvbg0KdGhpcyBjYXJk
LCBhcyBGUEdBIChlLmcuIE4zMDAwKSBpcyB0aGUgb25seSBjb21tdW5pY2F0aW9uIGNoYW5uZWwg
dG8gdGhlbT8NCg0KPiANCj4gT24gUEYgdnMgRlAsIHllcyBvbmx5IGFmdSBwYXJ0cyBhcmUgbmVl
ZGVkLsKgIEJ1dCBpIGRvdWJ0IGFueW9uZSBidWlsZHMgYSBWRg0KPiBzcGVjaWZpYyBrZXJuZWwu
IEFuZCBpZiBmb2xrcyB3YW50ZWQgdG8gbm90IHVzZSB0aGUgZm1lIHBhcnRzIHRoZXkgd291bGQg
bm90DQo+IGhhdmUgdG8gbG9hZCBpdCdzIG1vZHVsZSBhdCBydW4gdGltZS4NCg0KSXQncyBwb3Nz
aWJsZSB0byBidWlsZCBhIHNtYWxsZXIgaW1hZ2UgZm9yIHZpcnR1YWwgbWFjaGluZSB1c2FnZS4N
Cg0KPiANCj4gSSB3b3VsZCBsaWtlIGEgdG9wIGxldmVsIGNvbmZpZyB3aGF0IGF1dG8gc2VsZWN0
cyBhbGwgb2YgdGhlIHN1Ym1vZHVsZXMgbmVlZGVkDQo+IGJhc2VkIG9uIHRoZSBjYXJkLiBJIHRo
aW5rIG1heWJlIHRoYXQgaXMgQ09ORklHX0ZQR0FfREZMX1BBQzEwLiBzbyB3ZQ0KPiB3aWxsIGJl
IHJlYWR5IGZvciBDT05GSUdfRlBHQV9ERkxfTjMwMDAgYW5kIENPTkZJR19GUEdBX0RGTF9ENTAw
NQ0KPiBhbmQgd2hhdCBldmVyIGNvbWVzIGxhdGVyLg0KDQpIb3cgYWJvdXQgYSByZWZlcmVuY2Ug
a2VybmVsIGNvbmZpZyBsaXN0ZWQgc29tZXdoZXJlIChlLmcuIGluIGtlcm5lbCBkb2Mgb3INCnNv
bWUgb3RoZXIgcHVibGljIHBsYWNlKSBmb3IgdGhlbT8NCg0KSGFvDQoNCj4gDQo+IFRvbQ0KPiAN
Cj4gPiBIYW8NCj4gPg0KDQo=
