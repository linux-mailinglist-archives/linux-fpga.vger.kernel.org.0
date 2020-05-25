Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C61E04AA
	for <lists+linux-fpga@lfdr.de>; Mon, 25 May 2020 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgEYCZX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 24 May 2020 22:25:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:6056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388110AbgEYCZX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 24 May 2020 22:25:23 -0400
IronPort-SDR: uBWSV0cLtw3UOrXHL5jo3SO9vR61ysI0OgYLr6O+04lwEqnpHpFbdN8CUzyXOLjU1x1rnXsw5b
 SZ5eHGoqFjhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 19:25:22 -0700
IronPort-SDR: jSyIO3tTBjLwSTh6VwobaXw2GP8TBHokF5MImDONpj5J+TFAgfTENpEv5USQsoy1s+78M8PHf2
 0uEwdE5gwntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="301291516"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 24 May 2020 19:25:22 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 24 May 2020 19:25:22 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 24 May 2020 19:25:21 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 24 May 2020 19:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le9zq8g3ZipSB8OVwyYIyikfB6vJmfMK+GOho2SEBT1fKAtj+Hd0lpuGfYoOK4xPjFnwwYwYNVnoErbNoGm9LhXZQi9cYMKKGhtQbtqhVO4yn4m8QZ+ny7zU7NBA3Tk6n5t55kd4NS8G1dPWqpqdnGKZ1uxSr6URX/2ir8+UZzHwHSmLN5/lbr6q34csZhuM5eZkoKhwcVaLj/BdBp+yKQ6WXNAJ5nvEGPZer8eLTcUV9It3GGa1I5vfE1yfMvsmfVC/XXwyOg52ku7nZu9YSIPCPoOf4/FIkAuLr0OreJ6nANCScUNTDAcaFmXYcie7PRT9V8kKb13AX2+qL4RXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgpKT2DkCav6gefYtHAcaXCmMQP2gkpqxYaWbWm5A1g=;
 b=L5zUjN/vCgf6CQXKnagDMg2Wnf3h/jUt7jpxKh0/rIEslQIiKOAtBtkRUnIKmlWEcN/ov8wQL95pvqAiljbk3U1CRjVxPzUD+DuFKeLcCuG+h/kAaaWzY3lA/w3ioM5g/KM5rHqP1p0i5DaNRWWDYfGj75oCthjF54F7m6SmZ/JbucG91yfVu6LDlp2ippbaTLG18EuEriF8OD5zh0cm2sYlFxO56JyBFeVAb2OnXLRmUYQgcxYoyovGrwqsNnnaWp12Au1bIyrtupZs21ENhUryQFYvne4osOyTg2RMWVrSm7R9s0d9rKFmJr4eUU3/n+jvJh7NJoU6SL5+lB42yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgpKT2DkCav6gefYtHAcaXCmMQP2gkpqxYaWbWm5A1g=;
 b=SvzkzUYfP8SNJudVRZiazj5DFttxMHhcaZF2KAffvt8S6vZZ8i9ysKBgh/aL/TAzbqK88cpmTeqyW5oIC19qr5+WUrPqrqa/6E3aaAu5YBKpY0dDiCfWYweW2HfeVY0j63bg4FPhMqbhTZzQ6jcrjAOPw8bpzQ4EtBKdpwqTGY4=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3147.namprd11.prod.outlook.com (2603:10b6:5:64::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 02:25:18 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 02:25:18 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>, Moritz Fischer <mdf@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Thread-Topic: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Thread-Index: AQHWLho4jijS6ibGYkGv5+54CQyYuKi07XMAgAE/1ICAAAoJAIAB39lg
Date:   Mon, 25 May 2020 02:25:18 +0000
Message-ID: <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
 <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
In-Reply-To: <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad374131-29cd-4168-07bb-08d80052de0c
x-ms-traffictypediagnostic: DM6PR11MB3147:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31473D5BC44395AF8E9E743285B30@DM6PR11MB3147.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQ+oriQs8+QB2wYDa0f4dLi9TrWW7eWNM7u6KvBXsaAMjklRC9kKv0AQnaDK3zyIijQNJ8ppK3uzaB7wwpt81jOEjP/3VSG8vU6PLH5LGZPMwpezVdLvMjFg4VlYS8QgAi5Jbp7FM9qHHSSzpdLxYQL6P6WExB+om8Dl9Pz6qzf6zZmSeiKgllfTW410iFW3iLQD6OQPoG6a4BOQckKRS8cKZJ0x9yd98gPf5xFtMMYkNQ28tQt1AlOBP4xSQM97k7BdkQjxUnwGDbCt8YA95TpBmjDkJIcobsB2AJArFJrdoRnj5xeQTbJmEMQgjzd7xpMB75Lb23CvRecMWLVG4NI1N5hO0I3yeuFJ8TnGfTHztNZEqGh19nfIBsdrwpUDERGEKjb93lv1xvf6qD7LlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(86362001)(66446008)(71200400001)(76116006)(8676002)(66476007)(8936002)(2906002)(4744005)(64756008)(9686003)(33656002)(4326008)(6506007)(186003)(7696005)(316002)(66946007)(55016002)(52536014)(66556008)(5660300002)(966005)(54906003)(26005)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ffGsoXoSm3fWB0JQGS71sowD1YzoJ5R3y3rt6W+gu8cOswqbUU0dCQoqcRz0FTixR/ZWCmUKgcJRpGI9QKj87ONYjiBd/nzqIH4edQ0AStp9kLbMdEoon6BHmtR/Z0QSsxWAD/9WMRU6Fq7L5C4S098VZ8OeTu6sySpyAhvnSFBc89Jws5PXJcWxOvcYvw9HBwdGiChUqpUARnFnPKxZpvkd71TQykkSvjXgJkYHtfKTMxHVtV/nlPSM8F9SiCciREL61g3TEuBY3uCzmmfXKsOA6za56Le1SEo0d6Z4XvXBs1CQYP1lnJ9hGyeb21WK8sC+6D3VmEXLCXqm1TO2t0xzfcTh5r/3ynSVWhpQecD+XrY4u0zOC4uUR9JtS5O7zSmJui4n6GY6orjil5F7NcKcjvTQ+vxn5AUE0N3Foy1QKXPzYka1AJ75D8CUEgalKjPhUjPI0KTXs8TFAg+I45d5YtFKzUTMAcMMQlEyjHI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad374131-29cd-4168-07bb-08d80052de0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 02:25:18.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZV9IwLM3fT80PtXJ7hBSkZkM13rjuhOqNvwrdEOc6Lv416J414BMp+AypDcd7K4KRaFM+1c4CBAHvMEeBOQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3147
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+PiBIaSBNb3JpdHogYW5kIEZQR0EgZGV2ZWxvcGVycywNCj4gPj4NCj4gPj4gSXMgdGhpcyBP
Sz8gQW5kIGlmIHNvLCBpcyBpdCBnb2luZyBpbnRvIHlvdXIgZ2l0IHRyZWU/IE9yIHNob3VsZCBJ
DQo+ID4+IHNlbmQgaXQgdXAgdGhyb3VnaCBhIGRpZmZlcmVudCB0cmVlPyAoSSdtIG5ldyB0byB0
aGUgRlBHQSBkZXZlbG9wbWVudA0KPiA+PiBtb2RlbCkuDQo+ID4NCj4gPiBJIGNhbiB0YWtlIGl0
LCBzb3JyeSBmb3Igc2x1Z2dpc2ggcmVzcG9uc2UuDQo+ID4NCj4gDQo+IFRoYXQncyBncmVhdCBu
ZXdzLCB0aGFua3MgTW9yaXR6ISBTb3JyeSB0byBiZSBwdXNoeSwganVzdCBkaWRuJ3Qgd2FudCBp
dA0KPiB0byBnZXQgbG9zdC4gOikNCg0KVGhhbmtzIEpvaG4gZm9yIHRoaXMgcGF0Y2gsIGFuZCB0
aGFua3MgTW9yaXR6IGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzLg0KU29ycnkgZm9yIGxhdGUgcmVz
cG9uc2UsIG9uZSB0aGluZyBoZXJlIHdlIG1heSBuZWVkIHRvIGJlIGNhcmVmdWwgaXMNCmEgcmVj
ZW50IGJ1ZyBmaXhpbmcgcGF0Y2gsIHRoYXQgZml4aW5nIHBhdGNoIGhhcyBiZWVuIG1lcmdlZCBi
eSBHcmVnDQppbiBjaGFyLW1pc2MtbmV4dCB0cmVlLCBhbmQgbWF5IGhhdmUgc29tZSBjb25mbGlj
dCB3aXRoIHRoaXMgb25lLg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ncmVna2gvY2hhci1taXNjLmdpdC9jb21taXQvP2g9Y2hhci1taXNjLW5leHQm
aWQ9YzlkN2UzZGExZjNjNGNmNWRkZGZjNWQ3Y2U0ZDc2ZDAxM2FiYTFjYw0KZnBnYTogZGZsOiBh
ZnU6IENvcnJlY3RlZCBlcnJvciBoYW5kbGluZyBsZXZlbHMNCg0KSSBndWVzcyB3ZSBuZWVkIHRv
IHJlYmFzZSB0aGlzIHBhdGNoIG9uIHRvcCBvZiBpdD8NCk1vcml0eiwgZG8geW91IGhhdmUgYW55
IHN1Z2dlc3Rpb24/DQoNClRoYW5rcw0KSGFvDQoNCj4gDQo+IHRoYW5rcywNCj4gLS0NCj4gSm9o
biBIdWJiYXJkDQo+IE5WSURJQQ0K
