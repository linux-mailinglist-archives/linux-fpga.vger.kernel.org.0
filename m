Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839D1B05CC
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Apr 2020 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTJia (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Apr 2020 05:38:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:14685 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTJi3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Apr 2020 05:38:29 -0400
IronPort-SDR: oSTr0bdfOdfJ4EdU9bExs8z04Afh2818AGwV8iMqgPO9yUoX36VUTUBE15ohfAjwk8kwrwS5Cf
 m4Tvp7NCti1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 02:38:28 -0700
IronPort-SDR: 8ha4HdFa8zNYj2UX/c9bSGsdO5Qq64x/3Z5oKD6Gur5kLqz/zWivp6+dmwOLgIJTsQdug2I3Lu
 HyeQtQfjWi8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="246850742"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 02:38:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 02:38:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 02:38:27 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 02:38:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 02:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i23+USnMjoRgpJZvolnDZ+JbZeTUnKAtWeL7/7BOn87e/D5mBRbY6QsF3NtbUQ9KcoKSVC44Bad3Kqz8C3ec0zYsP2176X+AcGm/hDFo9gg+3Ltwgx2k2MzIgCc+UmfMSg4lp2m25KNNjDRab+JEMgyRUty1pIis0+elo90lydUuFOS+LlPOKo+lStJAx+KXyNSNvO2pZf2F6KGgptBnG0TE9DG0TKBG+qhJVnwtgsBBkong7rwTkSjlBfjLZDGWbDvT7QqgNxoFrRE7haQ3CIlssIHdynLuLCHHQGZOawS1Us+EG4tfLDI/dwiLcX/u4LVOi54vkJGCRDZG37PDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5amZMiA81f5uXA5mbxGzrVn59QJamATnVjADlCiRG1E=;
 b=NPUKI1WfrHPvUtfO3bMWElfEP0MsqomSfA+YuWTnNLmBsPXgNhgb8PSA2dRygmJLSmWD9TQAgIUD91KsLCKSDWalHp4uzeGFOi9auUQ/lSHIIJJz8j2quGBd1uUXmp1lkxbbE0pJZrHFe+GyQzz1iMXB70zXj810ghFvrIgUxi9t52Cg688WnOtOwcx3JTIGCA2RE1V/T69bCpjqUsA/nce8T4uRFg4XCyEJGzanHk6ZYl5chhSsiJOBMLg30shnNgBzXFwiF0sGlrCJjBw++/4Fwl0h+3EdNZ5tknn3NjUf/4N3JZ1HAdze5JazUEa0xc0GjdwvhYY/idSNl6qQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5amZMiA81f5uXA5mbxGzrVn59QJamATnVjADlCiRG1E=;
 b=BknyulnhZtg1W5kO7x6PxbYjq0sYmqLN3E3zNQUAgi1/cyLy7NDmwqONF7UI1+GvwdTiyfKpDQEH7a+8hQY2BAed2QXg7UywpLNg1Q/cFTty55eLpiuV8T/U5srvOe6Ac7yvlOYAknT2RLKJ/YUv3wtnJJmpLrDLWnh5fT6I7vc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Mon, 20 Apr 2020 09:38:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 09:38:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>
Subject: RE: [PATCH v9 1/2] Documentation: fpga: dfl: add description for
 performance reporting support
Thread-Topic: [PATCH v9 1/2] Documentation: fpga: dfl: add description for
 performance reporting support
Thread-Index: AQHWFH3Ip3hxvgITkkaIMdlGNptyz6h+AcWAgAO7prA=
Date:   Mon, 20 Apr 2020 09:38:21 +0000
Message-ID: <DM6PR11MB3819F027E924AFEB3199165485D40@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587102000-18262-1-git-send-email-hao.wu@intel.com>
 <1587102000-18262-2-git-send-email-hao.wu@intel.com>
 <8aa60f7e-68d4-ca41-403f-37f430ce05c1@infradead.org>
In-Reply-To: <8aa60f7e-68d4-ca41-403f-37f430ce05c1@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hao.wu@intel.com; 
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad59efc8-dd5e-4dd2-8da0-08d7e50e907c
x-ms-traffictypediagnostic: DM6PR11MB4124:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4124E4D64399C970E892FA0185D40@DM6PR11MB4124.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(136003)(396003)(366004)(376002)(26005)(53546011)(54906003)(110136005)(478600001)(6506007)(55016002)(9686003)(7696005)(7416002)(8676002)(81156014)(8936002)(66446008)(64756008)(86362001)(66476007)(66556008)(76116006)(66946007)(71200400001)(4326008)(316002)(5660300002)(33656002)(2906002)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Jo/j0sAmlD8AwXUvoQicLc8MzNXhC8lTMbItUkz/zsSavt+2J8jfep5pDhzj04nskUODnA+dgg2xrZORThrKbeBEe48bb8+j4jr4HrxAATtAHid7RFx2BC4qJiT1huJ9txQy6ngR4+PRwZz8GeBP2dOYGY7vxWlGadpKdNgXu6LaDUKtuUCyAIFSFEwxmxcxKWkozXrIqEs5yvd8M01vLEFIk6OKfcSkrUt31+etVj/z71MTgGKaePnrwXPhIz+/8tENm0237fvJe7t4bo4k/X/Xo7aqAhZKMnZlrPGOY0eX3KRslPKR2NeyDed0gUaiXyvyD32dPTQmvVVnFz3r+GJh6gfCwhZhshhBUx9FURN3aVW8xWeUplouggLljVRt7CYUdn3c3rnaw+TsiJQX77ogT3zSGnQIaryuDxxgES8oxrQVJvyPPnaIS0vOuK5
x-ms-exchange-antispam-messagedata: tnb4Hog284tEPVzFaCODcHSfdyRym9oPRdeFYO6P+VlQPzZLxEWAvRhZAuuwLjDnhYjgaJlgfhSr89JddvuLQwG/PQ6iMsPsx4iW/Xp+KrMnOeTPZHF+sxb0RDpmWqioqmUr18OleHPY7Yoo2j7uvA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad59efc8-dd5e-4dd2-8da0-08d7e50e907c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 09:38:21.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/LfOb1HHzmP1/hWmnHXgxuQQOfOtA/aPgkwCGpIqPdXJGRF6URPCP8f8reQvg2AlXKrHllwRhMMmqz0t1Ptlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4124
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1mcGdhLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZnBnYS1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBSYW5keSBEdW5sYXANCj4gU2VudDogU2F0dXJkYXksIEFwcmlsIDE4LCAyMDIwIDg6
MDggQU0NCj4gVG86IFd1LCBIYW8gPGhhby53dUBpbnRlbC5jb20+OyB3aWxsQGtlcm5lbC5vcmc7
IG1kZkBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtYXBpQHZnZXIua2VybmVsLm9yZzsgYXR1bGxA
a2VybmVsLm9yZzsgWHUsIFlpbHVuDQo+IDx5aWx1bi54dUBpbnRlbC5jb20+OyB0cml4QHJlZGhh
dC5jb207IGJodUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMS8yXSBEb2N1
bWVudGF0aW9uOiBmcGdhOiBkZmw6IGFkZCBkZXNjcmlwdGlvbiBmb3INCj4gcGVyZm9ybWFuY2Ug
cmVwb3J0aW5nIHN1cHBvcnQNCj4gDQo+IEhpLS0NCj4gDQo+IEhlcmUgYXJlIGEgZmV3IGNvbW1l
bnRzIGZvciB5b3U6DQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIGNvbW1lbnRzLCB3aWxsIGZpeCBh
bGwgb2YgdGhlbSBpbiB0aGUgbmV4dCB2ZXJzaW9uLiA6ICkNCg0KSGFvDQoNCg0KPiANCj4gT24g
NC8xNi8yMCAxMDozOSBQTSwgV3UgSGFvIHdyb3RlOg0KPiA+IEZyb206IFh1IFlpbHVuIDx5aWx1
bi54dUBpbnRlbC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgZGVzY3JpcHRpb24gZm9y
IHBlcmZvcm1hbmNlIHJlcG9ydGluZyBzdXBwb3J0IGZvcg0KPiA+IERldmljZSBGZWF0dXJlIExp
c3QgKERGTCkgYmFzZWQgRlBHQS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5
aWx1bi54dUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV3UgSGFvIDxoYW8ud3VAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2ZwZ2EvZGZsLnJzdCB8IDg0DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2ZwZ2EvZGZsLnJzdCBiL0RvY3VtZW50YXRpb24vZnBnYS9kZmwucnN0DQo+ID4g
aW5kZXggMDk0ZmM4YS4uNmNjYWY3NyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Zw
Z2EvZGZsLnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZnBnYS9kZmwucnN0DQo+IA0KPiA+
IEBAIC0zNzgsNiArMzgzLDg1IEBAIFRoZSBkZXZpY2Ugbm9kZXMgdXNlZCBmb3IgaW9jdGwoKSBv
ciBtbWFwKCkgY2FuDQo+IGJlIHJlZmVyZW5jZWQgdGhyb3VnaDo6DQo+ID4gIAkvc3lzL2NsYXNz
L2ZwZ2FfcmVnaW9uLzxyZWdpb25YPi88ZGZsLXBvcnQubj4vZGV2DQo+ID4NCj4gPg0KPiA+ICtQ
ZXJmb3JtYW5jZSBDb3VudGVycw0KPiA+ICs9PT09PT09PT09PT09PT09PT09PQ0KPiA+ICtQZXJm
b3JtYW5jZSByZXBvcnRpbmcgaXMgb25lIHByaXZhdGUgZmVhdHVyZSBpbXBsZW1lbnRlZCBpbiBG
TUUuIEl0DQo+IGNvdWxkDQo+ID4gK3N1cHBvcnRzIHNldmVyYWwgaW5kZXBlbmRlbnQsIHN5c3Rl
bS13aWRlLCBkZXZpY2UgY291bnRlciBzZXRzIGluDQo+IGhhcmR3YXJlIHRvDQo+ID4gK21vbml0
b3IgYW5kIGNvdW50IGZvciBwZXJmb3JtYW5jZSBldmVudHMsIGluY2x1ZGluZyAiYmFzaWMiLCAi
Y2FjaGUiLA0KPiAiZmFicmljIiwNCj4gPiArInZ0ZCIgYW5kICJ2dGRfc2lwIiBjb3VudGVycy4g
VXNlcnMgY291bGQgdXNlIHN0YW5kYXJkIHBlcmYgdG9vbCB0bw0KPiBtb25pdG9yDQo+ID4gK0ZQ
R0EgY2FjaGUgaGl0L21pc3MgcmF0ZSwgdHJhbnNhY3Rpb24gbnVtYmVyLCBpbnRlcmZhY2UgY2xv
Y2sgY291bnRlciBvZg0KPiBBRlUNCj4gPiArYW5kIG90aGVyIEZQR0EgcGVyZm9ybWFuY2UgZXZl
bnRzLg0KPiA+ICsNCj4gPiArRGlmZmVyZW50IEZQR0EgZGV2aWNlcyBtYXkgaGF2ZSBkaWZmZXJl
bnQgY291bnRlciBzZXRzLCBpdCBkZXBlbmRzIG9uDQo+IGhhcmR3YXJlDQo+IA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNldHMsIGRlcGVu
ZGluZyBvbiBoYXJkd2FyZQ0KPiANCj4gPiAraW1wbGVtZW50YXRpb24uIGUuZy4gc29tZSBkaXNj
cmV0ZSBGUEdBIGNhcmRzIGRvbid0IGhhdmUgYW55IGNhY2hlLg0KPiBVc2VyIGNvdWxkDQo+IA0K
PiAgICAgICAgICAgICAgICAgICAgRS5nLiwgc29tZQ0KPiANCj4gPiArdXNlICJwZXJmIGxpc3Qi
IHRvIGNoZWNrIHdoaWNoIHBlcmYgZXZlbnRzIGFyZSBzdXBwb3J0ZWQgYnkgdGFyZ2V0DQo+IGhh
cmR3YXJlLg0KPiA+ICsNCj4gPiArSW4gb3JkZXIgdG8gYWxsb3cgdXNlciB0byB1c2Ugc3RhbmRh
cmQgcGVyZiBBUEkgdG8gYWNjZXNzIHRoZXNlDQo+IHBlcmZvcm1hbmNlDQo+ID4gK2NvdW50ZXJz
LCBkcml2ZXIgY3JlYXRlcyBhIHBlcmYgUE1VLCBhbmQgcmVsYXRlZCBzeXNmcyBpbnRlcmZhY2Vz
IGluDQo+ID4gKy9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2VzL2RmbF9mbWUqIHRvIGRlc2Ny
aWJlIGF2YWlsYWJsZSBwZXJmIGV2ZW50cw0KPiBhbmQNCj4gPiArY29uZmlndXJhdGlvbiBvcHRp
b25zLg0KPiA+ICsNCj4gPiArVGhlICJmb3JtYXQiIGRpcmVjdG9yeSBkZXNjcmliZXMgdGhlIGZv
cm1hdCBvZiB0aGUgY29uZmlnIGZpZWxkIG9mIHN0cnVjdA0KPiA+ICtwZXJmX2V2ZW50X2F0dHIu
IFRoZXJlIGFyZSAzIGJpdGZpZWxkcyBmb3IgY29uZmlnLCAiZXZ0eXBlIiBkZWZpbmVzIHdoaWNo
DQo+IHR5cGUNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25maWc6ICJldnR5cGUiDQo+IA0KPiA+ICt0aGUgcGVyZiBldmVudCBiZWxvbmdzIHRv
LiAiZXZlbnQiIGlzIHRoZSBpZGVudGl0eSBvZiB0aGUgZXZlbnQgd2l0aGluIGl0cw0KPiANCj4g
ICAgICAgICAgICAgICAgICAgYmVsb25ncyB0bzsgImV2ZW50IiBpcw0KPiANCj4gPiArY2F0ZWdv
cnkuICJwb3J0aWQiIGlzIGludHJvZHVjZWQgdG8gZGVjaWRlIGNvdW50ZXJzIHNldCB0byBtb25p
dG9yIG9uIEZQR0ENCj4gDQo+ICAgIGNhdGVnb3J5OyAicG9ydGlkIiBpcw0KPiANCj4gPiArb3Zl
cmFsbCBkYXRhIG9yIGEgc3BlY2lmaWMgcG9ydC4NCj4gPiArDQo+ID4gK1RoZSAiZXZlbnRzIiBk
aXJlY3RvcnkgZGVzY3JpYmVzIHRoZSBjb25maWd1cmF0aW9uIHRlbXBsYXRlcyBmb3IgYWxsDQo+
IGF2YWlsYWJsZQ0KPiA+ICtldmVudHMgd2hpY2ggY2FuIGJlIHVzZWQgd2l0aCBwZXJmIHRvb2wg
ZGlyZWN0bHkuIEZvciBleGFtcGxlLA0KPiBmYWJfbW1pb19yZWFkDQo+ID4gK2hhcyB0aGUgY29u
ZmlndXJhdGlvbiAiZXZlbnQ9MHgwNixldnR5cGU9MHgwMixwb3J0aWQ9MHhmZiIsIHdoaWNoDQo+
IHNob3dzIHRoaXMNCj4gPiArZXZlbnQgYmVsb25ncyB0byBmYWJyaWMgdHlwZSAoMHgwMiksIHRo
ZSBsb2NhbCBldmVudCBpZCBpcyAweDA2IGFuZCBpdCBpcyBmb3INCj4gPiArb3ZlcmFsbCBtb25p
dG9yaW5nIChwb3J0aWQ9MHhmZikuDQo+ID4gKw0KPiA+ICtFeGFtcGxlIHVzYWdlIG9mIHBlcmY6
Og0KPiA+ICsNCj4gPiArICAkIyBwZXJmIGxpc3QgfGdyZXAgZGZsX2ZtZQ0KPiA+ICsNCj4gPiAr
ICBkZmxfZm1lMC9mYWJfbW1pb19yZWFkLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtL
ZXJuZWwgUE1VIGV2ZW50XQ0KPiA+ICsgIDwuLi4+DQo+ID4gKyAgZGZsX2ZtZTAvZmFiX3BvcnRf
bW1pb19yZWFkLHBvcnRpZD0/LyAgICAgICAgICAgICAgICBbS2VybmVsIFBNVSBldmVudF0NCj4g
PiArICA8Li4uPg0KPiA+ICsNCj4gPiArICAkIyBwZXJmIHN0YXQgLWEgLWUgZGZsX2ZtZTAvZmFi
X21taW9fcmVhZC8gPGNvbW1hbmQ+DQo+ID4gKyAgb3INCj4gPiArICAkIyBwZXJmIHN0YXQgLWEg
LWUgZGZsX2ZtZTAvZXZlbnQ9MHgwNixldnR5cGU9MHgwMixwb3J0aWQ9MHhmZi8NCj4gPGNvbW1h
bmQ+DQo+ID4gKyAgb3INCj4gPiArICAkIyBwZXJmIHN0YXQgLWEgLWUgZGZsX2ZtZTAvY29uZmln
PTB4ZmYyMDA2LyA8Y29tbWFuZD4NCj4gPiArDQo+ID4gK0Fub3RoZXIgZXhhbXBsZSwgZmFiX3Bv
cnRfbW1pb19yZWFkIG1vbml0b3JzIG1taW8gcmVhZCBvZiBhIHNwZWNpZmljDQo+IHBvcnQuIFNv
DQo+ID4gK2l0cyBjb25maWd1cmF0aW9uIHRlbXBsYXRlIGlzICJldmVudD0weDA2LGV2dHlwZT0w
eDAxLHBvcnRpZD0/Ii4gVGhlDQo+IHBvcnRpZA0KPiA+ICtzaG91bGQgYmUgZXhwbGljaXRseSBz
ZXQuDQo+ID4gKw0KPiA+ICtJdHMgdXNhZ2Ugb2YgcGVyZjo6DQo+ID4gKw0KPiA+ICsgICQjIHBl
cmYgc3RhdCAtYSAtZSBkZmxfZm1lMC9mYWJfcG9ydF9tbWlvX3JlYWQscG9ydGlkPTB4MC8gPGNv
bW1hbmQ+DQo+ID4gKyAgb3INCj4gPiArICAkIyBwZXJmIHN0YXQgLWEgLWUgZGZsX2ZtZTAvZXZl
bnQ9MHgwNixldnR5cGU9MHgwMixwb3J0aWQ9MHgwLw0KPiA8Y29tbWFuZD4NCj4gPiArICBvcg0K
PiA+ICsgICQjIHBlcmYgc3RhdCAtYSAtZSBkZmxfZm1lMC9jb25maWc9MHgyMDA2LyA8Y29tbWFu
ZD4NCj4gPiArDQo+ID4gK1BsZWFzZSBub3RlIGZvciBmYWJyaWMgY291bnRlcnMsIG92ZXJhbGwg
cGVyZiBldmVudHMgKGZhYl8qKSBhbmQgcG9ydCBwZXJmDQo+ID4gK2V2ZW50cyAoZmFiX3BvcnRf
KikgYWN0dWFsbHkgc2hhcmUgb25lIHNldCBvZiBjb3VudGVycyBpbiBoYXJkd2FyZSwgc28gaXQN
Cj4gY2FuJ3QNCj4gPiArbW9uaXRvciBib3RoIGF0IHRoZSBzYW1lIHRpbWUuIElmIHRoaXMgc2V0
IG9mIGNvdW50ZXJzIGlzIGNvbmZpZ3VyZWQgdG8NCj4gbW9uaXRvcg0KPiA+ICtvdmVyYWxsIGRh
dGEsIHRoZW4gcGVyIHBvcnQgcGVyZiBkYXRhIGlzIG5vdCBzdXBwb3J0ZWQuIFNlZSBiZWxvdyBl
eGFtcGxlOjoNCj4gPiArDQo+ID4gKyAgJCMgcGVyZiBzdGF0IC1lDQo+IGRmbF9mbWUwL2ZhYl9t
bWlvX3JlYWQvLGRmbF9mbWUwL2ZhYl9wb3J0X21taW9fd3JpdGUsXA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9ydGlkPTAvIHNsZWVw
IDENCj4gPiArDQo+ID4gKyAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3
aWRlJzoNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgMyAgICAgIGRmbF9mbWUwL2ZhYl9t
bWlvX3JlYWQvDQo+ID4gKyAgIDxub3Qgc3VwcG9ydGVkPiAgICAgIGRmbF9mbWUwL2ZhYl9wb3J0
X21taW9fd3JpdGUscG9ydGlkPTB4MC8NCj4gPiArDQo+ID4gKyAgICAgICAxLjAwMTc1MDkwNCBz
ZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+ICsNCj4gPiArVGhlIGRyaXZlciBhbHNvIHByb3ZpZGVz
IGEgImNwdW1hc2siIHN5c2ZzIGF0dHJpYnV0ZSwgd2hpY2ggY29udGFpbnMgb25seQ0KPiBvbmUN
Cj4gPiArY3B1IGlkIHVzZWQgdG8gYWNjZXNzIHRoZXNlIHBlcmYgZXZlbnRzLiBDb3VudGluZyBv
biBtdWx0aXBsZSBDUFVzIGlzIG5vdA0KPiAgICBDUFUNCj4gDQo+ID4gK2FsbG93ZWQgc2luY2Ug
dGhleSBhcmUgc3lzdGVtLXdpZGUgY291bnRlcnMgb24gRlBHQSBkZXZpY2UuDQo+ID4gKw0KPiA+
ICtUaGUgY3VycmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBzYW1wbGluZy4gU28gInBlcmYg
cmVjb3JkIiBpcw0KPiB1bnN1cHBvcnRlZC4NCj4gPiArDQo+ID4gKw0KPiA+ICBBZGQgbmV3IEZJ
VXMgc3VwcG9ydA0KPiA+ICA9PT09PT09PT09PT09PT09PT09PQ0KPiA+ICBJdCdzIHBvc3NpYmxl
IHRoYXQgZGV2ZWxvcGVycyBtYWRlIHNvbWUgbmV3IGZ1bmN0aW9uIGJsb2NrcyAoRklVcykgdW5k
ZXINCj4gdGhpcw0KPiA+DQo+IA0KPiB0aGFua3MuDQo+IC0tDQo+IH5SYW5keQ0KDQo=
