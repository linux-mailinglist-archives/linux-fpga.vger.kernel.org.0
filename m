Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18753BF93A
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Jul 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhGHLos (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jul 2021 07:44:48 -0400
Received: from mail-bn8nam08on2081.outbound.protection.outlook.com ([40.107.100.81]:15329
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231575AbhGHLos (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Jul 2021 07:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw8q9eM5aSvfUa7DCUVVJ1rtMCKsKNkD0Tbnr9P8HcYVZoYFUZ7zx1crTvAgkFM2mNWdS9GEdzXZHBN2CiEb0qj0W9LxZpwd7QWTxFetuEnUv0GWQNegIOsrKUFtPm6OtympfY+ZYtYMRx0XYwDXUIZTTXmOsFEVPkHBRh7uShDnF6r6mWWksjaK++RWnlq69bflWvjTg4uOvY1BXmeucGmPk+uP67TmH36ruYM5tmc9ID3qB7CA3ye0n0h55/wN0ppWkDJFuLmj0y+mAbPY0gMaCsEqTgRA9Ci8QaxQOUF0su1kkqB4T2dwL5e0k6gpxDTblpJXDcS1zeBKKyIiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL45HZMGfoWHz+0zdW1Y7WBXDDI/r+JsPCnSeaRUjm4=;
 b=YRrySqDohiqKBXjZvn0UQOjhXf6/6x8VMVUedUItmNgV1KGobGtbOtnrn381mU7R8QMuwPavDi9flCrxaX+EHStGTcz9s+b5zJTJeRp3k0kHB4yi21a4B77Dl46vyj4ZxerRMRjzsrI8xY0RNKnP7v0ERvMbCHxDiEYzOHqybXKpA6Z+JZyuNi96Knjcg2ng2LZEfh/8bO1mu7zSZ/4yjHLW8TwA4U3pGBmDOq122u1k1U3JNgjYNgeGpNCLh/w9dMluQNBnnEaHbly2b1DdbRNvo3ZiK6wQF9gq0YOfmksF2RO8e1Kp146GLT9IJPTbZB936Z2FHH5Nbu7vDp6cYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL45HZMGfoWHz+0zdW1Y7WBXDDI/r+JsPCnSeaRUjm4=;
 b=K1cWrWfFJ4BjwgVLO3+UexadOMPLRg7r1lthmhEvZBLszABXJBJipBSlgzYhpjFERgI3vE0YDmmFLk2NLxLG8Sc/rjf6PHCyrf/K3hFbnVt5mONejZC+zfaBmJ3UvamjcWQljTCSKVnZ7y2KC4neUL6hGPdyLto/dIO6wWNHyzg=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7654.namprd02.prod.outlook.com (2603:10b6:510:50::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Thu, 8 Jul 2021 11:42:02 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 11:42:02 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <ravipate@xlnx.xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH v8 4/5] dt-bindings: firmware: Remove
 xlnx,zynqmp-firmware.txt file
Thread-Topic: [PATCH v8 4/5] dt-bindings: firmware: Remove
 xlnx,zynqmp-firmware.txt file
Thread-Index: AQHXaqNllaRL0AvXI0uTWJHI3r04Zas2gQMAgAKBFGA=
Date:   Thu, 8 Jul 2021 11:42:01 +0000
Message-ID: <PH0PR02MB733678F94606035915C9F482C2199@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-5-nava.manne@xilinx.com>
 <a2a71d30-97da-0b1e-7942-f7dd63b0ddab@redhat.com>
In-Reply-To: <a2a71d30-97da-0b1e-7942-f7dd63b0ddab@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b00ede0-e8e8-4169-6a19-08d94205670d
x-ms-traffictypediagnostic: PH0PR02MB7654:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB7654AAFB30639320310333E5C2199@PH0PR02MB7654.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HneisTYp9FfqeJh8XDIeRMi1wGKDm9hyzYCTMzugecWSOFtWvb27VrfVq9wURTurnfAMkL7ecvqhXrZlCa+VoqCFDdCSyxMA85WN723N2lJIojrB6lD7bzMP2r9rkzABJ0d6TRY4n6FrkW6w/Un5BYJ87NV1J26r9P3dVgaeDh8zjrKPol5JHwWccoRnM96zUIpED9mxW3VbW3udgqckvXrx2qA9JaG5wLnADmZL9EqJhO/ZLsPcCDwjbPjmoFyK/2ium0oape99bWppipyP9m1hNtIK2kvxEdjXcKLPuGvDcRlWZHJJKd2div+GYvHi8Dq3lAoZcJLq/q3fTKFMqUmxMzUA7qsaao1oUiEkOMjyq5SaoapWszPa9KQMcD8shrADvgOFy2PiUj3K/rovkWxhHqbgNUPjChOIEUIb6FK39ydvHLBJaf28BwCumZ91Gq/ksLb/7vjbX9SlsJt81UGMEBe3iNh07CskfnAq7J75j6R2R8KneYdZuwokGjZQ9QaU6IOBgdmbMvNNpGZ82m22Q792IViAzaGADAQxGB3TpB6QQ2/BOhWSv5gkB0Mo45vzXeW9n9uxpSUV0Ln9QpNfnawNor/0v8MMNQy8vFVY/IoSfSYOhDvxZhZm4jKmdIzmFlI9XtjryMAGoG/cMFJ3C/8ufIgIg1A124kgtbdk5PwWgZVI2W9cZTU4vC50xvAI4mjprSoC+3DE44W8Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(8936002)(8676002)(55016002)(86362001)(83380400001)(38100700002)(122000001)(2906002)(71200400001)(316002)(921005)(4744005)(66556008)(9686003)(66446008)(64756008)(110136005)(478600001)(53546011)(7696005)(6506007)(33656002)(52536014)(66946007)(26005)(186003)(7416002)(76116006)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnoyMmVObFJ5cWNHaStPajBXMS8xcDlwVGJnazRwUXZuMDdycmZFZUpMQ1JX?=
 =?utf-8?B?NTkvY3VkamV3VjZQZ1Q0WnNFbjRCTE1ld3hGcGdCRTNGdUJjbmJJT3VrNkRI?=
 =?utf-8?B?QitDRjZYYXFFakt5UlpZcjRkSklFQkI3L1RVR2NERTdHaXVDOVNLZ1hmKytv?=
 =?utf-8?B?cHdlb2NaaTJyWFlWSGY2QVlXTkFkUDdVRDBMQUNzUm85amdlMk9hcEJFd2k5?=
 =?utf-8?B?eTFaYjQ0QlJDaytqbGQxQU5CT0Y0NTcwZ3dxK2Z5UzVNMUl6MEpQQlljVytI?=
 =?utf-8?B?MjdRSWd1aGIxaEV2ZjN6dGd5eG11YWg3OEE1TXFCQ09GVXdLUVIvRitvUzI4?=
 =?utf-8?B?MFdmZTRKZXFoNFZRWnFaRWVrV0pCNnNZSmora083Y2kxbXJJL2ZzeEk5Zlgw?=
 =?utf-8?B?SHozNmc4S0k3d1V6VEFFMnl1ZURJYXBqYlZ5d1UrWUVQOFdaazhxNlRiblBu?=
 =?utf-8?B?T1VXUDlHSUJiVW5BMVg5Q1hEbmFKTmdDK2dUZ3pydlZpbG5kRm1GZ2x0NkVx?=
 =?utf-8?B?WGFyUzNRODBsK0x4TmNGMk02c3NidzZFU3Q3Tmh6dG1ZL2xPcG9DejFXZlFX?=
 =?utf-8?B?aVYzTzhQa2VCZEpqb2lTQnkyQUVTS0VjK1VxMEwxV09NZFB0dmpPbm56cnRj?=
 =?utf-8?B?dkZZWTJ4cmNsZlJzQ1dOczlVKzBDMHlnT2s4YThpd28xa2tiZmR0MEJiaDda?=
 =?utf-8?B?TW9hYTRhcXZvVjdjckdPN1FqRTBnc096VEZzQVl2K2VCVHI4OFo5S1dqb1I2?=
 =?utf-8?B?VVptSmxhT0xjcjhtZkZ2amlXaGJVVHBrN0QvYk5GbmUxbkdCV3ZiRnhmRitH?=
 =?utf-8?B?Z2V1UkRLRDlCbTFYY0VyN3o0YTF1aVlBWm9KOEh3ZWtUdmd6MXpaai9OR2M1?=
 =?utf-8?B?YkRLNFVvWkNMbGJmV3I3SkdLQzRNMUVOalJ5YnIzNmJPTkV5VnVKem1IS2tW?=
 =?utf-8?B?TmFBY0FFSU04TXhqeTE4VjJYQ09vbElYRTJmU3liYUNOVXBseXpxV1JJTEVB?=
 =?utf-8?B?Z3dEMWk2dzBQRjFDaTIyMEFaZFppcy9wOGpEQzFWTmcwK1F4Y1ZRVVdMVkVM?=
 =?utf-8?B?OFE3TEV1VmlRMlpyWUE0eHNLZVRISnJOUDBkYnhScTducGpVcmRYZEJid0tj?=
 =?utf-8?B?Nm85S0ZCRjE5M0VJcTV2cGtCSVF3aFNMZFFBU3dFZit6Vm4xQmVLZ3JKNGIx?=
 =?utf-8?B?ZUtCQVd2VXV1TVpJSy9BMUdDdDlibDhHWHgxNE1rbDVOTlUyQ2hwRDBoSzBx?=
 =?utf-8?B?T0tmUWJZWGJNSU5BTGFiWTF4VjJ4TFNBdXdiMVNQdWdvcDQ3TFNDZHE0TTBK?=
 =?utf-8?B?Q0dhSVlpcDF5RTB4TW5reGhXSnorK253cTBwaFF0UFRuN2NUNlgyb1daQnNm?=
 =?utf-8?B?b2VnWXFva2hsS01kUW1ySHdEMlBib1dJZHBKUEcxTXE5RVh4RnhoWGR0dGt4?=
 =?utf-8?B?N2M2RFdJSkZHRXYrdGN1Um1RUld3S0dURjRtQWhYY1ZrTUpJTVRWOXdNeUdW?=
 =?utf-8?B?cDRaMDdlai9ZWURJSWJxU3FTeWY4b3Joek5MbDN2WE5qaUEya2RpM21USUJL?=
 =?utf-8?B?TSttUEFMUm4zTUkwOW52aWlVMCt3UThONUpQRHE5azNsUmFXWjMwMEQxcjc4?=
 =?utf-8?B?SVNZd0pqaG5laDRWMkloaHBPYkJ3VUxaOVc0eTROaEx2V0pLWU1XeFRqdXpj?=
 =?utf-8?B?UHlCd201QlVxaTRFdmVNS2xPRWplYlpXUVZnUy9ST0dKN2JwZytCMzhRVEhU?=
 =?utf-8?Q?bkk7HUmodhROL2uEvTaelHRfkOrqMRczn8q9UHo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b00ede0-e8e8-4169-6a19-08d94205670d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:42:01.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGvvpQd1EvtUpw0ctiVGa3Jd3Th+oWNv9aGOXTbs7RCTKOYxo7pMSjztpsNE/KJekAPvdTDxLPEQOvtel0w1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7654
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLCANCg0KCVBsZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA3LCAyMDIxIDI6MzkgQU0NCj4gVG86IE5hdmEga2lzaG9y
ZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgTWljaGFsDQo+
IFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBtZGZAa2VybmVsLm9yZzsgYXJuZEBhcm5kYi5k
ZTsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgQW1pdCBTdW5pbCBEaGFtbmUNCj4gPGFtaXRzdW5pQHhsbngueGlsaW54LmNvbT47
IFRlamFzIFBhdGVsIDx0ZWphc3BAeGxueC54aWxpbnguY29tPjsNCj4gem91X3dlaUBodWF3ZWku
Y29tOyBTYWkgS3Jpc2huYSBQb3R0aHVyaSA8bGFrc2htaXNAeGlsaW54LmNvbT47IFJhdmkNCj4g
UGF0ZWwgPHJhdmlwYXRlQHhsbngueGlsaW54LmNvbT47IGl3YW1hdHN1QG5pZ2F1cmkub3JnOyBK
aWF5aW5nIExpYW5nDQo+IDxqbGlhbmdAeGlsaW54LmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdp
dCA8Z2l0QHhpbGlueC5jb20+OyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY4IDQvNV0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBSZW1vdmUgeGxueCx6
eW5xbXAtDQo+IGZpcm13YXJlLnR4dCBmaWxlDQo+IA0KPiANCj4gT24gNi8yNi8yMSA4OjUyIEFN
LCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gVGhlIGZ1bnRpb25hbGl0eSBvZiB4bG54
LHp5bnFtcC1maXJtd2FyZS50eHQgaXMgcmVwbGFjZWQgd2l0aA0KPiANCj4gZnVuY3Rpb25hbGl0
eQ0KPiANCg0KV2lsbCBmaXgNCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
