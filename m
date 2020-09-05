Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18925E7FD
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIENkV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 09:40:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:1787 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgIENj3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 5 Sep 2020 09:39:29 -0400
IronPort-SDR: vkSo6TQefU5x6/oo+lNRDNM2/x4TZFPYZenT8xH/waVVu/lndsXHRR9u/XHLKC6CjuNfIhiPeq
 Uv3dW/B7S5yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155363723"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="155363723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 06:39:23 -0700
IronPort-SDR: Pu5JTQ/1SogNxEW351vDf+ozvCIml0cBGi40etkEE3ZN/t7pX2k6jZZk087wxMxGURousWX3/q
 dxX0SSVjLrjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="316237171"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Sep 2020 06:39:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Sep 2020 06:39:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 5 Sep 2020 06:39:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 5 Sep 2020 06:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT4EXlJZHpZtxzqc4g1ATVGEIDKRCpXEsaheV3IRQQc0/ZBYZQpdEF94NL2XewfJlcSu/I2J+Q0CRn2RzO4jSAW+W6uiYXHZgCxMC9xOxeJPslSZ9DnXrSAe4TPZqrifgkwFR1fpDPPs9AeDGm00NrRjkLda7vjcDW+G4J66KPzgG4ypZaWqVwLNIC6ZM4ksY7Hy2w3/n/hvsZwcMQDEj8gldDzcHjTwIoqIXXXN+BMDxRs+zPVinYIrOsjt9Bsi0s7AxKq/FV7GptsYI9KNPW0Bk1PBmEj/OaBFoCR/4cBXR1jZ+MysmZOWOsdBsEmUtdfj23nnMU8AsHZAvvVbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4zWbK6PgD0uoqs5mGKBzD0cSuhRK26llirMwmnpJy0=;
 b=ZksBogxF88fmR1K+VsFACL9yRZfx77GBWdu9DfQhABA/xqWN9tstucvBwVHPRofAMkcg4Girs91adeR65FyVOT5zcw4zL3ZYEhNk2L3vcGAJhMJ+G9Rlyl65YdoIPOoE3pnTbhn+24OLE9E9CTCRQWh0xZ0G+qgRFmsDY2z3q/zYzjOfXz9W7DTG80mTr9VqcwdzdE8HVdUTDH13ZyvOqJcuLth/rCEDKDN2R4xeBGendV7/EqceEvlLW8kd/9Y7Rk/FjhiCGs0P+BP65a1I6PKLFy1KBKcdMPBJwkzwcqSDnxyHVMtWfnYC/13Nd2n0CWppKv0rhuUUV7NSNg+uhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4zWbK6PgD0uoqs5mGKBzD0cSuhRK26llirMwmnpJy0=;
 b=bPa0lMgH5ugkEKEJfSGhgG7ttRQs32qpOuGrPmstfNp5c9zT33S5zIT7eAY2nRdgKGwiTr1Xp//4/31Ex988dOauuh2fOiwMsyZi/UA64xMbQlR+NHGPp170oY/U7ODDKFp4zPfQ4oyzv+Lru5uW41yPls/2Xl8dKwkNxmYPBls=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3817.namprd11.prod.outlook.com (2603:10b6:5:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Sat, 5 Sep
 2020 13:39:20 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3348.017; Sat, 5 Sep 2020
 13:39:19 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v1 01/12] fpga: fpga security manager class driver
Thread-Topic: [PATCH v1 01/12] fpga: fpga security manager class driver
Thread-Index: AQHWgxa1h9ciP5la3kGmVnu8RretTKlZL1sAgAAGBgCAAM+KoA==
Date:   Sat, 5 Sep 2020 13:39:19 +0000
Message-ID: <DM6PR11MB3819EC0246B210F32C3EE12B852A0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
 <20200905002324.GA3157@epycbox.lan>
 <58a1b51a-4c01-248f-1ee7-fc541e417b44@intel.com>
In-Reply-To: <58a1b51a-4c01-248f-1ee7-fc541e417b44@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d25f2027-7d2b-4300-c852-08d851a11788
x-ms-traffictypediagnostic: DM6PR11MB3817:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB38174D1753E41D3354E32B50852A0@DM6PR11MB3817.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHQTxIl7Na4Hdve+7tDW2nJRYM47XjRcDgoeHY96bS4iLKRS5HMs/HatDZo7SDVtuFOS9C4VKwP1WUIquvf7JjgH65ab9ZtNk9lJlcsJI9hzZJS7P4x9uU0+vHpuSjKNyK1DYqkgzKEAYeN9VB0Lb05cEfOxZkRLdUzdyYUzD3v2JVQkSjDOR+K4f5B8NE2vIh3MtIrvzDwi75snSzjRYHxaQT+GF4tygkMseKcgwQGveiwvK3MSw/8RM0/jCrSzf0LuNLFl1ORAbWxPd6Bo25g1c/cA+478OOQsffmN2I03Sbf4XzCCJNse07012cPKziaoHwhS1Ezi1qclYG6zxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(54906003)(86362001)(4326008)(33656002)(478600001)(71200400001)(52536014)(66446008)(316002)(83380400001)(76116006)(66946007)(64756008)(66556008)(2906002)(66476007)(55016002)(5660300002)(6506007)(110136005)(186003)(53546011)(26005)(107886003)(9686003)(8936002)(8676002)(7696005)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /uFkA0zuwkCExXQzJmcL4++rwXp0qF41vxhO8hAtPQqUjrWpYbyByvD+f3zNKHTkWzebIQqJy1+TJZPAo0iPcPvN6E86A7Ak/+a8HEb3yr2n+r1l7lsPlNTm07YiCv2a56lwUp0fYNGhnPzloTvi3kNZsGgClPFHQ8MUbt7PuF+vflM/nL/z8FjQy/HKf6CkOi3hsksZSBjamW115rcBSwcnWQ2REI0m+J5Gx9wiJuBLd0l21qiTVQx99+uXKfna6RWUWl7MzvmWgFL/c8gQx2URywiv2X5wv3uJLsV0RuLtYhR/rsZZEUKguVw5rbdT9KdVsfqBrJIVd1pqm1/fQ02PjXBzm2ufn7dfbcD3GF/UA4v263GJDRhEcKhUIPUNesJj5b0aj+3ogdHmRK/Rgt8/6oeCZvaJ+V2yIVMdECyiZi5du5Zc6mgkIK9M5V7LQHibZOZ+u/5fzg7fCZV9LXxFs8s6HCjDsf2cX60XWKgxjvU9vP9QNoCulSNepDcwmJvDKSejg5o6B0upUx2IuOEV9Y8S1HAT3ohwZy7YcuwY+IJNQSihdA3Z3cG0caLJ4ajHI1QVXvn8wEu/TuxBK0kRHm3Z19B1ngYuu0zdzdBsOUTQU7+iNxmPaVSrJLCPwuVQ7ipz336JU4skKWEGXg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f2027-7d2b-4300-c852-08d851a11788
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 13:39:19.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TN5Z6kJ2PrvAI9bN2t6QnPjbufRghOM6NY313OW9ILNYfjhyjUmB0wrc6BmdSHijm9txIgBeUDTJ82WtEo0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3817
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA5LzQvMjAgNToyMyBQTSwgTW9yaXR6IEZpc2NoZXIgd3JvdGU6DQo+ID4gSGkgUnVzcywN
Cj4gPg0KPiA+IE9uIEZyaSwgU2VwIDA0LCAyMDIwIGF0IDA0OjUyOjU0UE0gLTA3MDAsIFJ1c3Mg
V2VpZ2h0IHdyb3RlOg0KPiA+PiBDcmVhdGUgdGhlIEludGVsIFNlY3VyaXR5IE1hbmFnZXIgY2xh
c3MgZHJpdmVyLiBUaGUgc2VjdXJpdHkNCj4gPj4gbWFuYWdlciBwcm92aWRlcyBpbnRlcmZhY2Vz
IHRvIG1hbmFnZSBzZWN1cmUgdXBkYXRlcyBmb3IgdGhlDQo+ID4+IEZQR0EgYW5kIEJNQyBpbWFn
ZXMgdGhhdCBhcmUgc3RvcmVkIGluIEZMQVNILiBUaGUgZHJpdmVyIGNhbg0KPiA+PiBhbHNvIGJl
IHVzZWQgdG8gdXBkYXRlIHJvb3QgZW50cnkgaGFzaGVzIGFuZCB0byBjYW5jZWwgY29kZQ0KPiA+
PiBzaWduaW5nIGtleXMuDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggY3JlYXRlcyB0aGUgY2xhc3Mg
ZHJpdmVyIGFuZCBwcm92aWRlcyBzeXNmcw0KPiA+PiBpbnRlcmZhY2VzIGZvciBkaXNwbGF5aW5n
IHJvb3QgZW50cnkgaGFzaGVzLCBjYW5jZWxlZCBjb2RlDQo+ID4+IHNpZ25pbmcga2V5cyBhbmQg
Zmxhc2ggY291bnRzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSdXNzIFdlaWdodCA8cnVz
c2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5
aWx1bi54dUBpbnRlbC5jb20+DQo+ID4gQXMgZm9yIFJldmlld2VkLWJ5IHRhZ3MgSSBoYWQgc2Vl
biBvbiBvdGhlciBwYXRjaGVzIGluIHRoZSBzZXJpZXMsIEknZA0KPiA+IHByZWZlciBmb3IgdGhh
dCB0byBoYXBwZW4gb24gcHVibGljIG1haWxpbmcgbGlzdHMuIElmIEhhbyByZXZpZXdlZA0KPiA+
IHBhdGNoZXMgb24gc29tZSBpbnRlcm5hbCBJbnRlbCBsaXN0IEkgd29uJ3Qga25vdyBhYm91dCBp
dCwgc28gcGxlYXNlDQo+ID4gaGF2ZSBoaW0gcHJvcGVybHkgQWNrL1Jldmlld2VkLWJ5IHRhZyB0
aGluZ3Mgb24gYSBwdWJsaWMgbWFpbGluZyBsaXN0Lg0KPiANCj4gU3VyZSAtIEknbGwgcmVtb3Zl
IHRoZSBBY2svUmV2aWV3ZWQtYnkgdGFncyB0aGF0IHdlcmUgYWRkZWQgaW50ZXJuYWxseQ0KPiBi
ZWZvcmUgSSBzdWJtaXQgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2hzZXQgKGV4Y2VwdCB3
aGVyZSBIYW8NCj4gcmUtYWRkcyB0aGVtIG9uIHRoZSBwdWJsaWMgbGlzdCBkdXJpbmcgdGhpcyBy
ZXZpZXcgY3ljbGUpLg0KDQpZZXMsIHBsZWFzZSByZW1vdmUgaXQgdG8gYXZvaWQgY29uZnVzaW5n
LiBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBsYXRlc3QgY29kZSB5ZXQuDQpBbnl3YXksIGxldCdz
IGZvbGxvdyB1cCB0aGlzIGluIHB1YmxpYyBtYWlsaW5nIGxpc3QuDQoNClRoYW5rcw0KSGFvDQo=
