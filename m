Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E99D07E6
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2019 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJIHK6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Oct 2019 03:10:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:20862 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbfJIHK6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Oct 2019 03:10:58 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9973ERv004851;
        Wed, 9 Oct 2019 03:10:32 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxax0rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 03:10:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAyWHRIW88njW8c3WDSQ2b1XPJ1s5sGo/MA0e3NEjW2BdDylYo7EqopOkWCYSNRN6FE1kQKk/w1YjcbLOMjrVuojvkVJE/pjKpePR/pVm1wn3JfQ6s9r7OLx/IEw3fPTRR1JY0Qf0q/eNM+WcsBNKiITYFrYOcH8gvO+15n1Wczf5z5bssXAmaEzbag158bJe+kqTMl03saPOBeomNopjWAa+y3FdLOiFYXfR3u2SgHUhVxSZc8R0rTGS+dZRQDsvmQ9or565BbB4/ivNm6sE71hfLQ+sEw7hiDKRbF737fXmvt7zZbgxQCg720gpMl3fjolJUOT3QtyK6zea1cvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+EfPina4Xr5RSW96rtp0KDZTHf2uR88dhjiCp3+SLM=;
 b=kK0JD95M6KysPBSdjMswhc3WYlAxACEdyVkR0HPp4ZzbbA0kO345eawELpLjg/eBeFzHT2S/ij+zChh5XuJeOEr//ZVEGHg9YFVeg7ohblvWZBXyBaRM4qvZ2aOjYOLp7rkU23LjiDxevjpQdcBwsBAPChKSqRtpWV+Gr3JyhDffvyJb/fWSsxteW1GtrL6hzzxi05b5joBDgyczGNpG0Y+zZzFMtlPU8E0OjXBELwV2DVkHSHOZP+Co0E+iTui6OWeN1wLe0Z8WQld1Gz6AKZnpRzCYVn+PCOk4VIzBq8t2MyVBWB4983LwGfJMcCBo27zWa5v3ZDgeW2M3uo9Ycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+EfPina4Xr5RSW96rtp0KDZTHf2uR88dhjiCp3+SLM=;
 b=U0DCSFENgO3agBeOWxMxecolWNU20kKedqhJ/N0jAgVmczLpRCWPhM7LZMxSNC7dHfLmUk/l5CeWHWs36Lch2+m2fKi3A7nDfKYyWgqz7ggWMjbz8XyDZGcrUCmk4HgmGYksXf1JV4hud/oPDJlK+sMMq5r1nghPJWwgK+Hkhc8=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB5295.namprd03.prod.outlook.com (10.186.146.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 07:10:30 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5%7]) with mapi id 15.20.2327.025; Wed, 9 Oct 2019
 07:10:30 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Thread-Topic: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Thread-Index: AQHVdFa03kFb3oEkSUeluAbSCPFerqdNzcGAgAMshQCAAEYwgIAAuD8A
Date:   Wed, 9 Oct 2019 07:10:29 +0000
Message-ID: <1d064ffa4eb0698121eca4862ee4d25e2140e333.camel@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
         <20190926103925.194973-3-nuno.sa@analog.com>
         <20191006153209.GA30372@roeck-us.net>
         <1125a1f831a76b27ccc050a0db4499e5c4abd76c.camel@analog.com>
         <20191008201129.GA14652@roeck-us.net>
In-Reply-To: <20191008201129.GA14652@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a691197-5f9c-42f0-9b94-08d74c87c4b9
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR03MB5295:
x-microsoft-antispam-prvs: <MN2PR03MB52955E5CAE30DE2B35DF30DD99950@MN2PR03MB5295.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(478600001)(66066001)(99286004)(71200400001)(8676002)(71190400001)(66946007)(66446008)(64756008)(5640700003)(54906003)(2906002)(81166006)(1730700003)(81156014)(316002)(26005)(6486002)(6506007)(6436002)(5660300002)(8936002)(256004)(91956017)(76116006)(2501003)(6512007)(66476007)(66556008)(186003)(102836004)(76176011)(4744005)(25786009)(86362001)(6916009)(118296001)(4326008)(229853002)(2616005)(6116002)(6246003)(3846002)(14454004)(486006)(446003)(305945005)(7736002)(11346002)(2351001)(36756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5295;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/6M4XdrZWTm0vbqqBflwPkirpYaIu0f84ruZlQNuTWOiVBTbF0bCjqL8fv4taR86Zu2ALTHPNN7pod4KWVI4rXaIXD4aamYvCveWTnkaKHFjCoXt3EvHWy1SUNbwS2rTflgt6VlU0pxHPDDlkjvOcvLktGHYYxQO2koicwGl8LhGJ1rtZlw2Z9IKjN7eNpP3wB3H4UmDVs+2rrAiM7PciTXbGsD/NfeUApsOlRsT1OGr+1naNoh/V7QKTog5lLhn1SRM8jxgqEDZl/QuyatxFzVjThn802zOCOrmnhBwVs20rUq51D3Jo3FYMr8K5jV+X6/eWIU/C5cRb0xRgEbyb6ZsZu1hDJ1TCSn6DLBl4vVmDhQJVFo7cnFMjPXgmTQQrKV0TcF8GvghfYleFnKJuYo1OIa6FHz44o2YEt/pN8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <638A2623C2F57C429791D8E55E70280B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a691197-5f9c-42f0-9b94-08d74c87c4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 07:10:29.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkkqd90mkG63bq08tXwJNOWFw5sQe2t7otdYoLHaQajupNQtxdz+jhwIVBzzxXQyyBcwryF50bMh3biY+cEuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_03:2019-10-08,2019-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=916 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910090066
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDEzOjExIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiANCj4gT24gVHVlLCBPY3QgMDgsIDIwMTkgYXQgMDM6NTk6NDlQTSArMDAwMCwgU2EsIE51bm8g
d3JvdGU6DQo+IFsgLi4uIF0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWN0bC0+aXJxID0gcGxhdGZv
cm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gPiA+ID4gKwlpZiAoY3RsLT5pcnEgPCAwKSB7DQo+ID4g
PiANCj4gPiA+IFRoaXMgY2FuIHJldHVybiAtRVBST0JFX0RFRkVSLiBPbiB0b3Agb2YgdGhhdCwg
aXQgYWxyZWFkeQ0KPiA+ID4gZ2VuZXJhdGVzDQo+ID4gPiBhbiBlcnJvcg0KPiA+ID4gbWVzc2Fn
ZSwgbWVhbmluZyBhbm90aGVyIG9uZSBoZXJlIGlzIHVubmVjZXNzYXJ5Lg0KPiA+IA0KPiA+IFdo
eSByZXR1cm5pbmcgLUVQUk9CRV9ERUZFUj8gcGxhdGZvcm1fZ2V0X2lycSgpIGFscmVhZHkgc2Vl
bXMgdG8NCj4gPiBoYW5kbGUNCj4gPiBFUFJPQkVfREVGRVIuLi4NCj4gPiANCj4gLi4uIHdoaWNo
IGlzIGV4YWN0bHkgd2h5IEkgYW0gc2F5aW5nIHRoYXQgeW91IGRvbid0IG5lZWQgYW5vdGhlcg0K
PiBlcnJvcg0KPiBtZXNzYWdlLCBhbmQgdGhhdCBhbiB1bmNvbmRpdGlvbmFsIGVycm9yIG1lc3Nh
Z2UgaXMgYSBiYWQgaWRlYS4NCj4gDQoNCkFoaGgsIHNvcnJ5LiBJIGNvbXBsZXRlbHkgbWlzdW5k
ZXJzdG9vZCB5b3UgOigNCg0KTnVubyBTw6ENCg0KPiBHdWVudGVyDQoNCg==
