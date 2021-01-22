Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF822FFF78
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 10:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbhAVJqU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 04:46:20 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:18656
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbhAVJp3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jan 2021 04:45:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6jOHcJYeGw5J4ewtv0ea7qbnJbV9eKwI++LOeHVpqU8uvxPIyFBtV0eMOhSt9YcjJt0R0xObjPjgtQILJv67qnM97mlsNxmKd7SxdfDlcdjwRiS2t1TcAgPT8FtkzMHl3whFc0AXadPAPNMOoiy8qxU9dB3vLFu4ZD+ure3ONJgKYbZvR+xFBUXR94/GxLzU1OyYAoGpMa74JMSU29pcihLwLu2QyqYZSnkXfA8fxj6hCYgo2dkA9ocHoMuxY/Wym4m02CAOjC1tsE++dqftsj0E181ArgSHItMQVKR4Kp8nJ10xC87FgEIYEAQTHO7A+0cz9bbQppCn3N2MiUvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkN5Uf8IJsvKQClJQKQjbVZGwWWsysZFZaZXYoxjtH0=;
 b=VToon4qRdqT/HNz2FeLghO0x3uydPqw14OZunJKY1uQnre+a43hEixAeebFj1NYJ0bY8SFmLUpUdkG4ApEB0s+YKipklA0UfCugg0ZNPGsG1JAblc6Xn7PqZ6WJcBA6GfaJsiRLNPj+O9lHP5Oc10v9mGF6uYe5VQnj7Qh4hvu8DrDC1iThNCfE4LJPd++8VtH+YmM+xSwxGrndW+M01i+7N1oQ/hNlKFHww88VJf3OYF9S4eVGYuXJIRNofJvNmxc1Eo6Fq9k7QgKZaB2PoGWxUNnunv8H44NDN6fz4VCREwG/CyA5oSIzbC9Wlt1OCEBiCinbeaVJA8p9Rqm9+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkN5Uf8IJsvKQClJQKQjbVZGwWWsysZFZaZXYoxjtH0=;
 b=obdUg7xlHBhq/YjnUn6J0COwqzcZiXLOysjcXmeGEUQcHjtSM1zkp4EnXrSWQqDydn41cvfic6biA5IYNdT9n0uBek70jfsJvqLukuhHw0N7gh4Of/i3KF07MBdLuA8qENWHQHLwT90SgjwpPUMRiN7rMpSDYaY04WPLQX6o3Iw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2253.namprd02.prod.outlook.com (2603:10b6:300:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Fri, 22 Jan
 2021 09:44:12 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 09:44:12 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
Thread-Topic: [PATCH 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
Thread-Index: AQHW7USIMOrJetgfJEiYdPkTgeevwqotE+MAgAZWhHA=
Date:   Fri, 22 Jan 2021 09:44:12 +0000
Message-ID: <MWHPR02MB2623868D18BACAC3FC512965C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-2-nava.manne@xilinx.com>
 <9d7f1460-0431-4364-6406-1d4b8b3b6871@xilinx.com>
In-Reply-To: <9d7f1460-0431-4364-6406-1d4b8b3b6871@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec2b57e6-5e6f-46f3-ff09-08d8beba4633
x-ms-traffictypediagnostic: MWHPR02MB2253:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2253687F33318550169A2C4CC2A00@MWHPR02MB2253.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENsNA8g9BlhCYnbtKJ3S3wxArTy0p62sVyQfjXkXMhP5Mpv5OH2vQniqBdXKuQA75rsv7YjOfNuL1EXwvBOoyxmwgsgyGRkK9l5S2CrEozHM7l77xTlCjgf2GKQ9LDj4GBLrOvxFl3fJhoS7BhcCMCzgoBi+J52uIrMdL+EGWuqq5/klHfhmmZriInVIBG4EqLmPvQcOOX1fo/YIois2GMFx3r0JjsBlflXPRX9kF1YZScUhwHZVlnG+jhZKzHsK5MAHze039zbKJZJ5lndZCtJ172lcnOFW97Ca5Qtfbo9Hes093ZXTk2S9owwgBMNbhGQ3xwHi4cEVrmod7KTk72JIkrEr4bSMHdGW0idrI72O0Yp4hTFOTV8+Z732Maa/MPR5pIKGKfQpxI7sKzoJgIR1GsIlZCo26NvIzHIl7ysPPYuNpscAk3fylXKyD0+WpOxuQqXi4kpNWwgyabvgX4AV2iy5JsjSJc/Wixn1U4sQIrRlmn2FFMmeAD3gcSi/F2bGODbr3Z0okMPFa+GpXsEMRZg4WQURkLIMGUAHEvk8E4zzePYfnBJ+3FUd41MP2t7Q6APsrSqoZhUP8b/xtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(54906003)(66476007)(71200400001)(478600001)(6506007)(186003)(53546011)(7696005)(8936002)(316002)(8676002)(110136005)(33656002)(5660300002)(83380400001)(76116006)(26005)(66946007)(9686003)(66556008)(4326008)(52536014)(86362001)(55016002)(966005)(64756008)(107886003)(2906002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SzJUZGdwNGJlN2JxM3NJR3REU1FKNGkzd2N0SVcrbWFRd0FtaXU4TnoxaGZN?=
 =?utf-8?B?RXhqaUJPT1R0Y3BaRkI2UEF5N2l4bFlvTU45UG9jSFhQT3NoRVhjaXVUSCtJ?=
 =?utf-8?B?U1QrWUVGZko3V2hXRVpmd05Pc2ZhZWk4T0ZkaCtNd1pEL1dEUzYzNGhwU052?=
 =?utf-8?B?TGtSMC8wTWkyMFExbjlvSUExbWV3WC96T242dWtYcERPL2xvZ0RjQ2FORkV2?=
 =?utf-8?B?QXhLRWx2K1g2NU1Qb3RLWHdxR1FIOTZFdHRoQ1dKcTFHRGVCQ3ljTHNvdnVy?=
 =?utf-8?B?aU11Q3o3Y1prUjdKNHlqRW5TMFhZR3hUbWpTNWx2aFJIYnF2Q2RQQjhRNnhO?=
 =?utf-8?B?S0NabDZQS1l4NzVxcmt2V2VjUC9yT3RSV3NOS2JEYWdELzdodXJJSlozWUtN?=
 =?utf-8?B?Zm9vQ29ZMjR2a1dOR1JBV1FQR01RNlg5a200Y0hpYjFyMzFpd21qYUE0UnQ0?=
 =?utf-8?B?U0hJazlTS3ZMOFdkeXRFN1FWRnljR0R5QUpiaVlkQ2E1WEhUZDNDbHd1YTk4?=
 =?utf-8?B?RVRrNUVjVVBCOTgwdzlWQld5d3I5L0lrSmtJT3NHWjkzeUc0TVpnVm1HNDV6?=
 =?utf-8?B?WGd2WU4vTUJmRDhCQTJKNGNNNGJvK25FSmUvbXAwV244bEpMbThpRDZlMVlF?=
 =?utf-8?B?NVFzU3N4RllOeUtacVUrS0lHWmQrclpGWHlXQlRhZTB1R1c2a3BQTm1iTW9M?=
 =?utf-8?B?TWZ0akNPYnRWek45NlJGdDFtdWlpWThpaXF2SUJDMi9GSTdkZzByWU1vWE42?=
 =?utf-8?B?UUd6M3UyaTVrSFNKZEs2RU1Mc2hkNE8wVXZ0UUY1THlLN01RNWNSV05EUXhQ?=
 =?utf-8?B?UE5IOVJSa2NQcDc5R0hVUkNPOG01bGlkZDF0cUZkMzBHeHBFWUY3WWhCc2M0?=
 =?utf-8?B?b2wyTis4UW9lVDNMR2k1bkpGWWRoZTNTWDYrZ21Zc1p4YUdxUmZuUFZJcnlm?=
 =?utf-8?B?enBPS3JQa2FsQlk1RlFCVlJESFU5WHc2TVBaVEdVQmdCb2RWYWM1VFZsZExB?=
 =?utf-8?B?UFUwWXFRZEQ1MENYMVJFVlpZYTRLSFZoM2JPM0dxYzVwamovSU1QalcybkZX?=
 =?utf-8?B?bmlqd3dOZXh6MktQckVDK2RiRDBvb1gyUExOYjFYMmo3dUpRVzVKdG8yMkRR?=
 =?utf-8?B?T0d5TGgrSHVPbWRKaWNjakhlRVBqcXl4SE1OY3hLMGFjZWJVOC9LMTdQcjRJ?=
 =?utf-8?B?Y1JKTmdZU1RCNWo5TC9xejVVNVZOdG50bnJrd1VJQ2pGbWx2bU94SGQyamNa?=
 =?utf-8?B?dmtqVTB3S0N2M1pqMlRCbTJnQVZtaUNpaU90TndJV3NpWmFEUnpncndwcGty?=
 =?utf-8?B?ZEFmdkJ6RWxPbW43ekJLZUZiczJ5ekZlbEM1U2J0eE5Ealc0MEtqZ2lOcW42?=
 =?utf-8?B?dnFxNzVkYllobHBxaHRqYjZOTS9YNlFHem41Zk5rTlM1Sk4rWlo0OW1oQnAw?=
 =?utf-8?Q?43DRo9H/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2b57e6-5e6f-46f3-ff09-08d8beba4633
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 09:44:12.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6O0vphUJdbH5c8Ta61ug6Mlnd+6Pk2xGiz2RGDSwpSivggZmHlTMjCIs+vQCKLME9fjGUH+yBZBS0ccYnxUjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2253
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgTWljaGFsLA0KDQoJVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KUGxlYXNlIGZpbmQgbXkgcmVz
cG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
Y2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFu
dWFyeSAxOCwgMjAyMSAyOjIyIFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhp
bGlueC5jb20+OyBtZGZAa2VybmVsLm9yZzsNCj4gdHJpeEByZWRoYXQuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gbGludXgtZnBn
YUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
DQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IENjOiBnaXQgPGdpdEB4aWxpbnguY29tPjsgY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5j
b207IEFwcGFuYSBEdXJnYQ0KPiBLZWRhcmVzd2FyYSBSYW8gPGFwcGFuYWRAeGlsaW54LmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGR0LWJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGlu
ZyBkb2MgZm9yIHZlcnNhbCBmcGdhDQo+IG1hbmFnZXINCj4gDQo+IA0KPiANCj4gT24gMS8xOC8y
MSAzOjQzIEFNLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gRnJvbTogQXBwYW5hIER1
cmdhIEtlZGFyZXN3YXJhIHJhbyA8YXBwYW5hLmR1cmdhLnJhb0B4aWxpbnguY29tPg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jIGZvciB2ZXJzYWwgZnBnYSBtYW5hZ2VyIGRy
aXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5t
YW5uZUB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFwcGFuYSBEdXJnYSBLZWRhcmVz
d2FyYSByYW8NCj4gPiA8YXBwYW5hLmR1cmdhLnJhb0B4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vYmluZGluZ3MvZnBnYS94bG54LHZlcnNhbC1mcGdhLnlhbWwgICAgICAgfCAzMyArKysr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9mcGdhL3hsbngsdmVyc2FsLWZwZ2EueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx2ZXJzYWwtZnBn
YS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54
LHZlcnNhbC1mcGdhLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uY2YzYWE3OTE3NDg4DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hsbngsdmVyc2FsLWZwZ2EueWFt
bA0KPiA+IEBAIC0wLDAgKzEsMzMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiAr
DQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZnBnYS94aWxpbngveGxu
eCx2ZXJzYWwtZnBnYS55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBYaWxpbnggdmVyc2Fs
LWZwZ2EgZHJpdmVyLg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBOYXZhIGtp
c2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54LmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0
aW9uOiB8DQo+ID4gK0RldmljZSBUcmVlIHZlcnNhbC1mcGdhIGJpbmRpbmdzIGZvciB0aGUgVmVy
c2FsIFNPQywgQ29udHJvbGxlZCB1c2luZw0KPiA+ICtWZXJzYWwgU29DIGZpcm13YXJlIGludGVy
ZmFjZS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiAr
ICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgLSB4bG54LHZlcnNh
bC1mcGdhDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiAr
DQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGNv
bnRhaW4gInhsbngsdmVyc2FsLWZwZ2EiDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAt
IHwNCj4gPiArICAgIHZlcnNhbF9mcGdhOiBmcGdhIHsNCj4gPiArICAgICAgICAgY29tcGF0aWJs
ZSA9ICJ4bG54LHZlcnNhbC1mcGdhIjsNCj4gPiArICAgIH07DQo+ID4NCj4gDQo+IFRoZXJlIGFy
ZSBpc3N1ZXMgd2l0aCB0aGUgYmluZGluZw0KPiBSdW4NCj4gbWFrZQ0KPiBEVF9TQ0hFTUFfRklM
RVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx2ZXJzYWwtDQo+
IGZwZ2EueWFtbA0KPiBkdF9iaW5kaW5nX2NoZWNrDQo+IA0KDQpUaGFua3MgZm9yIHBvaW50aW5n
IGl0LiBXaWxsIGZpeCBpbiB2Mi4NCg0KPiBhbmQgZml4DQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx2ZXJzYWwtZnBnYS55YW1sOjE1OjE6DQo+IFtlcnJv
cl0gc3ludGF4IGVycm9yOiBjb3VsZCBub3QgZmluZCBleHBlY3RlZCAnOicgKHN5bnRheCkgYW5k
IG1heWJlIG90aGVycy4NCj4gDQoNCldpbGwgZml4IGluIHYyLg0KDQpSZWdhcmRzLA0KTmF2YWtp
c2hvcmUuDQo=
