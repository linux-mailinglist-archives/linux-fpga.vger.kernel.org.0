Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63594EF7CF
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Apr 2022 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349126AbiDAQV5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 1 Apr 2022 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354790AbiDAQUq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 1 Apr 2022 12:20:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30592FF;
        Fri,  1 Apr 2022 08:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQe3tqYwNXcqQVK1tbtMHuJU8OcEtDIY5FrGRm802IKMAuMXmgH43pUbQ9fsngIV+06zeI3WQwXI3UVwXmYgUPE0OjguG2Xo5LaDQON1aat63XARBLawo5J7c2Pw8wXaTHRZI7/qkfjXzDkyzYU/Qgpw94ks+OQBj9MgXS88+iOwyNCZEKLVyc7ist5bKBkVs8Nv8uurRfN5U4MVY7DWsR+Z0vZ6hzaKXLNdSOQne0B5iCzmQQR8dOf0gGIBFt+1u1dAo1x8YPDqt9/iEqq0tUhciElob2DuUa3NOpq/KqXaD3SROkkmgTFBCzAXC3W7qTfZ5EymWsQ310SQyLvtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJxsNom24ingnSg0AJmxdPagmiEILGL/8OVovgQvVVw=;
 b=i5APdBxReMjBmA9/uWBlPs7eaRvwivJmjL6NSuSwD8U3dXA9IgSNbvbhd82CGeNT7X2MHPT/7WhKuUgGlGQ2nhPFLE4sVh3bOxXUXAgCcCwUCE0U1xBA9/X/7RvjNjQNW4yr2LqKMStLAj+bJLUleYRXdGHtiVuJIbZb14wChmr32mN3kxlloK2UgFhkzw+biqAegmgoj7n17Um22RR1q3cNOL8H85gSMtskh2MF7VheLgXZPflMQ/gFOs15KBoUSSU+Vav4zAkz6XaAjqNHIYfNj+eoOMQsllwIxsTOzACatFcdWPo2BFsU/E9osz5MOFZsI0d1XX1qEb75dk8Ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJxsNom24ingnSg0AJmxdPagmiEILGL/8OVovgQvVVw=;
 b=fhQ7ZEQ93ZKYtsxW5xZuqPnWIJvZiI1DpmqD+J7qkorNehJWX0o/Od5Q0nzIJ/geH55SGQXgiDpgHv2JziQsXK3MQ08xOApecajgUtlLzgSHrDOCMd0Az22Dmn2oxh3hlUjyEbOHvpqvyIePe18HFP15vHV0wHRpLLe0bsjS+O0=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by MW4PR02MB7267.namprd02.prod.outlook.com (2603:10b6:303:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 15:50:06 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:50:06 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2 3/5] fpga: fpga-mgr: Add missing kernel-doc description
Thread-Topic: [PATCH v2 3/5] fpga: fpga-mgr: Add missing kernel-doc
 description
Thread-Index: AQHYPcX9E8cVgJ/3HUa91M50ib4NFazR7A8AgAlYBmA=
Date:   Fri, 1 Apr 2022 15:50:06 +0000
Message-ID: <SN6PR02MB457616C635EC0F2879972B5DC2E09@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-4-nava.manne@xilinx.com>
 <1ae23c94-ff10-5033-b3aa-75ec5b755a97@redhat.com>
In-Reply-To: <1ae23c94-ff10-5033-b3aa-75ec5b755a97@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 380b0b15-f1cb-4b6f-77a5-08da13f74b3c
x-ms-traffictypediagnostic: MW4PR02MB7267:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MW4PR02MB7267411611EC707631747AC6C2E09@MW4PR02MB7267.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3RkU4ajWj+UbHrujEXpuFZzLu/2twRYK24rQXL5jUW1TFFJW+DTvZmCLRmzuDkmKZADAvMU1mdyRZ0mAcsluaz5oROlnmLwT1C7cRYGj9D0Y0VPzyVngaEYNK7OsZY/ztbkApL80nlN5R82WJE0adqgz5wPQ7814iJwgyGja7+B8oob/PHaYknmLyNK5xZPHSCfU7pV9y0sdiNlT6lSkgj7kzPgLyLLVezC03kYm3gT583Y0nG9gOfRYTItBSBN0DIfvmU5YNYYyCjYWM7rKgXgmkbKJhvwTxEFQJc60HHlIBtaWYvcpuNBL7caerGuV5RhDMxPTpyQdgTdj89lp3JFElga8+T2cWio2JsJd7jnyhGPVzwVDNGuqOWwbquIvgBwlVx9GEDeQgmCufh+YvY8Png2xYToflE90ZFP6vmXOpNzA2hl/tWBOg3L0e0r4hnbezg4l5fFEqg36t+reRYjlHwNBpt3kIFKViOQoN9GbBzQex3zuc1zrpU+U+3MU5azl6MFGlZHy1oFqLVXMnIgjSyR/7/IqqyJPKrpBm4aR62dRIGiY0TV1GvpC/MiigfHINV1OHnmEA35Jrz1TKiVv32iX2CYt+Z/D5GKpCTN3/gGWOhSaR8zn3U4BOSCS5Bmus1rBfIRA6WDIxRjSStC/VowuPHPCrnE8TPq6cjyNNuzmHtZLVL5tccMgXfkAbS7asn79QWcS6BHvgfNt6FgFWSoYnL4jmwGWrEdVSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(52536014)(316002)(38070700005)(6636002)(26005)(186003)(508600001)(8936002)(83380400001)(4744005)(5660300002)(33656002)(66556008)(86362001)(55016003)(38100700002)(110136005)(53546011)(66476007)(7696005)(66946007)(8676002)(64756008)(76116006)(2906002)(66446008)(9686003)(6506007)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1FHekswekt1Vkt1dDA1MjFFZXR4T1ZhQnJ0NnN6RGQvOHJVVmJtUWF5S2hV?=
 =?utf-8?B?b1c5ZjVrTFdzbS9sNW9yYXE2MTlCK2tId3pZWEMrSmlkdWhJRHhQQUgrTzhM?=
 =?utf-8?B?YVUrMHpZOWdoR1BQMk5CMXhrMkkraSttMFFOMW9vZ0NGbWQrMUtoeHBjWGwy?=
 =?utf-8?B?WHNxaC8wVnFyY3hBalRIYmlPRmtzYy9nN0wwc25GS1ZUdHdOSjlQV1psYVVi?=
 =?utf-8?B?Z2dBOEJqWGdFUFF0alB6amlXSmhLQy9BVmI2aWd3OWxiQ0twSkxOc3Nsd3hL?=
 =?utf-8?B?VmRuTEY4MzRIVm9yaDZGMCtGRk1qYkdkUjNvbTFmMXhTQ2t1SldnOG0wOXBm?=
 =?utf-8?B?bnIyR3pabHB5V1FpYk1wSW5JNXdxS3hieDVPQUp1Y01JZkVnLzVOQVNVNmhq?=
 =?utf-8?B?Zjk5V1M5RmlkZ2ZVUXdVR3FQeFBkVGYyUlpBYU44R3BJUzAwUHVKTzIrMGEx?=
 =?utf-8?B?ZW9NVzlDQWdtejNOU09ib0pwMUJpTzZKZ2lHcnFqL3Zwc2JtbkJlVjlITkw0?=
 =?utf-8?B?MDFlZEFQaE9IdHdvRmJURkppT3h6VlRQTGkyUlZWR084MVdtODlPaW9RSVEr?=
 =?utf-8?B?VVpQVUYvcGZQc0dhS1V2K0lEeWh0aENOQUQvNVJ5VlFDMm5YT3ZENDgzWGpH?=
 =?utf-8?B?SXhMUzBjWEpYQ2drTXZwNVF2dldBOXpINnBJY21PTVJ4a3JRNjlFQkhlWFpq?=
 =?utf-8?B?M3JZQXNUK2hXNWZpZkFGRVdtdkxFSDJSRWl2ZC9mUjRPbWRrVUhUOFlCVWU4?=
 =?utf-8?B?M2dMc3JJVk4yaVloMm1NNElvR3lYaW80Vzd3ZlpSOVZYQUJCa1NXY2t6Tktm?=
 =?utf-8?B?VkNiNGtsWVBmTlUwSGJkV3JCOXBLbVo5a3VPSjcrNWhGdHZvM0ZHTEZoMVFq?=
 =?utf-8?B?YlJBMFJDTEZBd1Zjck5Ib2JPSG9zSncwQ3c0czBBcU45cFVBRkJJdWJ0b2Rr?=
 =?utf-8?B?TGRLZWJZWEgwdkg1NElnaHZ5Q3MyWnpIY2FnUXRJWmY1MnFtdm1BdmdwdWQv?=
 =?utf-8?B?Z3JPK2VGclZZTE1OdUtnVmdSN2tsUGs0MGVxaVFHNXh0V3NCRGRnMUNvNCtz?=
 =?utf-8?B?RU9ZbzBJSmVlNVNVa3VwUm1uY2NEelI1WDMyRG5XK3ppSy8vU2F2azR5WUp5?=
 =?utf-8?B?d1Y0aEJrT2l5b2R0WHJQUDN4alRpenF4c3JKZ0plKzdGN092RVhFcG1tSE83?=
 =?utf-8?B?dld1eFhDaGpVcFNsTkY4WG9Cd1F2YnE0SW52VEE4NStBZk1OWnhBVCtaWUwy?=
 =?utf-8?B?OTRzWE1CbXdKQ3J1ZDVLVFRNb3ZHWkdoR3RERTBwUzZtVWlJT1RESk5wWmt5?=
 =?utf-8?B?M1loTEFWaS9ocmkrZDVpRlFkUUlBdm5lbzc1V1dyaUtCVS8vWEk3KzhwenNl?=
 =?utf-8?B?bjY3S0ErczBJTitoWER2K1VWTzlzRDJzQmVTZkxHRGFwRGFLekVobVNSL3RT?=
 =?utf-8?B?VUdOTGlDWkZwaGxtRVg2cmRpQzhvTVZDdGRSb2pOY2hKUkhBU2pTSkdRa2R5?=
 =?utf-8?B?WlNLZ2Z6SUZGKzZULy81VlBVQXNUcUJRRHdTeTlxZXJ5MkNYekErSGhkdWM2?=
 =?utf-8?B?UzlYNktUM1lFem1BNUYwY0diSHc3KzNYZk1OWEJBQmEzWW9iTlA4eUtZTGxm?=
 =?utf-8?B?YkF4S2ZIVStBMjRjL2NIRk1oVjF3Mzg1M1RVNkFYREwycDA2dGNpakJYdXZD?=
 =?utf-8?B?VmJ3NnZlckJDMEJwU1MyY05zUXpjdjd5amRiSVdpVUtvTGdkRWpHaFJDYkxC?=
 =?utf-8?B?NlJMZnkwTGlBOEVCajVEaFNkcGV2SU95UDR0NFVHTlhHNkpucGJwNUxrNTVU?=
 =?utf-8?B?OTAzcTNCbk1RbExJQncrcUdoN3h3bUxEWHA5V1dxVnA1TkFMUy9WQXgrQkZD?=
 =?utf-8?B?VEtVdE5VYjlnOU4rYWo0aWIyZXZhWm95R3Ntb2pYV0FJeWxkZHRlQ1dtcG9j?=
 =?utf-8?B?UkZVKy9rNmJUdDNZSlNJZVpseiswMWNnMjRpUG5TVjVHcHo4TGluMXM2eWs3?=
 =?utf-8?B?TnZoSjNwaW04NTloUWJnRm5ST05tYTNJOWdocmdabVFSaWJCSVFleEFxZGJ5?=
 =?utf-8?B?NnRCRVNwZWJ5ZVllRG1KdUE5R3AvQUw5NTN4RGo4SXIzanZsM01IQ2RwWHZu?=
 =?utf-8?B?RjhEOXJ3VzdVUDhNT2tITkFHRXp4TUZaajJ3NHhkUHEyaEd2eXI4UEc4MFRF?=
 =?utf-8?B?b1p0bzBMakc5SE1EVmpob3RzR0xjWVdLS3ZrS20zOEcxdlQza0ZqOHp6ZjQw?=
 =?utf-8?B?TzQvaEFtNHFMMmh1T2hxd2tCY1hVQjBleDdPazAwNFNHcnIvTDMvVWpxSHdy?=
 =?utf-8?B?UXpVaXFTMVEyNXlMKzcxclR0ZDJ6RXYyRHZBaEpkVitrSEtKV1U0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b0b15-f1cb-4b6f-77a5-08da13f74b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 15:50:06.5356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceC7mrWmYgRtoHkLU63kfNxOxcvHDLNEUwtn3/VsPOcnw6WI+hOCZDxiDsS6ZDnMWB8BtvzL6DmyO7D0vvYBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7267
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50cy4NClBs
ZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBNYXJjaCAyNiwgMjAyMiAxMDozNiBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZh
bUB4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7DQo+IGhhby53dUBpbnRlbC5jb207IHlpbHVu
Lnh1QGludGVsLmNvbTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51
eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ2l0DQo+IDxnaXRAeGlsaW54
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGZwZ2E6IGZwZ2EtbWdyOiBBZGQg
bWlzc2luZyBrZXJuZWwtZG9jDQo+IGRlc2NyaXB0aW9uDQo+IA0KPiANCj4gT24gMy8yMi8yMiAx
OjIyIEFNLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gRml4ZWQgdGhlIHdhcm5pbmdz
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd4eHgnIG5vdCBkZXNjcmliZWQuDQo+IA0K
PiBIb3cgd2VyZSB0aGUgd2FybmluZ3MgZ2VuZXJhdGVkID8NCj4gDQpJIFdpbGwgdXBkYXRlIHRo
ZSBjb21taXQgbWVzc2FnZSBpbiB2My4NCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
