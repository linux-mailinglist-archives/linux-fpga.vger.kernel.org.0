Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9ECE6D8
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2019 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfJGPJn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Oct 2019 11:09:43 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65128 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbfJGPJm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Oct 2019 11:09:42 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97F8voT031243;
        Mon, 7 Oct 2019 11:08:59 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2veqt58a5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 11:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVYKeJ0upOWhC9zpzC8XB0LRrlZih6VOeEKnLBkYCCgYKlPJ4MxfpqzsnCLTNR3z0U+mAJMimOzdkfzmTfNNI/T7mnU1iErcfKe+RocrgFrxIf6S2f+U+lZv5SEsdDeQ7Xte9Ae019elJmMSKOamHQ28ixbwCDAVQnsPXvxp+v594urvJunk221I9+SY1QMwqF4CnAk6xQSHXRaw69Lhv7UViUQhoHAEOjLH7jxTzDRtK/4vgRnk6sN/4XyLVRwpdr29z/LVo15RlOZ7ySIfgXYrXGqlBlTiR1U9GJz/rznwj/TkEOQsIVi6SNmBxfo8OleMMV6/8MORsHJyk5Sidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLsNGdP+ORZKCykRR64suDQXCtVWKW3NUZJfcGcftbs=;
 b=OU0FOut5bCMLTkCDHwdnkhBaTfr2hBmFj4Cdf01AChP6RKZXLo84yeiec4qw0nLdb/5ElzL5FtGHyT5lA4O71LGIgEa4xyhaa0xfTuG/YV0+Y88rpfLG/2yRq/3BeADpU7V22hta62aVbtPI2kRHQfYPyThf+pQw1khAOBCk/COhjwjkjC/SVjHzCKhUEei9Ssp/+4mtjxVA70QZ+Ii0+XoKeDowEl34jw2OmnZhjTRvyxT8lIEGZAuq7bDfiBqSxsnZ0j2tdEkmwFjskwrAqzrDH11Cr5v5eDo4qTJ6Y8HHmo5l4RdClsw7Fa2ClGQcTssmJiu/Jgg0BapRfCEsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLsNGdP+ORZKCykRR64suDQXCtVWKW3NUZJfcGcftbs=;
 b=h9VN9Q8AtKaDPG/QmYIWyg0UzvAdjTUDtk7fPIgFIkcXFslPD9H/OTigkaP2LJCYhgXpvWcVVlTqMPezidHg4eR7WJfNgD6kKoi3sndA9Z11Kkjg3NgX4SwTQNfM9wpH/qrzf9gMTx59ik8+F0jxMwSwqdAsQD1QIHfXLDVwzbk=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB4975.namprd03.prod.outlook.com (52.132.168.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Mon, 7 Oct 2019 15:08:55 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5%7]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 15:08:55 +0000
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
Thread-Index: AQHVdFa03kFb3oEkSUeluAbSCPFerqdNzcGAgAF2kACAAAc5gIAADi2A
Date:   Mon, 7 Oct 2019 15:08:55 +0000
Message-ID: <014f3cd33766dbe32d24eebe74724df596685109.camel@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
         <20190926103925.194973-3-nuno.sa@analog.com>
         <20191006153209.GA30372@roeck-us.net>
         <9a3bec277caaabffb75248ddc6fbb89b5d95da5b.camel@analog.com>
         <8f6e8513-eba1-39ad-cb7c-d92afa9e0b92@roeck-us.net>
In-Reply-To: <8f6e8513-eba1-39ad-cb7c-d92afa9e0b92@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14486973-53eb-4832-043c-08d74b38458a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR03MB4975:
x-microsoft-antispam-prvs: <MN2PR03MB49751C4E23535AD5EB746443999B0@MN2PR03MB4975.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(446003)(11346002)(476003)(6116002)(186003)(2501003)(2616005)(25786009)(26005)(3846002)(6916009)(54906003)(5660300002)(316002)(66066001)(66446008)(1730700003)(118296001)(91956017)(66476007)(81156014)(66556008)(64756008)(8936002)(81166006)(76116006)(8676002)(66946007)(2906002)(486006)(86362001)(36756003)(2351001)(6246003)(76176011)(6512007)(6436002)(14454004)(6486002)(305945005)(5640700003)(478600001)(71200400001)(71190400001)(256004)(99286004)(14444005)(229853002)(4326008)(6506007)(53546011)(102836004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4975;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWboWkM6hDFsxx4guulmWo/b3nC9HzJCEzzRNQKW1MwhRkizka02fhVuZejuKDsrbBRapqw7jFP/QJ7zQzYOABnxvhRNdq7LsPYplp2zbNHNEQX01M+ANv06nZIbETYp26H385lLA+e2f4ep3ZC8aAvpdPrw5zhsT/bK9OzN5CMLySghc0Z/8hQDFe3rXX0WcRFJjtrq3g1ybnkBszHmonhYNsmFqYkF/nLIXYk7AHayZSLxYq0zXjAs0Z9ToaLiDCC3S/DN/p83iGhve0O7kQtuIX1P6PrEYxtkGrBJIKvRRxTrgMmluczOtxM4K7p6aikVxsuLepvhbbRTIkCcJoAKb1ax6lo0YM5I9EzPyyQdbsKgBUOOZyk6rlkbn+nG59LoYDj5eDnzeqK7uY5/IWF9sh7wWW2gui9Dygxnzps=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <453E811B2965144A94193E2ABAB96382@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14486973-53eb-4832-043c-08d74b38458a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 15:08:55.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6PppRB/H9gf5IprHuWtM0Yc565HzMcBklxFGlB7kqsvDAAlvhUvpUFfgqIMXpIvnUW1VRFcFX0e2itfrW3Sug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_03:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070151
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTA3IGF0IDA3OjE4IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
DQo+IA0KPiBPbiAxMC83LzE5IDY6NTIgQU0sIFNhLCBOdW5vIHdyb3RlOg0KPiBbIC4uLiBdDQo+
ID4gPiA+ICtzdGF0aWMgbG9uZyBheGlfZmFuX2NvbnRyb2xfZ2V0X3B3bV9kdXR5KGNvbnN0IHN0
cnVjdA0KPiA+ID4gPiBheGlfZmFuX2NvbnRyb2xfZGF0YSAqY3RsKQ0KPiA+ID4gPiArew0KPiA+
ID4gPiArCXUzMiBwd21fd2lkdGggPQ0KPiA+ID4gPiBheGlfZmFuX2NvbnRyb2xfaW9yZWFkKEFE
SV9SRUdfUFdNX1dJRFRILCBjdGwpOw0KPiA+ID4gPiArCXUzMiBwd21fcGVyaW9kID0NCj4gPiA+
ID4gYXhpX2Zhbl9jb250cm9sX2lvcmVhZChBRElfUkVHX1BXTV9QRVJJT0QsDQo+ID4gPiA+IGN0
bCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gRElWX1JPVU5EX0NMT1NFU1QocHdtX3dp
ZHRoICogU1lTRlNfUFdNX01BWCwNCj4gPiA+ID4gcHdtX3BlcmlvZCk7DQo+ID4gPiANCj4gPiA+
IElzIHB3bV9wZXJpb2QgZ3VhcmFudGVlZCB0byBiZSAhPSAwID8NCj4gPiANCj4gPiBZZXMsIEl0
IGlzIGEgUk8gcmVnaXN0ZXIgYW5kIGl0IGlzIHNldCBieSB0aGUgY29yZSB3aXRoIHRoZSBkZWZh
dWx0DQo+ID4gb2YNCj4gPiAweDRlMjAuDQo+IA0KPiBUcnVzdGluZyB0aGUgaGFyZHdhcmUgZG9l
c24ndCBtYWtlIG1lIHRvbyBjb21mb3J0YWJsZS4gQXJlIHdlIHN1cmUgYXQNCj4gYWxsDQo+IHRp
bWVzIHRoYXQgdGhlIEhXIGlzbid0IG1lc3NlZCB1cCA/IElmIHNvLCBwbGVhc2UgYXQgbGVhc3Qg
YWRkIGENCj4gY29tbWVudA0KPiBzdGF0aW5nIHRoYXQgdGhlIEhXIHdpbGwgbmV2ZXIgcmV0dXJu
IDAuIFdlIGNhbiB0aGVuIGZpeCBpdCBhZnRlciB3ZQ0KPiBnZXQNCj4gdGhlIGZpcnN0IGNyYXNo
IHJlcG9ydCBmcm9tIHRoZSBmaWVsZCA7LSkuDQoNCldpbGwgZG8gdGhhdC4NCg0KPiBbIC4uLiBd
DQo+IA0KPiA+ID4gPiArCWlmIChpcnFfcGVuZGluZyAmIEFESV9JUlFfU1JDX1RFTVBfSU5DUkVB
U0UpDQo+ID4gPiA+ICsJCS8qIGhhcmR3YXJlIHJlcXVlc3RlZCBhIG5ldyBwd20gKi8NCj4gPiA+
ID4gKwkJY3RsLT5od19wd21fcmVxID0gdHJ1ZTsNCj4gPiA+ID4gKw0KPiA+ID4gSSBkb24ndCBy
ZWFsbHkgdW5kZXJzdGFuZCB0aGUgbG9naWMgaGVyZS4gSWYNCj4gPiA+IEFESV9JUlFfU1JDX1RF
TVBfSU5DUkVBU0UgbWVhbnMNCj4gPiA+IHRoYXQgaGFyZHdhcmUgd2FudHMgYSBuZXcgcHdtLCBo
b3cgaXMgdXNlcnNwYWNlIGluZm9ybWVkIGFib3V0DQo+ID4gPiB0aGF0DQo+ID4gPiByZXF1ZXN0
ID8NCj4gPiANCj4gPiBJdCBpc24ndC4gVXNlcnNwYWNlIHdvdWxkIGhhdmUgdG8gcmVhZCB0aGUg
cHdtIGF0dHJpYnV0ZSBhbmQgZmlndXJlDQo+ID4gdGhhdCBjaGFuZ2VkLiBTaG91bGQgSSB1c2Ug
c29tZXRoaW5nIGxpa2Ugc3lzZnNfbm90aWZ5KCkgb24gdGhlIHB3bQ0KPiA+IGF0dHJpYnV0ZT8N
Cj4gPiANCj4gVGhhdCBtaWdodCBtYWtlIHNlbnNlLg0KPiANCj4gPiA+IEFuZCB3aHkgYXJlIHRo
ZSB0YWNobyBwYXJhbWF0ZXJzIF9ub3RfIHVwZGF0ZWQgaW4gdGhpcyBjYXNlIGxhdGVyDQo+ID4g
PiBvbg0KPiA+ID4gKHVubGVzcw0KPiA+ID4gQURJX0lSUV9TUkNfUFdNX0NIQU5HRUQgYW5kIEFE
SV9JUlFfU1JDX1RFTVBfSU5DUkVBU0UgYXJlIGJvdGgNCj4gPiA+IHNldCkgPw0KPiA+ID4gSXQg
bWlnaHQgYmUgdXNlZnVsIHRvIGRlc2NyaWJlIHRoZSBleHBlY3RlZCBzZXF1ZW5jZSBvZiBldmVu
dHMuDQo+ID4gDQo+ID4gVGhlIGNvcmUgY2FuIGNoYW5nZSB0aGUgUFdNIGJ5IGl0c2VsZiAod2hp
Y2ggaXMgd2hlbiB3ZSByZWNlaXZlDQo+ID4gQURJX0lSUV9TUkNfVEVNUF9JTkNSRUFTRSkgYW5k
IGluIHRoYXQgY2FzZSBpdCB3aWxsIHVzZSBwcmVkZWZpbmVkDQo+ID4gdmFsdWVzIHRvIGV2YWx1
YXRlIHRoZSB0YWNobyBzaWduYWwgKHNvIGl0IHdvbid0IHVzZSB0aGUgdmFsdWVzIG9uDQo+ID4g
VEFDSF9QRVJJT0QgYW5kIFRBQ0hfVE9MRVJBTkNFKS4gQWx0ZXJuYXRpdmVseSwgdGhlIHVzZXIg
Y2FuDQo+ID4gcmVxdWVzdCBhDQo+ID4gbmV3IFBXTSBieSB3cml0aW5nIHRoZSBwd20gYXR0cmli
dXRlLiBJbiB0aGlzIGNhc2UgdGhlIENPUkUgaXMNCj4gPiBleHBlY3RpbmcgdGhhdCBUQUNIX1BF
UklPRCBhbmQgVEFDSF9UT0xFUkFOQ0UgYXJlIGdpdmVuIG90aGVyd2lzZQ0KPiA+IGl0DQo+ID4g
d29uJ3QgZXZhbHVhdGUgdGhlIHRhY2hvIHNpZ25hbC4gTm90ZSB0aGF0IHdoZW4gaXMgdGhlIHVz
ZXIgd2hpY2gNCj4gPiByZXF1ZXN0cyBhIG5ldyBwd20gd2Ugb25seSBnZXQgQURJX0lSUV9TUkNf
UFdNX0NIQU5HRUQgKGFuZCBub3QgKwkNCj4gPiBpZiAoaXJxX3BlbmRpbmcgJiBBRElfSVJRX1NS
Q19URU1QX0lOQ1JFQVNFKSwgc28gSSB1c2UgdGhhdCB0byBrbm93DQo+ID4gd2hlbiBkbyBJIGhh
dmUgdG8gdXBkYXRlIHRoZSB0YWNobyBwYXJhbWV0ZXJzLg0KPiA+ICAgDQo+IFdvbmRlcmluZyAu
Li4gaWYgc2V0dGluZyB0aGUgcHdtIHJlcXVpcmVzIGFuIHVwZGF0ZSBvZiBwZXJpb2QgYW5kDQo+
IHRvbGVyYW5jZSwNCj4gd2h5IG5vdCBzZXQgdXBkYXRlX3RhY2hvX3BhcmFtcyB0byB0cnVlIHdo
ZW4gdGhlIHB3bSB2YWx1ZSBpcw0KPiB3cml0dGVuLCBvcg0KPiB1cGRhdGUgdGhlIHJlZ2lzdGVy
cyBkaXJlY3RseSBpbnN0ZWFkIG9mIHdhaXRpbmcgZm9yIGFuIGludGVycnVwdCA/DQoNCkFmdGVy
IHJlcXVlc3RpbmcgYSBuZXcgZHV0eS1jeWNsZSB0aGVyZSBpcyA1cyBkZWxheSBvbiB3aGljaCB0
aGUgY29yZQ0Kd2FpdHMgZm9yIHRoZSBmYW4gcm90YXRpb24gc3BlZWQgdG8gc3RhYmlsaXplLiBP
bmx5IGFmdGVyIHRoYXQsIHdlIGhhdmUNCnRvIHByb3ZpZGUgdGhlIHRhY2ggcGFyYW1ldGVycy4g
QWxzbyBub3RlIHRoYXQgd2UgZG8gbmVlZCB0byB1c2UgdGhlDQp1cGRhdGVkIHRhY2ggbWVhc3Vy
ZW1lbnQgdmFsdWUgdG8gZGVyaXZlIHRoaXMgcGFyYW1ldGVycy4gU28sIHdlIG5lZWQNCnRvIHdh
aXQgZm9yIHRoZSBBRElfSVJRX1NSQ19ORVdfTUVBU1VSIGludGVycnVwdC4NCg0KPiBFaXRoZXIg
Y2FzZSwgSSB0aGluayB0aGUgYWJvdmUgc2VxdWVuY2Ugb2YgZXZlbnRzIHNob3VsZCBiZSBleHBs
YWluZWQNCj4gaW4gdGhlIGRyaXZlciBmb3IgZnV0dXJlIGRldmVsb3BlcnMgdG8gdW5kZXJzdGFu
ZCB3aHkgdGhlIGNvZGUgaXMNCj4gd3JpdHRlbg0KPiB0aGUgd2F5IGl0IGlzLg0KDQp3aWxsIGRv
IHRoYXQuDQoNCj4gPiApDQo+ID4gDQo+ID4gPiA+ICsJaWYgKGlycV9wZW5kaW5nICYgQURJX0lS
UV9TUkNfVEFDSF9FUlIpDQo+ID4gPiA+ICsJCWN0bC0+ZmFuX2ZhdWx0ID0gMTsNCj4gPiA+IA0K
PiA+ID4gSXMgaXQgb24gcHVycG9zZSB0aGF0IHRoaXMgYml0IGlzIG5ldmVyIHJlc2V0ID8NCj4g
PiANCj4gPiBZZXMsIGFuZCBpdCBpcyB3cm9uZy4gSSB0aG91Z2ggdGhhdCB0aGUgY29yZSB3b3Vs
ZCBuZXZlciBjbGVhciB0aGlzDQo+ID4gYWxhcm0gYnV0IGl0IGRvZXMgY2xlYXIgaXQgaW4gdGhl
IG5leHQgdGVtcGVyYXR1cmUgcmVhZGluZyBjeWNsZQ0KPiA+IChhbmQNCj4gPiBzZXQgaXQgYWdh
aW4gaWYgbmVlZGVkKS4gVGhlbiwgd291bGQgYSBjbGVhciBvbiByZWFkIGJlIGEgY29ycmVjdA0K
PiA+IGFwcHJvYWNoPw0KPiANCj4gTm90IHN1cmUgaWYgdGhlcmUgaXMgYSAiY29ycmVjdCIsIGJ1
dCBJIHRoaW5rIGl0IHdvdWxkIG1ha2Ugc2Vuc2UuDQo+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsJ
LyogY2xlYXIgYWxsIGludGVycnVwdHMgKi8NCj4gPiA+ID4gKwljbGVhcl9tYXNrID0gaXJxX3Bl
bmRpbmcgJiBBRElfSVJRX1NSQ19NQVNLOw0KPiA+ID4gPiArCWF4aV9mYW5fY29udHJvbF9pb3dy
aXRlKGNsZWFyX21hc2ssDQo+ID4gPiA+IEFESV9SRUdfSVJRX1BFTkRJTkcsIGN0bCk7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+
ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgYXhpX2Zhbl9jb250cm9sX2luaXQoc3RydWN0IGF4aV9m
YW5fY29udHJvbF9kYXRhDQo+ID4gPiA+ICpjdGwsDQo+ID4gPiA+ICsJCQkJY29uc3Qgc3RydWN0
IGRldmljZV9ub2RlICpucCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJLyogZ2V0IGZhbiBwdWxzZXMgcGVyIHJldm9sdXRpb24gKi8NCj4gPiA+
ID4gKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgImFkaSxwdWxzZXMtcGVyLQ0KPiA+
ID4gPiByZXZvbHV0aW9uIiwNCj4gPiA+ID4gJmN0bC0+cHByKTsNCj4gPiA+ID4gKwlpZiAocmV0
KQ0KPiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gDQo+ID4gPiBTbyBhbGwgcmFuZG9tIHZh
bHVlcyBhcmUgYWNjZXB0YWJsZSwgaW5jbHVkaW5nIDAgYW5kIDB4ZmZmZmZmZmYgPw0KPiA+IA0K
PiA+IFllcywgSSdtIGF3YXJlIHRoYXQgMSBhbmQgMiBhcmUgdHlwaWNhbCB2YWx1ZXMgYnV0IEkn
bSBub3Qgc3VyZQ0KPiA+IHdoYXQgaXMNCj4gPiB0aGUgbWF4aW11bSB0aGF0IHR5cGljYWxseSBl
eGlzdHMgc28gSSBkaWRuJ3Qgd2FudCB0byBwdXQgbGltaXRzDQo+ID4gaGVyZQ0KPiA+IHdpdGhv
dXQga25vd2luZy4gVGhvdWdoIGF0IGxlYXN0IDAgbXVzdCBub3QgYmUgYWNjZXB0ZWQgc2luY2Ug
dGhlbg0KPiA+IHdlDQo+ID4gYXJlIGFsd2F5cyBkaXZpZGluZyBieSAwIHdoZW4gcmVhZGluZyB0
aGUgRkFOIHJwbS4NCj4gPiANCj4gVGhlIG9ubHkgdmFsdWVzIEkgYW0gYXdhcmUgb2YgYXJlIDIg
YW5kIDQuIEkgZG9uJ3QgcmVjYWxsIHNlZWluZyBhbnkNCj4gZmFucw0KPiB3aXRoIDEgcHVsc2Ug
cGVyIHJldm9sdXRpb24uIE92ZXJhbGwsIEkgZG9uJ3QgdGhpbmsgdmFsdWVzIG90aGVyIHRoYW4N
Cj4gMSwgMiwNCj4gYW5kIDQgbWFrZSBzZW5zZS4NCg0KIFdpbGwgdXNlIDEsMiBhbmQgNCBhbmQg
dXBkYXRlIGR0IGJpbmRpbmdzIGFjY29yZGluZ2x5Lg0KDQo+IEd1ZW50ZXINCg0K
