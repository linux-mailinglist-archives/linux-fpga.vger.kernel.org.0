Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24443C0C6
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Oct 2021 05:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhJ0DcR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Oct 2021 23:32:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:54454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237941AbhJ0DcQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Oct 2021 23:32:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="293529077"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="293529077"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 20:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="723006391"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2021 20:29:49 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 20:29:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 26 Oct 2021 20:29:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 26 Oct 2021 20:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTpmyLebyhL3mMgRzu7/Kky96dK4pBlwWp6dXMGU9v2FO3t9I+PzAtVv7VQj7RsO57ZVYau2odkbl6HiFqwApQTmNTGM2VN8/v6AEq9gD6KtNYn7tO9SFg21laKzbSkz/766XuLI64xsWjX3nj7bSe0OyLCwonD6a8BdWM9c8hkQEOhmoqBySVFqRKkH6ESyVtrnfp1Y3praCLfCW0K2P6sy/5OZnRZQSrjJTji4DCQs0s88yDS7tpVW9DYbjgS1B4XDXReyLe0tf4F0Y/Wz/FK9zv7M/SmwEzazb/mm8XMBRj0uS39aja9RP5kQIx4EXL6hJTpX/6m1LGEfAJ+DrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqLWMSg9NEwNdHQXU9vHz0hEMqBTcW6stLupYUMcwv8=;
 b=Du1+5cklqnrsGI9me/MMPkcm0y5d9jHmvQGxY+0spQh9TFEmgWfvxdoh6htjOqvXdivDuLZNhqOn2Aa8hCsZWZix+/7B0O9zrkPfGkgQI6jdNzXEDIOioVhS966RwkD9v++RdM6dwmI1b4/VEH1fkkRzMZTm9LqqPsxQlwj+GOKp8IkTjeB93Wj65Nnf/Bef3N2kZPtxQ+vfWoWYQScMp0T17zv3mvS9/2YSVuUExcMG55P8I0ayoSzf+jpn0LdxViexr3g7bqnpOuEKlL2xyv7JquF+6luPijEGVZWY8ycsgcUtQMQMbW7khEbBq5NwnBUzioytqfgYMNfXxl7a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqLWMSg9NEwNdHQXU9vHz0hEMqBTcW6stLupYUMcwv8=;
 b=yDprV/O8eFQWisGeg6o6lMaHuR6qkaeUF58ZZ/r0Fc1e5y+wYABIygYZ6A0ig860IAwatbBB82dsGB4A99oiGXe1Gzsu8J3xJt7LDrcwObi8MEFMxCTBqBB+p009AOIQO+yknxwbVfU87rpAQNT13WxkRHvtqnPwrV2I0+PQbYc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 03:29:46 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 03:29:46 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Thread-Topic: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Thread-Index: AQHXxc9Yl9XQBIG84UC2/NvO43tzv6vk1TqAgADAfACAAI1uAA==
Date:   Wed, 27 Oct 2021 03:29:46 +0000
Message-ID: <DM6PR11MB38192DC4A39D654F88322D0C85859@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
 <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
 <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
 <20211020011608.GA145760@yilunxu-OptiPlex-7050>
 <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
 <DM6PR11MB38198F9B969569FDDD71A1CC85849@DM6PR11MB3819.namprd11.prod.outlook.com>
 <03ff4983-d8a9-6ad7-a655-a8dcde3da360@intel.com>
In-Reply-To: <03ff4983-d8a9-6ad7-a655-a8dcde3da360@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1665ad61-7b17-43e7-7bdc-08d998fa062c
x-ms-traffictypediagnostic: DM4PR11MB5389:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB5389CB9A2E09136FB05EBFA285859@DM4PR11MB5389.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uf28uByNnc13Ad4nL/bY00EmFGF86cLz9EDZeYZC7l+UpcWnEVacr4u6jUmdysH+Q+xovdGVPyP2k9FXB+wJD5YR4RW9r7ZR2YngxBGxBpXU35mclgEttUsoHwl3upjtZJk7TVfHhvWtFM1BG6mIqbsUwQrPWAiGmTHiqxbA3PslU+gWYSijbsPm8UKATj1QufBV2x9qn16fiveVlUeZUXOm+b2KwaLuZafQbFU58G93JqLjQrwQlxnMfLtWKqrtWqTAuhFcG11/qk9D1QAYtqe4eQpK8qfrMUquyKPKVRxbmJ7gWn0vw4i6j4F22hFH5SGcSf00prkVHD04vbZzdP2PJRIDPtpwygInAWYtsaM8XhmABNCySimirHrzWyw2t87Z0r+JmwIW8HA867II44WmGripeuOnYmqNLjmquonHHgpQ/TBuQf4xMzPqTbJ21qZl9KvMgxUtDhq8IRpwMSj3cDY2v6kbKCNSM9laZq+kDiaS1eYxEivvEQ5n6OKmzPI4AtlFR3x4qheIbTS5NKgogkuuj2RpvAR/w/DOMfHcoNl5p/6iz0tgqvbejyPoVRqHJokcy6wRr4T0/oxgjAaXbgaftbHI7s6+vcV3oXwKh2Cx6CRHwHvd/+cMCN9Pb0K9liM/NqbDZOnwBuovM3x/OdpH+2Gruk3zg2qKLrLi9uQZELk7GnyY7SpYBPqNDYqRSHbE+zRg+K69hwOwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(110136005)(66446008)(54906003)(33656002)(66946007)(66476007)(38070700005)(8676002)(8936002)(508600001)(5660300002)(15650500001)(2906002)(38100700002)(316002)(82960400001)(6636002)(86362001)(55016002)(9686003)(66556008)(107886003)(122000001)(186003)(52536014)(4326008)(76116006)(71200400001)(26005)(64756008)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU9oRFh6V3JEa1FQNzdwSlRtU0twVlRrTkNmNXBVUWZEMUxKY01FV2x2Vnc4?=
 =?utf-8?B?b0h4Y2RVZ0hPSVFaeE9EUkluZGF1SlovTU9uNklaRldlVDVWMkJqRkhxS3d2?=
 =?utf-8?B?SHp4NEtERjA0dmp6LzUxRmZSa0ZqQ2M2WVRKUkJUZWlCbjhRb1Z2UGhVWVRv?=
 =?utf-8?B?L1VBVXd3UUdUNUg1YUJ5WkZibTNuZDM4RzNmVEJUYnlXd3dOb2VrQ0h1YTFW?=
 =?utf-8?B?RDE0amk5ZGRkRi83WkwxZjZxb0RwVmVVa1RPd3dlZG8rMjZpUm1lTlBkanhv?=
 =?utf-8?B?eUluSWxtTzFtbUhoQSswNGRBa1lFN2pRWDk4eUdxOS83TWJjTS8vSVlsYUJN?=
 =?utf-8?B?Y0d3a0NTQ0Q2VXFBdTNOdkZuVDlBc3lWR2tXa252NFpmbk1NRXMxYzZpcnZz?=
 =?utf-8?B?NWdNVmFydnBTVHA5RUlVTjZCU2RjbDNvTXRRdGtZYSsxVnAxdGtCQXJtOWV1?=
 =?utf-8?B?UzlSRVUwcExobnhMc2x6YmtNQktOS3dIZEJjNjNnanZNRmhRSUJPeXp6eXJ6?=
 =?utf-8?B?S1ROVjZHNlQ4eGFzUGJBTFlJWWNJd05abW9adERaWDlvNW5xaEkzR3BHT1Y5?=
 =?utf-8?B?L1FyZWxHZHRZTWhOWWpJdThMamhKUGVUZEQrOWxKWUNaWnIrKzJBLytRcmQr?=
 =?utf-8?B?ZXl6anVIVnVEZnI0dkEvTis5MHJyYjQyK0xseFZSbGYxMnVIL21QZ1ptWGxC?=
 =?utf-8?B?ZmZkYUthQzdZaks2TkNRczByczJ3OFFzdjUzMUZQZFpRUDN5bndMKzRzRmFv?=
 =?utf-8?B?bllhOWp5aEdnSWhSMCtkbXBiWThLem82RVJaZmVmN0tlODNCZGdtYlNyME1Q?=
 =?utf-8?B?STUwMmtEMHBLRXE0L2ZpSHNEVlh6ajFnaTNPaGhzMHQ0NjYrWGQzNjByMDdB?=
 =?utf-8?B?RXdCTUNkSUhDWVlxTFZ5RFI2a0p4Lzc5T1ZjN1dBOWc1TXREUUduMzhyOU1D?=
 =?utf-8?B?djhxQ0Z1UkhTaEZLdzZYR1kyWXhiaWMyWitXTWJTZkMyNFZRV3hHbEJYU1Vz?=
 =?utf-8?B?MHRQMTZEczZEbERmVUxZakNFeHUyM0djRCt4V0xacEtLQWdRenQ5VXdEaFpJ?=
 =?utf-8?B?MEdzMzhZK2d4eUJRMDR3eUdkRVpBekl4UjgwNUNTYjlSdnBNbkFYdkU4Y0ta?=
 =?utf-8?B?UDVQRUdkYjVDRlR0NS9wem83dnQ5QmVsN3laWnRYZ05jUVk1aTV4dkpzNnVj?=
 =?utf-8?B?ckliVDMvb2ZONCt4R2lQWUY2YmVZWDJNZE5zb0Q4WTQyOHVDZTB1dnlqRGUx?=
 =?utf-8?B?WUJlSWVKaHZSL2d0UnBWVjcwK1BXZHBJYTlUNm53Z3VubkNPMTEvdERRU05j?=
 =?utf-8?B?SEE0U0kxK01KaS8yc3BIWGs0djhVenFGTnhVZnkySWFGWGd3cmVEQ1RLRVc1?=
 =?utf-8?B?TVZwUFFXOGxzOXQxZDRtdnBCa0VkOG1GcW1QdC8zZ0xzQUN6c0E3R1lrK1hM?=
 =?utf-8?B?NC9PdHlLQWpWT0JQZDE5WVBrWEhLaGxSR2duUW92ZlpMb1ZqWGpuWk1QTWdJ?=
 =?utf-8?B?dVdSSldUbUppRStSNmRTQzFCb01GLzhEOGl1ZWp5Y0o4YlVMMnRsNnQyM3FI?=
 =?utf-8?B?dldFV0NXQlNxeE9YV0V2RGlJQlR5VHVjQ2ZyS3AwNUtsQTV0L0hINW9ibVlu?=
 =?utf-8?B?U1ZOKzRjMURZSjZxMVNnR1Zmd1o5ZlJaVDZ6ajAzVW1TV0pKblJuSHQ1V0Q5?=
 =?utf-8?B?enZNbFhNbkpwbFo4VUxUWXJDN20vS3lEZ0pPcUZSN0IwZGIrMXVIWUNCYjcv?=
 =?utf-8?B?MlZnOFJCMGZ0WWNZOC9rOUFrMTdCcDNiUUJ6RGFRc3grZGF3Rk5uZ3pZSXp4?=
 =?utf-8?B?MXFTTklBNnhWbThibitBUjNGcnRzWDJUcU8rdVM0RDQ4L0lQc0o2ODBJV0Fs?=
 =?utf-8?B?OXVObWpwekZWT005VVlscFh1SG9CWEhoVUdqMC9nR1RwcEtxeElFeXAzQ3B3?=
 =?utf-8?B?eE5VbUhDQVdSN3E4YlJqK1FmRFFKY2NFUE1lVW1lcTlqTUdNUDB3ODNtZCtq?=
 =?utf-8?B?dm1ENTUyMFpWblAwREVQd3NrZjNDKytrVWIzRGlQZTNuSzB5SkpJMWxJazVY?=
 =?utf-8?B?bUpCblhzZFlpcDhReEowU0NaUUp4TmZWdklvQXNRZUs4cmgxVFgrUXdYZ2Jz?=
 =?utf-8?B?aUlxakIvOW1URC9NQUtXeDlJaFRVK2VSOHhjT3plemFLWnVLZGszWll6SlB1?=
 =?utf-8?Q?KZTJuszoygMi6RmHojKvuNE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1665ad61-7b17-43e7-7bdc-08d998fa062c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 03:29:46.1800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1xPFSyfyNZaDYkmGQ4EteXwn12nByFTse5b8AZ5Rfg67OcDAaA8ClKh128Bydkdo4u1JorOBJj5EKu8I/Ngyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+Pj4gVGhlIEFQSSBzaG91bGQgbm90IG9ubHkgZGVmaW5lIHdoYXQgaXQgd29uJ3QgZG8sIGJ1
dCBhbHNvIGRlZmluZSB3aGF0DQo+ID4+PiBpdCB3aWxsIGRvLiBCdXQgdGhlICJpbWFnZSBsb2Fk
IiBqdXN0IHNwZWNpZmllcyB0aGUgdG9wIGhhbGYgb2YgdGhlDQo+ID4+PiBwcm9jZXNzLiBTbyBJ
IGRvbid0IHRoaW5rIHRoaXMgQVBJIHdvdWxkIGJlIGFjY2VwdGVkLg0KPiA+PiBTbyB3aGF0IGlz
IHRoZSBwYXRoIGZvcndhcmQuIEl0IHNlZW1zIGxpa2UgeW91IGFyZSBzYXlpbmcNCj4gPj4gdGhh
dCB0aGUgc2VsZi1kZXNjcmliaW5nIGZpbGVzIGRvIG5vdCBmaXQgaW4gdGhlIGZwZ2EtbWdyLg0K
PiA+PiBDYW4gd2UgcmVjb25zaWRlciB0aGUgRlBHQSBJbWFnZSBMb2FkIEZyYW1ld29yaywgd2hp
Y2ggZG9lcw0KPiA+PiBub3QgbWFrZSBhbnkgYXNzdW1wdGlvbnMgYWJvdXQgdGhlIGNvbnRlbnRz
IG9mIHRoZSBpbWFnZQ0KPiA+PiBmaWxlcz8NCj4gPiBXaHkgd2UgbmVlZCBzdWNoICJnZW5lcmlj
IGRhdGEgdHJhbnNmZXIiIGludGVyZmFjZSBpbiBGUEdBDQo+ID4gZnJhbWV3b3JrPw0KPiBBcmUg
eW91IHJlZmVycmluZyB0byB0aGUgdXNlIG9mIHNlbGYtZGVzY3JpYmluZyBmaWxlcz8NCj4gb3Ig
dGhlIGdlbmVyaWMgbmF0dXJlIG9mIHRoaXMgY2xhc3MgZHJpdmVyPw0KDQpZZXMsIHdoeSB0aGlz
IGlzIHVuZGVyIEZQR0EgZnJhbWV3b3JrPyBQZXIgeW91ciBkZXNjcmlwdGlvbiB0aGF0DQppdCBj
YW4gYmUgdXNlZCB0byB0cmFuc2ZlciBhbnkgZGF0YSwgZS5nLiBCTUMgaW1hZ2VzLCBzb21lIGRl
dmljZQ0Kc3BlY2lmaWMgZGF0YSAoc2VsZi1kZXNjcmliaW5nIGltYWdlPykuIExldCdzIHRha2Ug
dGhpcyBhcyBleGFtcGxlLA0KaWYgRlBHQSBkZXZpY2UgaXMgcmVwbGFjZWQgd2l0aCBBU0lDIG9u
IE4zMDAwLCBkbyB5b3Ugc3RpbGwgd2FudA0KdG8gdXNlIEZQR0EgaW1hZ2UgbG9hZCBmcmFtZXdv
cmsgdG8gdHJhbnNmZXIgeW91ciBkZXZpY2Ugc3BlY2lmaWMNCmRhdGEsIGUuZy4gQk1DIGltYWdl
cz8gSSByZWFsbHkgaG9wZSB0aGF0IEZQR0EgZnJhbWV3b3JrIGNvZGUgb25seQ0KZm9jdXMgb24g
Y29tbW9uIHVzYWdlIG9mIEZQR0EuIA0KDQo+ID4gd2UgbmVlZCB0byBoYW5kbGUgdGhlIGNvbW1v
biBuZWVkIGZvciBGUEdBDQo+ID4gZGV2aWNlcyBvbmx5LCBub3QgYWxsIGRldmljZXMsIGxpa2Ug
cHJvZ3JhbW1pbmcgRlBHQSBpbWFnZXMuDQo+ID4gU28gZmFyIHdlIGV2ZW4gZG9uJ3Qga25vdywg
d2hhdCdzIHRoZSBoYXJkd2FyZSByZXNwb25zZSBvbg0KPiA+IHRoZXNlIHNlbGYtZGVzY3JpYmlu
ZyBmaWxlcywgaG93IHdlIGRlZmluZSBpdCBhcyBhIGNvbW1vbiBuZWVkDQo+ID4gaW50ZXJmYWNl
IGluIHRoZSBmcmFtZXdvcms/DQo+IFRoZSBjbGFzcyBkcml2ZXIgZG9lcyBub3QgX25lZWRfIHRv
IHJlc2lkZSBpbiB0aGUgRlBHQQ0KPiBmcmFtZXdvcmsuIEkgc2VudCBhbiBpbnF1aXJ5IHRvIHRo
ZSBtYWludGFpbmVyIG9mIHRoZQ0KPiBGaXJtd2FyZSB1cGRhdGUgc3Vic3lzdGVtIChhbmQgY2Mn
ZCB0aGUga2VybmVsIG1haWxpbmcgbGlzdCkNCj4gYW5kIHJlY2VpdmVkIG5vIHJlc3BvbnNlcy4g
SSBwbGFjZWQgaXQgdW5kZXIgdGhlIEZQR0ENCj4gZnJhbWV3b3JrIG9ubHkgYmVjYXVzZSB0aGUg
Zmlyc3QgdXNlciBvZiB0aGUgY2xhc3MgZHJpdmVyDQo+IGlzIGFuIEZQR0EgZHJpdmVyLg0KWW91
IG11c3QgaGF2ZSBlbm91Z2gganVzdGlmaWNhdGlvbnMgd2h5IHRoaXMgbmVlZHMgdG8gYmUgaW5j
bHVkZWQNCmZvciBldmVyeWJvZHkgbm90IGZvciBvdXIgb3duIGNhc2UuDQoNCj4gDQo+ID4gSWYg
eW91IGp1c3Qgd2FudCB0byByZXVzZSB0aGUNCj4gPiBmcGdhLW1nci9mcmFtZXdvcmsgY29kZSBm
b3IgeW91ciBvd24gcHVycG9zZSwgWWVzLCBpdCBzZWVtcw0KPiA+IHNhdmluZyBzb21lIGNvZGUg
Zm9yIHlvdSwgYnV0IGZpbmFsbHkgaXQgbG9zZXMgZmxleGliaWxpdHksIGFzIGl0J3MNCj4gPiBu
b3QgcG9zc2libGUgdG8gZXh0ZW5kIGNvbW1vbiBmcmFtZXdvcmsgZm9yIHlvdXIgb3duDQo+ID4g
cHVycG9zZSBpbiB0aGUgZnV0dXJlLg0KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB5b3Ug
YXJlIHNheWluZyB0aGF0IGl0IGRvZXNuJ3QNCj4gZml0IHdlbGwgaW4gdGhlIEZQR0EgbWFuYWdl
ciwgYmVjYXVzZSBub3QgYWxsIGZpbGUgdHlwZXMNCj4gZml0IHRoZSBkZWZpbml0aW9uIG9mIGEg
ZmlybXdhcmUgdXBkYXRlPyBBbmQgZnV0dXJlIGZpbGUNCj4gdHlwZXMgbWF5IG5vdCBmaXQgaW4g
ZnBnYS1tZ3IgY29udGV4dD8NCg0KTGV0J3Mgc3BsaXQgdGhlIHVzZSBjYXNlcywgSSB0aGluayB0
aGUgdXNlIGNhc2UgdGhhdCB1cGRhdGUgYSBwZXJzaXN0ZW50DQpzdG9yYWdlIGZvciBGUEdBIGlt
YWdlLCBhbmQgbGF0ZXIgdXNlIGhhcmR3YXJlIGxvZ2ljIChGUEdBIGxvYWRlcikNCnRvIGxvYWQg
aXQgaW50byBGUEdBLiBUaGlzIHNvdW5kcyBsaWtlIGEgY29tbW9uIHVzYWdlIGZvciBGUEdBDQpk
ZXZpY2VzLCBzbyBJIHRoaW5rIHRoaXMgaXMgd2h5IFlpbHVuIHByb3Bvc2UgdG8gaGF2ZSB0aGlz
IHBhcnQgdG8gYmUNCmNvdmVyZWQgYnkgZnBnYS1tZ3IuIEJ1dCBmb3Igb3RoZXIgY2FzZXMgaW4g
eW91ciBkZXNjcmlwdGlvbiwgZS5nLg0KQk1DIGltYWdlcywgZGV2aWNlIHNwZWNpZmljIGRhdGEs
IHNlbGYtZGVzY3JpYmluZyBpbWFnZSBhbmQgZXRjLA0KdGhleSBhcmUgb3V0IG9mIHNjb3BlIG9m
IEZQR0EuDQoNCkFjdHVhbGx5IEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCB0
byBpbnRyb2R1Y2UgdGhlDQoic2VsZi1kZXNjcmliaW5nIGltYWdlIiBhcyBhIGNvbW1vbiBkYXRh
IHRyYW5zZmVyIGludGVyZmFjZSwgaWYNCkkgcmVtZW1iZXIgY29ycmVjdGx5LCBmb3IgTjMwMDAs
IGRpZmZlcmVudCBzdWIgZHJpdmVycyB3aWxsIG93bg0KZGlmZmVyZW50IGhhcmR3YXJlIHN1YiBm
dW5jdGlvbiBibG9ja3MsIHdoeSBleHBvc2Ugc3VjaCBhIG5ldw0Kc2hhcmVkIGNvbW11bmljYXRp
b24gY2hhbm5lbD8gSWYgInNlbGYtZGVzY3JpYmluZyBpbWFnZSIgaXMgYQ0KcmVxdWVzdCB0byBv
bmUgb2YgdGhlIHN1YiBmdW5jdGlvbiBibG9jaywgd2h5IG5vdCBqdXN0IGV4cG9zZQ0KbmV3IGlu
dGVyZmFjZSBpbiBzdWNoIGhhcmR3YXJlIGJsb2NrIHBlciBtb2R1bGFyaXphdGlvbj8gSQ0KaGF2
ZSBzb21lIGNvbmNlcm4gdGhhdCB0aGlzIG5ldyByZXF1aXJlbWVudCBtYXkgYnJlYWsNCmN1cnJl
bnQgZHJpdmVyIGFyY2hpdGVjdHVyZSBmb3IgTjMwMDAuDQoNCkhhbw0KDQo+IA0KPiAtIFJ1c3MN
Cj4gPg0KPiA+IFRoYW5rcw0KPiA+IEhhbw0KDQo=
