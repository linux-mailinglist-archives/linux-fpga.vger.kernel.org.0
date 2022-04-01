Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77614EF7C8
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Apr 2022 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351043AbiDAQV7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 1 Apr 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354803AbiDAQUq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 1 Apr 2022 12:20:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD621BC58;
        Fri,  1 Apr 2022 08:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/5nf3PCpg4fhsIuMlCFDuNw4GwWq6ZBg5duvBhgvi0z2K0/3xFtKgAgtfeKxREz3MU+j9coFtXDUiOehqF1spL4Q8o+bVa2SUX1TVAWYbovzH4fDj065c1F+dl/xc+S8J7oSquF564Wt7C7p09U6LtuAnRW4LeK86puIff2aadU/BFMLidaP3RgNN96/AUTzdIZ2EIn9EXtqii2hF+FB46Lpx7UcyVVpvmArNCLW1HdRWcea4EAqjW1m+qZ+47bWv4FcJM5voPZ3S+SUfIi/o7IdTNL0gUBC6yRVBpIWs/6J0dcmOIdkZNRhc9vBlodXlWYgJwT8oHQ33MrsZ9MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcSHnqY3jf2jRRx9J4k5+bJGR88NmfV78QiYymnyH6w=;
 b=EiVHiZAjXvPEkYIvvnjYxYQsi1SL4AEucLeY+7rNQruJYU+OGU52TBJQtPxuLznUOcfw02+ahASNjJrlwHOYXajZnKcZu2eobKzwKLoxNalO0z0xSqXeiEbqS7AjVqYILNubb3podNcNNNPRuKG6JWSKjkdllxDuad6Q0+19NluXDp8KDUNWuAdLreoIOMMyZXu2rMvrlU4bJ9RB/XEDyOaPkbEL3rkLXLyTi83Tc1TkCTrSQnLzJeFfG35R4Aa7W2igBAAsFe7Rdxv1TJHrSouTpn3UXZJ25bxeLvSBauUzejyIH9gpWT0+ggad96lsOYtZsNR+zO5QYfdzX7xHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcSHnqY3jf2jRRx9J4k5+bJGR88NmfV78QiYymnyH6w=;
 b=lw4WZzA/G3zLDBgqpx8++7Tp13HPJjYFT3+J1zynlGt9uDzT+t5Wv0654ogEN92ZoLJn01D/ahBz6h4IyAtDHId3O/0lUcOh/PbW71osT4zLO0zeWUAfVFdCq/GknrZDrZ3b0Xv936KZUWzSSzb/edzYkYjO/FNl7giOVKQcUqE=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by MW4PR02MB7267.namprd02.prod.outlook.com (2603:10b6:303:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 15:51:13 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:51:13 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2 4/5] fpga: Use tab instead of spaces for indentation
Thread-Topic: [PATCH v2 4/5] fpga: Use tab instead of spaces for indentation
Thread-Index: AQHYPcYBNQ9RlVVilEqPFEozrG9W56zR7MAAgAlYGEA=
Date:   Fri, 1 Apr 2022 15:51:13 +0000
Message-ID: <SN6PR02MB4576F18613B6C6B9E49DC2FBC2E09@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-5-nava.manne@xilinx.com>
 <f8929af9-daa4-2111-1dff-edbf1f2041e7@redhat.com>
In-Reply-To: <f8929af9-daa4-2111-1dff-edbf1f2041e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba8c60a4-5b60-4a80-ca3c-08da13f77353
x-ms-traffictypediagnostic: MW4PR02MB7267:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MW4PR02MB72679C3B1859826D34264E81C2E09@MW4PR02MB7267.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/AM+sivYuWqU39PGyN1rFGKOY77EFkMSyhurFjTs5pHA4aWhpT+VSKjtibUGX6i2BH644omwQ35AdxSdPd59IIKDalM2h9ZcJWWbSjjsnzFpdgoxVMu3TSDPJGlA77kMY3yJFpXGeYyraNcbO3WSvVt9mnazhi2IvhX6qujFLW1hM3rVJNGSjFXgErWyyXzK4WT3xOpTyLEAbQD31A7A1zmhLtehVLE9oVBu8rDUyxJv9yRU5KNppdKFxzisRFll3GOiF81BIkJ+g1kY2tLUURZTiFKexWihSqfbbpeFBxfIf4dhSLe3Whyim9n8dtIMYonT9YRw3pR+aTT5BRNp29NJgzckiKwXBevOmxTlAhM1x3U7aNUxDJw2it+G7nCGFktvlJDgT56L+rl8ILD82HcoxaZkxMi/rOtfsyZuQZgd4Z4H8WBtGRshVpyxd355TPVYeMGPzRjkzNmOoVtR4rTKqqzz5bZKkQ7e17LtJeKvXaIosD11mvPwknj1I22QLMOC2K4J9xm4jDcP9vS7JM6pj1twu1L+RyniLurML2zvM7m9gHRzO2YqNkq1r/GaamKIQ+DLxNTY+ITfecl/IEE0O+uNdy5ALgRWLOsp2E+i4sRVDLCrQkQjjMEndIlYuPmAABKA+4/7Mo45iYeAJFGGs2pgaIyNAUly2DyqO7iBVtCRR5VojOp97OAH7Q0qa5sdFsXwjcTCzzxtP+dFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(52536014)(316002)(38070700005)(6636002)(26005)(186003)(508600001)(8936002)(83380400001)(4744005)(5660300002)(33656002)(66556008)(86362001)(55016003)(38100700002)(110136005)(53546011)(66476007)(7696005)(66946007)(8676002)(64756008)(76116006)(2906002)(66446008)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3Z4Q0dCUTZMaWFkZVJnaXIxbER2S3JJb3F1UWZmbUwwUVozbVl1b1IwRCs4?=
 =?utf-8?B?Ti9VVTZiSVVyZU45cnhjdjVuT3Z2L2dpbllqM0VTN3czMVhvSTNCK1Z6blp0?=
 =?utf-8?B?ZmZHVUE2OUZnNmc2QVJPTFNQbDRpcjBQYUR3Wit0UTJzN0tRbGttcW5WcTVt?=
 =?utf-8?B?OXZvbDZkSUhqZ2dEYTJwNVRIRzZsNXBIOEhhQm9EVVEyb2NTWE11ZTBoSnBJ?=
 =?utf-8?B?SitEQ3I0cXhzQXo0WXozb05POCtzUG5IQytmZGNINkxKb3NvWXV2QkM1QWZD?=
 =?utf-8?B?UElkWWw5dXh4MzcrOU4xdXFsRzR6cFVLVmlUVVh6bzgxRHI0ZzZ3U0lNT1RI?=
 =?utf-8?B?REM2am50SGZxZEZrd1E4STc1ZXFRd3hxRzY2T2hNN0JPOW1DMFNDc3F2aU9B?=
 =?utf-8?B?Y1Z4bldHTU5lK1lmTlNjNmFjeXpGVHRLTlZtTW03K2ZNVVAySEtvZ1NUZHRy?=
 =?utf-8?B?VWtSbVg5UlN1cnhoeExTamdCTnNzR3J1ZG5iL2o5RU1CQzVMdW1Wd2F0SWJr?=
 =?utf-8?B?cXNjV2V5aW9KdnRneG8rRmswRlFxVWZ4NmFWTy9BRDE3a0dPd1R5Mm1jQkRO?=
 =?utf-8?B?Um10K1gwcWowSnZjTFZkRk1CWGZ2TFE5R3J6RFRDcTJBNlYveG1sRjVYOGhk?=
 =?utf-8?B?NnY4dUJUcWFFVFNIVWRqRTE3bi8xSVE1eEh0dVRtWVVnVDQ5K3B3Wm45ZEVL?=
 =?utf-8?B?Y0RURmRPT2cyemxuczQ2R2REdUk4d0xVeXlIS3NRWnZGRk1mc1lnSEl3UzRK?=
 =?utf-8?B?NGQ1cXA3SnZPNDdFRFNnczlCYnphN0ExS3NZMEgydUNJaWcrME1JaUtHR0x3?=
 =?utf-8?B?LzJRMHN4bHRRK2tRMWdwVGo2a3pjOXhOZ285eXJZNUJpdXhWOFRDL2MyeFBH?=
 =?utf-8?B?SGJpNDNCNzczUUhqL2dyd29CMDNwbndWc01FS0ZGVTE3RStrcXNpRXMwVkpw?=
 =?utf-8?B?N2pXZzBHUVBBWlcycG40VFI5VkNMUFZXbmtDdVNhUS9WR0ZVWUwwSTVMWVZt?=
 =?utf-8?B?bXg3N3NJT0h2Q0NkamtXY2hKQkZCdDBOT0F6ZllsSVF4MWZQbUlkM3UrbEUz?=
 =?utf-8?B?WDAyM0pMemk5S0RGWnhWYlpyWjgvTHhUSndHMEZlbFcrdThjRHlkWWp3aEQr?=
 =?utf-8?B?dHZJWFN6MWFYZmlQZ0wvSHdJZThWRHBBUlVUaVAvMWZiaThjajFXRDV6Q05Y?=
 =?utf-8?B?OXBNajNBRmxFdFJHOXh6a3hBMEkvUGh0cDJrRjQ4TkJIZC9jYzd4VWd4YTBC?=
 =?utf-8?B?ZnZ4UTE3R1JWM0xTVmdvWmxML1F2THQxazBwdmlMK2hxczZzRGVvRnAvREdF?=
 =?utf-8?B?RXlpYVJzM1gva08ydVlKWEdIVXh1MnNEMXpzQnFMQlVseTlveVNDNWM1UjFj?=
 =?utf-8?B?ekxIMEFrQnZYNkNYOHo2L3NMYldiT2tET1VGVWlVNXA2QlJPc3pUTUoyY1Zs?=
 =?utf-8?B?M01Pd0lIeWFxaVdKb3VZZ3R0TkJ0ZkYrMkxCV2dxZHRldi9UTm1yQWNMQ3BH?=
 =?utf-8?B?UEtvcE82ZGtKSjBBdWJQZFgwT1N4ZVhHelczUWgxNm5tV1MwaHNFeXdQT0ZU?=
 =?utf-8?B?Y3NVWVEwMGRmV05UWmJuaGRpTUVKcFVoYkh6dmw2SFVwNFlTUDFqVlpUZTh2?=
 =?utf-8?B?bEdjZEdlNmNEWE9ablBGRGNiSnplZEVPV2pwMmVjS3ptcHB2ODlaZlM1alhM?=
 =?utf-8?B?N1Z0d3B0N0pXV0t3ZGNkQUxmc0p1ZmwySnNDUGQwUENBM1VJNHN2UmhWaG1u?=
 =?utf-8?B?eWRqSjVRS2NENlBkeElkL1owUTlmcU5wT3FqVGJpSTJadlN6WXNvZXVQOG15?=
 =?utf-8?B?c0I1SmFPSWNGMEQvU1ppejUwTnlHRmNrdHlQUm9vUmNFWnRPK2pocVJuTkhs?=
 =?utf-8?B?d1Jtd2dNTXpzZTlBQ0p0MERWaEFBZ09OSUpBdllWdEV6Vi8rNVNydk9qTEIw?=
 =?utf-8?B?T05maFhVM0lmTnJuVGlCZE9CdWN1cVZkQXhlNCtlUm91QStJR3Y3Mlpoako0?=
 =?utf-8?B?S1YreVlOVGtqbHA2ajVEZ3ZZRFBVZUVhcEZaMXNaeURxdkdMTVd0OXd5OVJE?=
 =?utf-8?B?NmQxS01aamVNdCtjQTFkODRzZnpEcDdvd3FodGFJNU1jbzFjeEx6dTVJSDJW?=
 =?utf-8?B?bEl2UjNnZ2N3S29tRzBoaEJYcDJRV01sQUVJT0dNU29OWG53cjB5V21JTTZh?=
 =?utf-8?B?TnRFWHdqNUo4VUN4V0dnSXJFZ0dPcDk5UmQ2djllemJLRm1ORmhvTVFvNzNV?=
 =?utf-8?B?SHB4VWFhM3NuY2NSMk9MUTEvWk5sNXNFNWtvRzE2cDhRRmZuNkc0V3dxM2Vi?=
 =?utf-8?B?WDI3YWVDdDhnV2hFRkw0TUp0R1NkRnZQVUYweXpDT1YvNFR5YmRRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8c60a4-5b60-4a80-ca3c-08da13f77353
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 15:51:13.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSj2M2C2WTp9IX4DEtFGlKA+2ql5JMGNSJAmLCABsatWAaA49+qhJpp18TW+uHEQW25Gn8RI/W0WP28nfHtGZw==
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
LCBNYXJjaCAyNiwgMjAyMiAxMDozOSBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZh
bUB4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7DQo+IGhhby53dUBpbnRlbC5jb207IHlpbHVu
Lnh1QGludGVsLmNvbTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51
eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ2l0DQo+IDxnaXRAeGlsaW54
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzVdIGZwZ2E6IFVzZSB0YWIgaW5zdGVh
ZCBvZiBzcGFjZXMgZm9yIGluZGVudGF0aW9uDQo+IA0KPiANCj4gT24gMy8yMi8yMiAxOjIyIEFN
LCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gVHJpdmlhbCBmaXguDQo+IA0KPiBUaGlz
IGlzIG5vdCBkZXNjcmlwdGl2ZS4NCj4gDQo+IEltcHJvdmUgdGhlIGNvbW1pdCBsb2cgdG8gZXhw
bGFpbiB0aGUgaXNzdWUgYW5kIHNvbHV0aW9uLg0KPiANCkkgV2lsbCB1cGRhdGUgdGhlIGNvbW1p
dCBtZXNzYWdlIGluIHYzLg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
