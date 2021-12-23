Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180947DED9
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Dec 2021 07:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhLWGDQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Dec 2021 01:03:16 -0500
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:51648
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232083AbhLWGDO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Dec 2021 01:03:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtLiqb2yRkImYc0gPFVPMkJsoJklYtaGaHS+x+e87GSqyVJ85tt/lENJP9TNq4r+WuA5DbEFNHNY5+7VKpvCzYLZ8czbLgat1GMVmFv3VYybemmj3uVSEMqzfMducZeBCMMiRNj7z2yCHzH6tDtWeiG0G1ZBhJotSYk6KTb3eezjo5SJtf2IdJWAQDf+UepQi54O1wzw0c0SpVzBYxcDza43wNU1u7W7Ut8DnD1ph6vdd41eXFfFe7llKbhXeBKq7IQ0CpdZsjwslwK1yqd99yfrJQQBYyKJkJT5smK4W2sHL5uV7zUoGnArkOXdgDxX3kV89Fz8oOrpU2aaV2wQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+M5793UNXobjyO2JaHen7nJYF4UBGZAkeN/CYnf5nY=;
 b=VausISH3y5eN8tK1V+AsnK8vRnIMQ6Shi+s5B9RvTMX/8ag8Ta7TGGONlAUziwlGVWYSFTO/VGry+mDDI4/ZDz/yBvh8Qbe+s6Tq+wIMk+SSuivOW+GJswLVz7eN+vw+BAPzl3VVXq5kXdBD9AIdqgrp/U+A4Ksleb7RI3QdrvWDLSOm8M520LPdWLBJ2egiB3iQvc+X1BomiEB5qXBrQ3T/02CSgxd+AxWqSGAhl46GOXcUk42i6RD5qpg/cqe/OxBjAalUFDfwwnuqrgZtDDUu6HmJhikY/8VfYPHb5/fVCZ0Lbd5jrMSaKZt3mTZ9nBcgaMlLbBTN3VwFRPRX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+M5793UNXobjyO2JaHen7nJYF4UBGZAkeN/CYnf5nY=;
 b=VZVriYi1KAazqiH/2f9uQewPz4QlXD/af22TYosDASR1/ZNuegXPs/a+tWy54tt6QkLA1XJt+dXuCGO52wYBFb7cEB4WBZuw7hOr76PyxvlB3KHkHykto3Yy/5WMIEz0+Zp0wX7hIAVpmTmHPyuzmu6ZUSFRqjr96nv9CWflwKE=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by SN4PR0201MB3614.namprd02.prod.outlook.com (2603:10b6:803:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 06:03:12 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::54f7:6167:eb45:4e49]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::54f7:6167:eb45:4e49%4]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 06:03:11 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     "simon.doppler@fastree3d.com" <simon.doppler@fastree3d.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
CC:     "adrian.fiergolski@fastree3d.com" <adrian.fiergolski@fastree3d.com>
Subject: RE: Partial reconfiguration on ZynqMP
Thread-Topic: Partial reconfiguration on ZynqMP
Thread-Index: AQHX9xf8YuDjuh7rxE+gqTpCTnV5P6w/lSYw
Date:   Thu, 23 Dec 2021 06:03:11 +0000
Message-ID: <SN6PR02MB4576F9F6F7710989F8EDAE16C27E9@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <23cf0454cadc24bc0fd7d898ab3d4bd4dfd95bac.camel@fastree3d.com>
 <BYAPR02MB3925AB4E544B1E93232A4BB2D97D9@BYAPR02MB3925.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB3925AB4E544B1E93232A4BB2D97D9@BYAPR02MB3925.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a06dac6a-42b7-4165-8257-08d9c5d9e6b6
x-ms-traffictypediagnostic: SN4PR0201MB3614:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0201MB36148FB2338C0A193DECE800C27E9@SN4PR0201MB3614.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgaxqDdgWmMjk86xnEfRI9oHn3AwZBxaQmFdiXp1ZnY8o2tic2IY6PVrzj+if17iJnQPClHtmZTrLdlDx8QsmLtP1G7ZpDqzptzEbYcdaDmWDb6np3/nohmu5Y5EA+BVGMTEj4arNbRfxcEtTkLZh6asm+4uCH5ALh5MdTuAGl94ONAg59Bgw6rivUFNwCT25+DCDpup3Xdzyzi0xLU1JZnAPdTtNqUL2hjA1gLk+nMtFejzR57bszntMPkcqNrmB6882n8HyPO5LcLAc1kjUJNMYxUsh/7V4a1ku6lrfT/HH952oUrq76NxZaWe5whF/0sT+I1oCrw+i85RRO2fVYy0dxudrV9dhfcOG+5glkrcqNbVt3LbublX8DtqcEJiJ2z5ykHV9UgEYW6RqDIWWrq049MI4ZdQUX7C4VW0bGmV1ZYUYWkgLbAxg5MfZizOF2oCBnKo9Xx8LqBHP5AkB5XNcdyaYdBdgM19VOprcgP9Fz9O7QnUIYmU8CNyQqSJxhGwiaYOyF6t51VzyEJu7AXdqKFQ17REKuHyJj90CwHWDZGPNiqW1d8PMpSkEFwEkqBywvDIL9V2Z20raz4/Q5Vq3RZy4v4hFC1nMLapwMxLJdws/y5efXGgogB6aiMF/qaM6rMVULLlPC1L0ySa9JxqILNsBMqzduOblA5CYFXive2kI/dM1cLp5/5n9v5lTVInbDve2AatHbSTcS/V9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38100700002)(3480700007)(2906002)(508600001)(26005)(64756008)(186003)(4326008)(8936002)(8676002)(122000001)(9686003)(110136005)(76116006)(53546011)(38070700005)(5660300002)(86362001)(66556008)(66476007)(7696005)(316002)(71200400001)(33656002)(83380400001)(66446008)(52536014)(55016003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajBGWEhNb09kZEhkRXR5a2VPVE1JWTlXT0NSbS9vV0M1U2szK3crTUZDSlZu?=
 =?utf-8?B?UDQxczdZZEFrYzMydkE2ZXlDdi9mbXMwQ2hJU3pRTjZLQ1EwSmdoZit4VEtx?=
 =?utf-8?B?NUpweWptMDZtOE00RHhIOXBjeDlqQzRVYnI3aWs2S2l0eWtmcWRoK09WTGRX?=
 =?utf-8?B?ejZyMTRhZGdRZU4wbHdVbExWVDRneitwTXdjaWRwemFvbVlrMjFjcFhrMW9Z?=
 =?utf-8?B?QXVIY2NBcXZiR0pIR0g0L20vQS81bytUb3E5b3lPbGpiVUxSR2NURkpWLzRP?=
 =?utf-8?B?N3NBOXRmMjhOL2IvdGg5ZU1hdmhMaUtybWI0QlhuakRxeVdSNVpGUWRNM2pi?=
 =?utf-8?B?MHBRVytITitLLzZJYzlBc055cVZXejVEVGFGS1poWmcyUll1RUhscjIzcVlF?=
 =?utf-8?B?OGNIQUNuMWhFRkp4UCtReExqNnRNZ01mK1hPRWhCZC9jaENtczQ0UUZVdkxS?=
 =?utf-8?B?cDQweGlWTnJDa0o5dGlXcDVyWnhtL3NqZm12MjF5WVZkM2I0bUZPZ1h1a2RV?=
 =?utf-8?B?M3B1ZXArdXJDVmlWbWVvNXBzcTU1MGdua2k4MWVVUHlnWnNNcUpkdkVyZFpt?=
 =?utf-8?B?VTFoeEgycGREb2wvenR3cEp1ME5pQWtVVzFMclMzT2R2Rk9MOEdNWnhHditJ?=
 =?utf-8?B?ZkV2Yk5MNjJnK1RiRzNhN2Vtd0FGL1VoTHVTZld0T0R5NnV1Vk9tM1YrNjNK?=
 =?utf-8?B?c3B2QzNEU3JyazZYeWhrc3dpSzZDZ0FiWTlIYzVlKy80OFhDcElIQ1huV2tt?=
 =?utf-8?B?WjByQmJoZXlESjdSUFJJYjNUazFoYnRZU2ZtK29QWW1WNFNnSUx6UjM1QUl0?=
 =?utf-8?B?UjV6cTBQUXovZWVySGEvWFJIVkNUOVdvSVFpbEd4SmVydjRZOWpqL3JvZnZR?=
 =?utf-8?B?aXYrcEwyY0Z3VmQyckhHdlBpMXZPL1pQMjRBbGVXd011ZTU1YUMva0Y4VU1q?=
 =?utf-8?B?RlRKbmhERHkvRC9uOVpzN3BsaVhyMXRQSG02eUp3NDdKS0pSZWMxb0xsWExx?=
 =?utf-8?B?TTZDcWhKZ21Fd2dhRk9XNTdubUlNQUg1VzhXVWNCdGlza1RHZWl2NjluZWcx?=
 =?utf-8?B?MEhlbEdiTndLMHc2c0ZVdTkyeDAyYVJtSTlrMlVjMlZxcHlSRXBjS1ZDR3hl?=
 =?utf-8?B?cTFqQS96dFFtMmJlN0JSWU15OG40TTZHUVpUR1dnUDk2VmJldTNZSXBEK09t?=
 =?utf-8?B?K3RPSTRyZExCdnVhQVprbHh4MHBpd3d0c3dZaW40cUFLbGJ3aWdoeUMvYlRp?=
 =?utf-8?B?WVJCdHRzS3hWejNKbVZlVVZ4QUY2ZWlIUHZGVitZb1lXSTBOYmpOMU5NSjBQ?=
 =?utf-8?B?QkpUTTZHSUtKa0FTUkpXOTRtd3dXTHBoZ1ZMdjVwTWFIUUNVdGNqY2szdTg0?=
 =?utf-8?B?SjhtRlBHeVBMN2dLNWlGblYraEJXOW1JOFZETFpwQ3d6alRNcG5PbGRsK0hx?=
 =?utf-8?B?ajJYcXBqTmM3QUZUa2N4QlprZkI5MlowT1BqRzVwVFBRVXQ2OFFTdVJBSjRx?=
 =?utf-8?B?b25VNXBJU0gweTA1N1lSeXFJWVBBZmVDV2pUOHhvUmZlQkZ5VTRDU3p0Tkgz?=
 =?utf-8?B?UVAvci9SdmdqY1hmWk51WDFXcU1RUDlITEVjU1ZlSUtucXY5bVdOMTUrcG5B?=
 =?utf-8?B?azdRcHpzNnBIUS9pY1ArL2RVNmoyWkx0b3UxSGJ1NUVsd0JVY0NFd3hJNkZu?=
 =?utf-8?B?SnAyVG5wM3VWdVA2dlErNUxEaE9zaTNXdTVLbTJTVTFkb0RFandKTmZ4eWhW?=
 =?utf-8?B?WTBYemlPM21nRW0vVmdlUkxYNmVxWG43Wks2QUlwSGVIc0Jhb0dCV0kxRGN0?=
 =?utf-8?B?cUJETjJnR0hSMUdIZVl6ZlJWczRLcWhHbG15aW5wdGZaQTBEUzF2SFVpQ0VW?=
 =?utf-8?B?MGRsVmdSN3B5ektDTUthUFYySS9XVUpmcXJ1aEp1eU0rZVpYckV4ZXNKdWV1?=
 =?utf-8?B?Vll6VWxTQVV1cTUvSXByQlhqRE5VL3o5dlZFM2RPVDJ1c3VkQWhkOE5vbEtT?=
 =?utf-8?B?YUlYbTZuOU4zUlJiMDRNYUJNcmVrWS9UMklpVlVRTlJudjJJWXB4ZE5aUkRZ?=
 =?utf-8?B?R2d0dHR6UUNJMWN1clBMVDIxdWRiVlFpMG1US0RRTnlQbitEM0hRSitQM2h2?=
 =?utf-8?B?dU44R08zU2F2WTJha254d2Q5Z0ZtcjZoeStsOVVYYndtK3R6KzJLSjhFVmpo?=
 =?utf-8?Q?qvcpBD/+SH/L1NQMxkvsegc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06dac6a-42b7-4165-8257-08d9c5d9e6b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 06:03:11.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CHqtnhY2D6xqWxgvKojF87wkANWK3ibrlSf+JWdSYGkOf9MZSKD56W68tY9zY5mUPKlac42JzhVJ8tHVqBn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3614
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQpIaSAsDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTaW1vbiBEb3BwbGVyIDxzaW1vbi5kb3BwbGVy
QGZhc3RyZWUzZC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMiwgMjAyMSAy
OjE0IFBNDQo+ID4gVG86IG1kZkBrZXJuZWwub3JnOyB0cml4QHJlZGhhdC5jb207IE1pY2hhbCBT
aW1law0KPiA+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9y
Zw0KPiA+IENjOiBBZHJpYW4gRmllcmdvbHNraSA8YWRyaWFuLmZpZXJnb2xza2lAZmFzdHJlZTNk
LmNvbT4NCj4gPiBTdWJqZWN0OiBQYXJ0aWFsIHJlY29uZmlndXJhdGlvbiBvbiBaeW5xTVANCj4g
Pg0KPiA+IEhpIGV2ZXJ5b25lLA0KPiA+DQo+ID4gV2UgYXJlIGN1cnJlbnRseSB0cnlpbmcgdG8g
dXNlIHBhcnRpYWwgcmVjb25maWd1cmF0aW9uIGZvciBvdXIgWnlucU1QLQ0KPiA+IGJhc2VkIHN5
c3RlbSAocGFydCBpcyB4Y3p1NmVnKSBhbmQgZGV2aWNlLXRyZWUgb3ZlcmxheSBiYXNlZA0KPiA+
IHJlY29uZmlndXJhdGlvbiBjcmFzaGVzLg0KPiA+IE91ciBMaW51eCBzeXN0ZW0gaXMgdXNpbmcg
NS4xMC4wLXhpbGlueC12MjAyMS4xLg0KPiA+DQo+ID4gVGhlIHJlY29uZmlndXJhYmxlIHBhcnRp
dGlvbiBpcyBkZWNvdXBsZWQgZnJvbSB0aGUgcmVzdCBvZiB0aGUgZGVzaWduDQo+ID4gd2l0aCBh
biBBWEktc2h1dGRvd24gbWFuYWdlciBJUCBhbmQgYSBERlggZGVjb3VwbGVyICh0aGUNCj4gPiBz
aHV0ZG93bl9yZXF1ZXN0ZWQgc2lnbmFsIG9mIHRoZSBBWEkgc2h1dGRvd24gbWFuYWdlciBpcyB1
c2VkIHRvIGRyaXZlDQo+ID4gdGhlIHJlcXVlc3Rfc2h1dGRvd24gb2YgdGhlIERGWCBkZWNvdXBs
ZXIpLg0KPiA+DQo+ID4gVGhlIHJlbGV2YW50IHBhcnRzIG9mIHRoZSBkZXZpY2UgdHJlZSBhcmU6
DQo+ID4NCj4gPiAtLS0tIEJFR0lOIFNOSVAgLS0tLQ0KPiA+IGZwZ2FfZnVsbDogZnBnYS1mdWxs
IHsNCj4gPiAJCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAJCXJlY29uZl9yZWdpb246IHJlY29uZl9y
ZWdpb24wIHsNCj4gPiAJCQkgIGNvbXBhdGlibGUgPSAiZnBnYS1yZWdpb24iOw0KPiA+IAkJCSAg
ZnBnYS1icmlkZ2VzID0gPCZyZWNvbmZfYnJpZGdlMD47DQo+ID4gCQl9Ow0KPiA+ICAgICAgICB9
Ow0KPiA+DQo+ID4gcmVjb25mX2JyaWRnZTA6IHJlY29uZl9icmlkZ2VAYTAwODAwMDAgIHsNCj4g
PiAJCQlzdGF0dXMgPSAib2theSI7DQo+ID4gCQkJY29tcGF0aWJsZSA9ICJ4bG54LGRmeC1heGkt
c2h1dGRvd24tbWFuYWdlci0NCj4gMS4wMCI7DQo+ID4gCQkJcmVnID0gPDB4MCAweGEwMDgwMDAw
IDB4MCAweDEwPjsNCj4gPiAJCQljbG9jay1uYW1lcyA9ICJhY2xrIjsNCj4gPiAJCQljbG9ja3Mg
PSA8Jnp5bnFtcF9jbGsgNzM+Ow0KPiA+IAkJCWJyaWRnZS1lbmFibGUgPSA8MT47DQo+ID4gCQl9
Ow0KPiA+IC0tLS0gRU5EIFNOSVAgLS0tLQ0KPiA+DQo+ID4gVG8gcmVjb25maWd1cmUsIEkgdGVz
dGVkIHRoZSBmb2xsb3dpbmcgY2FzZXM6DQo+ID4NCj4gPiAxLiBtYW51YWwgcmVjb25maWd1cmF0
aW9uOiBXT1JLUw0KPiA+ICAgIC0gZGVjb3VwbGUgYnkgd3JpdGluZyB0byB0aGUgcmVnaXN0ZXIg
ZGlyZWN0bHkNCj4gPiAgICAtIHJlY29uZmlndXJlIGRpcmVjdGx5IHdpdGggdGhlIGZwZ2EtbWFu
YWdlcg0KPiA+ICAgIC0gcmVjb3VwbGUgYnkgd3JpdGluZyBkaXJlY3RseSB0byB0aGUgcmVnaXN0
ZXINCj4gPg0KPiA+IDIuIGZ1bGwgcmVjb25maWd1cmF0aW9uIHdpdGggZGV2aWNlLXRyZWUgb3Zl
cmxheTogV09SS1MNCj4gPiAgICAtIHdlIGZlZWQgdGhlIGZ1bGwgYml0c3RyZWFtIHRvIHRoZSBG
UEdBIG1hbmFnZXINCj4gPiAgICAtIHVzaW5nIHRoZSBmb2xsb3dpbmcgZGV2aWNlLXRyZWUgb3Zl
cmxheToNCj4gPiAtLS0tIEJFR0lOIFNOSVAgLS0tLQ0KPiA+IC9kdHMtdjEvOw0KPiA+IC9wbHVn
aW4vOw0KPiA+DQo+ID4gJnJlY29uZl9yZWdpb24gew0KPiA+IAlmaXJtd2FyZS1uYW1lID0gImZ1
bGwuYml0IjsNCj4gPiB9Ow0KPiA+IC0tLS0gQkVHSU4gU05JUCAtLS0tDQo+ID4NCj4gPiAzLiBw
YXJ0aWFsIHJlY29uZmlndXJhdGlvbiB3aXRoIGRldmljZS10cmVlIG92ZXJsYXk6DQo+ID4gICAg
LSB3ZSBmZWVkIHRoZSBmdWxsIGJpdHN0cmVhbSB0byB0aGUgRlBHQSBtYW5hZ2VyDQo+ID4gICAg
LSB1c2luZyB0aGUgZm9sbG93aW5nIGRldmljZS10cmVlIG92ZXJsYXk6DQo+ID4gLS0tLSBCRUdJ
TiBTTklQIC0tLS0NCj4gPiAvZHRzLXYxLzsNCj4gPiAvcGx1Z2luLzsNCj4gPg0KPiA+ICZyZWNv
bmZfcmVnaW9uIHsNCj4gPiAJcGFydGlhbC1mcGdhLWNvbmZpZzsNCj4gPiAJZnBnYS1icmlkZ2Vz
ID0gPCZyZWNvbmZfYnJpZGdlMD47DQo+ID4gCWZpcm13YXJlLW5hbWUgPSAicGFydGlhbC5iaXQi
Ow0KPiA+IH07DQo+ID4gLS0tLSBCRUdJTiBTTklQIC0tLS0NCj4gPg0KPiA+IEluIHRoaXMgY2Fz
ZSwgdGhlIHdob2xlIHN5c3RlbSBjcmFzaGVzIChldmVuIHRoZSBwbGF0Zm9ybSBjYWJsZSBkb2Vz
DQo+ID4gbm90IHJlc3BvbmQgYW55bW9yZSkuDQo+ID4gV2hlbiBzZXR0aW5nIGFuIElMQSB0cmln
Z2VyIG9uIHRoZSB3cml0ZSB2YWxpZCBzaWduYWwgb2YgdGhlIEFYSQ0KPiA+IGNvbnRyb2wgcGF0
aCBvZiB0aGUgQVhJIFNodXRkb3duIG1hbmFnZXIsIHRoZSBJTEEgYXBwZWFycyB0byB0cmlnZ2Vy
DQo+ID4gYnV0IGNyYXNoZXMgYmVmb3JlIHRoZSBkYXRhIGlzIHNob3duIGluIHRoZSBoYXJkd2Fy
ZSBtYW5hZ2VyIHdpbmRvdyBvZg0KPiBWaXZhZG8uDQo+ID4NCj4gPiBXaGVuIHRoZSBwYXJ0aWFs
IGJpdHN0cmVhbSB3cml0dGVuIGJ5IHRoZSBvdmVybGF5IGlzIGFscmVhZHkgbG9hZGVkDQo+ID4g
KGJ5IGhhbmQsIGFzIGlzIGNhc2UgMSksIHRoZSByZWNvbmZpZ3VyYXRpb24gdXNpbmcgYW4gb3Zl
cmxheSB3b3Jrcw0KPiA+IGFuZCB0aGUgQVhJIFNodXRkb3duIG1hbmFnZXIgaXMgd3JpdHRlbiB0
byBhcyBleHBlY3RlZC4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFuIGlkZWEgb24gd2hhdCBpcyBn
b2luZyB3cm9uZyBoZXJlID8NCj4gPiBBcyBJIG1hbmFnZSB0byBkbyB0aGUgcmVjb25maWd1cmF0
aW9uIGJ5IGhhbmQsIEkgc3VzcGVjdCBhDQo+ID4gY29uZmlndXJhdGlvbi9kZXZpY2UtdHJlZS9z
b2Z0d2FyZSBlcnJvci4NCj4gPg0KDQpJbiB0aGUgY2FzZSAyIHVzZSBjYXNlIGNvdWxkIHlvdSBw
bGVhc2UgcHJvdmlkZSBtb3JlIGRldGFpbHMgKGlmIHBvc3NpYmxlIHBsZWFzZSBzaGFyZSB0aGUg
bG9nKQ0KbmVlZHMgdG8gY3Jvc3MgdmVyaWZ5IHdoZXRoZXIgdGhlIGF4aSBzaHV0ZG93biBtYW5h
Z2VyIGlzIHdyaXR0ZW4vY29uZmlndXJlZCBhcyBleHBlY3RlZC4NCg0KUmVnYXJkcywNCk5hdmFr
aXNob3JlLg0K
