Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4263AE380
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUGtm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 02:49:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:16680 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhFUGtl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 02:49:41 -0400
IronPort-SDR: gCz0s4078hTdu69S9TvRPgnaw/URHsl1SDxyF/qKXwIA0tmLkmJ4C4Y5tDK/wql4RTEpaZJBqR
 nUy+msfq/elA==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="186480780"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="186480780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 23:47:27 -0700
IronPort-SDR: xJ+qgaNlhJYF/V1C733Qinw7VL0pJRrRzPaiAKlPlu6HlbVydvo6FHBHjq15SPW5SNdRPfqIXR
 3HPNB+IonDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="405525123"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2021 23:47:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 20 Jun 2021 23:47:26 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 20 Jun 2021 23:47:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 20 Jun 2021 23:47:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 20 Jun 2021 23:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRismALh4ucghLTJgIRD/o2e4S/JsPpQXlgOjZbZHM+IiqBQ5J1Ttw+8JFpynEJ4jbhNbPJNjkF5wezH2C3m1rXgtCpSfAEgq8RlNJpKMNctYUtLGTQ2ZaHdbhuYwgJrA+8sC0Ca+sT3tbMfAVcV/iJbJ0V0byXK26EbL5NV956TkztcNZd2cImlw3STfrbupUQacsdLaV2spTqAyvqBMHdBitpVGv85Ky+WsKMmqr4JZBgg81fZ9RAWhRCQQylG2vvrb5GBu0KLbbZZloCt74UCbHoyYWWyIqhglm8/a5fzMD7eEgEjjc49tN0evaD02+9Xew9CgbB72VGmVANLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBla+hZHKCQ1UsmkAUF3eEy1tk/HBElIUIOZPQsiWYs=;
 b=N3h9QJzT9XmtJkU2g6fdYwIaB+uk0xtM4zjIYLfy4JSqplOI9VmY1kgpYusjjKutfJEyUkfVWfgFNuzbfTufIHtCPZfMbGlXU8KtuONFARYQ6JSob/Lke6KL0qYOTfI3QXDVAr2NynhoBZvrzwJdUCUlSIXEaJM3OGwevoCIIg54uWoL+YsZRcRW3UownEZ71c9RNp8K/kGEsrocodZFy4r43p4KHdmno/LwRLIoy9aYJY+kB+49glVRAeEPW83xsFNbILj6QH47yhezUuq21c98mFntshdbNNKN4nMup6pW7FQ5hjAPZ8gmwX8EpRG+Odf2YTbI6dHSmQa/wGELUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBla+hZHKCQ1UsmkAUF3eEy1tk/HBElIUIOZPQsiWYs=;
 b=XT8HgTF2mrewfHYY1Vz3sJZH4aib4V2ZswNd6c1n6rZpEHlzC8e1faeZW0k71exS8i5AumXGQibnyeZmJMYY6qG77Cw6ESWrcGuF0fL14OCXZROO7t3tcjwb3speKdI98ToSAeOqdxl/FZpoOOQQHIy2ZYt39Nm8FvGdocMFvFw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4457.namprd11.prod.outlook.com (2603:10b6:5:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 06:47:24 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 06:47:24 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        "Gong, Richard" <richard.gong@intel.com>
Subject: RE: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Topic: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Index: AQHXYwMPs4aRDCQatEGStgPCWyw0TKsZ7AUAgAAE9YCAACAeAIAD9vhA
Date:   Mon, 21 Jun 2021 06:47:24 +0000
Message-ID: <DM6PR11MB3819F6705045FEF70C050214850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-2-russell.h.weight@intel.com>
 <20210618154554.GA5626@yilunxu-OptiPlex-7050>
 <beca500b-a66c-d6fa-1452-3e7513394d0e@intel.com>
 <69a0135d-ad0b-49ea-f741-54c982a0e5f3@intel.com>
In-Reply-To: <69a0135d-ad0b-49ea-f741-54c982a0e5f3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d394a3-aa5e-487b-0bce-08d934806d6e
x-ms-traffictypediagnostic: DM6PR11MB4457:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB44574BAE4DB18FC6D52E0711850A9@DM6PR11MB4457.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZ0skWbInCNNeGqKqhTHWtyoFVMT0MQh3IqgyOF+i2veocSfJulqruMajnS6Q8k9a/NtW6tiCbs+ouJeHVZXy/RNWd6fQlpYrMY0d8hEqTzdLZU+bOOw5HmgL5Ky5pCXkrUBDCpOv77qdy3lstaySOqDe55HhXWU7+sV9TTIbCLm5/wk9GdEzJlH8a2mRRgvWV6wJlVWxmiSGJP5fCfP2SOVVfdtNzsrZjr5b+btvcHUjRxo7LL6swbw7gbi8noRKitCQ1/Iwd16pnKTm1Hty+QFcc5qI7B7yC9IRK2kxggCrmZPoXw1Skvp06QTGpOso1KdiYzDwRfJKIejZp/dUc6bqQKo68AYwJoFXtCqFUsVkHoONzRZQEiV3IMgiDi4v4eEV+XzYgMbeeq2X+bHyYUT9lo+Uojjf26nZArmG+HnpcrNnMjHuVcHsHPuTW8hrnimHjzFdjY5vNhb+BNAS6894ycEwsKZD4SgVWHXieGKAgJf5Pql0dhfjl9eU+IeWveqkImpuxSHahXd3Y1Gax3mu6CabDVJ0Ik7Dz5Xv6fxeXjof0C5IUlrZ7IR7jHrp4fgQa2W/UOjbeWZ4LzarJv7Uy0KYX/oOdPDlbGfSfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(83380400001)(478600001)(316002)(38100700002)(76116006)(53546011)(54906003)(64756008)(66556008)(2906002)(66946007)(66476007)(4326008)(7696005)(66446008)(9686003)(33656002)(6636002)(86362001)(107886003)(122000001)(71200400001)(6506007)(110136005)(8676002)(8936002)(26005)(52536014)(55016002)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDYxRkRYaDBUSGFUOGoxdFlPK250bWR4bnRhMFJpWnBwbEliTmpQeFhlRktn?=
 =?utf-8?B?ZUF3YVpGNC93aXBVVGV3bVZCOWxXZThOVlkxMm11bkxMTk1UQjZjK1gyRjhz?=
 =?utf-8?B?cWpjUm9aM1Bjd2tJRTJrenRvVFluQ3JMTWlzUVM5M0lNaWYyWnh6aGRpaUxK?=
 =?utf-8?B?OEYwMmRDdzVTaEc2cEY1T1lvRnl1dkdZNExNR2xlaXJVZjcybG1ibTNmaENw?=
 =?utf-8?B?dEZ1a3BSTEt6d09uUUFPM0gycTdzWGdOd0dSNjVMWld0THpZQXFqZFZReTFH?=
 =?utf-8?B?YndWRzJqd1YrL3JnYmZQZk1OaVRYMmdiMzdJSHBDQmEwUHYxQXc1VDB2aFFm?=
 =?utf-8?B?NjZkNEdGSVB6bVRRd09jd056dmt2YkhpSmc4cXhUUTU1TWpCZ2djU2Fud1d3?=
 =?utf-8?B?cytTUW9VZXF0STVEeXVnTmpya3E0aU1kUGR5TDZxTGcwaWlwTHpHbFBacHRy?=
 =?utf-8?B?ZVJzSVhhVEFoNE5IZDh3R3FjbzF2c1dNbUpmejZ0Z2NlVi82OFc5NmZnbGRs?=
 =?utf-8?B?VEtyNEwrY0U5djUzay9tUTN6OGo2akl2b1ZZRmdMZWtZM0lxYklacGF0NjZh?=
 =?utf-8?B?bkNybU8xNkl1dERUUlhHeXEzS0hRNUJIYlJYeW5GZnowOTlUL2hWV1VmZUtN?=
 =?utf-8?B?clBZVk1hVXc1VHBudkF6SzZvWWxsRW1jcWZtWHd1Nll4Z2d4UzhTVTVpNEZC?=
 =?utf-8?B?Q3dFeU0wZUMwSEFBayt6YWI4UmkvUFc2M1orb2twOGI4ZjhWdFhYbGVWbm80?=
 =?utf-8?B?aW12RERkRkVDSkUxNExTWEtkdzlIOCtsM3F6VnF0M04vRWNEY2xHSGlXSzVD?=
 =?utf-8?B?b1ZpOUVtajdtckFTdEJvc012eVFFa3kvclJiYlhRQU9zZS9peDZIZXZoaklu?=
 =?utf-8?B?ekhycUNkYVZhQlIxY3daTjBCSVFuK2N6RW80RDZpY1Zwbjg4R2U2KytBUXl1?=
 =?utf-8?B?VkR2cVcrOHlwcmZjcDFpWHpPMzFkdE5Xc1o4Z1c2T2JuR2hCZXlTaFhyUU0x?=
 =?utf-8?B?THNob3dFZlMxZjNBR1IxSy96b0pNcERxSWk5ZDNhTzBCWllyN1ZsRTZpQVRs?=
 =?utf-8?B?Vi9LbUZpZnJIT1h1N1ltSWlUUE1YYmNsbWFLZmVlbWE1SVhObHdHM0UrSFMv?=
 =?utf-8?B?R2FQN2s4U0lNQllMNUNmd015cWtSNjdXcU10RXdNOHNQZXc0dnBSME5sZGpN?=
 =?utf-8?B?MFNFL2ZhNmZKUkZlUkpIS0hTZFg5bGZwVVlrZUVjTDl3QVRzNU1Va3Vmb0xk?=
 =?utf-8?B?S1Q2SFZ2TFBCWUszdStwRXZpdUpyelRzNTZwWnZ2R242Rys5N05KQTlUeGJD?=
 =?utf-8?B?VHFOTGxkVjAwMHc0MEF3NEI4bkdDb212NzEwMHN4eVkrR0F6VG14dlBDM3R1?=
 =?utf-8?B?bjRZc2VRazFyOVZzZzZlaURrTXRHMXNSUDV2aWtvQ01FTkdGTFJ1dXc1R0dF?=
 =?utf-8?B?RzIveDFrbWY0Q2tvc3BMalZLOEtOTklpUW5IVVVKa1ZDSGhZZkwyMk9ISTBa?=
 =?utf-8?B?dlFFb3dsNlZJdlRNY240aUhLdzlSV3pESnM3K05OMFhGNmJ2MzhIWVdEVjNC?=
 =?utf-8?B?RzFqOUVlaWQvZDVrTERwT05TQmdLK1V5cEZhRGp6RDNpU1d5TU1mSmVQZ1g4?=
 =?utf-8?B?TFljdjVzM3htamlEMlNDK01ERnM0MmhBOWVSbVc3ZUNuUG00aE00WFdaRHlJ?=
 =?utf-8?B?N0ZYUUEyaW9YRWRNcjlUS2dIbC9jRXk0ZzF5RXNOSkNlUW5wSTc2amQxbzAr?=
 =?utf-8?Q?NrMlX5tyt/pBOf9cZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d394a3-aa5e-487b-0bce-08d934806d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 06:47:24.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUtRWv+sCtuZSVVMh8o0UwVUEvYlhyPoW3zu288TAE8M+iC3tGbgB/ZWy5Ql2uKEQYe3df5eZqbLkQolAxtJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4457
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA2LzE4LzIxIDk6MDMgQU0sIFJ1c3MgV2VpZ2h0IHdyb3RlOg0KPiA+DQo+ID4gT24gNi8x
OC8yMSA4OjQ1IEFNLCBYdSBZaWx1biB3cm90ZToNCj4gPj4gT24gV2VkLCBKdW4gMTYsIDIwMjEg
YXQgMDM6NTc6MzhQTSAtMDcwMCwgUnVzcyBXZWlnaHQgd3JvdGU6DQo+ID4+PiBUaGUgRlBHQSBt
YW5hZ2VyIGNsYXNzIGRyaXZlciBkYXRhIHN0cnVjdHVyZSBpcyBiZWluZyB0cmVhdGVkIGFzIGEN
Cj4gPj4+IG1hbmFnZWQgcmVzb3VyY2UgaW5zdGVhZCBvZiB1c2luZyBzdGFuZGFyZCBkZXZfcmVs
ZWFzZSBjYWxsLWJhY2sNCj4gPj4+IHRvIHJlbGVhc2UgdGhlIGNsYXNzIGRhdGEgc3RydWN0dXJl
LiBUaGlzIGNoYW5nZSByZW1vdmVzIHRoZQ0KPiA+Pj4gbWFuYWdlZCByZXNvdXJjZSBjb2RlIGZv
ciB0aGUgZnJlZWluZyBvZiB0aGUgY2xhc3MgZGF0YSBzdHJ1Y3R1cmUNCj4gPj4+IGFuZCBjb21i
aW5lcyB0aGUgY3JlYXRlKCkgYW5kIHJlZ2lzdGVyKCkgZnVuY3Rpb25zIGludG8gYSBzaW5nbGUN
Cj4gPj4+IHJlZ2lzdGVyKCkgZnVuY3Rpb24uDQo+ID4+Pg0KPiA+Pj4gVGhlIGRldm1fZnBnYV9t
Z3JfcmVnaXN0ZXIoKSBmdW5jdGlvbiBpcyByZXRhaW5lZC4NCj4gPj4+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4+PiAt
LS0NCj4gPj4+IHY1Og0KPiA+Pj4gICAtIFJlYmFzZWQgb24gdG9wIG9mIHJlY2VudGx5IGFjY2Vw
dGVkIHBhdGNoZXMuDQo+ID4+PiAgIC0gUmVtb3ZlZCBjb21wYXRfaWQgZnJvbSB0aGUgZnBnYV9t
Z3JfcmVnaXN0ZXIoKSBwYXJhbWV0ZXIgbGlzdA0KPiA+Pj4gICAgIGFuZCBhZGRlZCBpdCB0byB0
aGUgZnBnYV9tYW5hZ2VyX29wcyBzdHJ1Y3R1cmUuIFRoaXMgYWxzbyByZXF1aXJlZA0KPiA+PiBN
eSByZWFzb24gZm9yIHRoaXMgY2hhbmdlIGlzLCB3ZSBjb3VsZCBhdm9pZCBmdXJ0aGVyIGNoYW5n
ZSBvZiB0aGUNCj4gPj4gZnBnYV9tZ3JfcmVnaXN0ZXIoKSBBUEkgaWYgd2UgYWRkIG5ldyBpbnB1
dCBwYXJhbWV0ZXJzIGxhdGVyIG9uLg0KPiA+IFdpdGggdGhpcyBwYXRjaHNldCwgY2hhbmdlcyBh
cmUgb25seSByZXF1aXJlZCBmb3IgdGhlIGNhbGxlcnMNCj4gPiB0aGF0IHVzZSB0aGUgbmV3IHBh
cmFtZXRlcnMuDQo+ID4NCj4gPj4+ICAgICBkeW5hbWljYWxseSBhbGxvY2F0aW5nIHRoZSBkZmwt
Zm1lLW9wcyBzdHJ1Y3R1cmUgaW4gb3JkZXIgdG8gYWRkDQo+ID4+PiAgICAgdGhlIGFwcHJvcHJp
YXRlIGNvbXBhdF9pZC4NCj4gPj4gQnV0IGVuZm9yY2luZyB0aGUgZHluYW1pY2FsIGFsbG9jYXRp
b24gb2YgdGhlIHBhcmFtZXRlcnMgaXMgbm90IHByZWZlcmVkDQo+ID4+IHRvIG1lLiBIb3cgYWJv
dXQgYSBkZWRpY2F0ZWQgc3RydWN0dXJlIHRoYXQgd3JhcHMgYWxsIHRoZSBuZWVkZWQNCj4gPj4g
cGFyYW1ldGVyczoNCj4gPj4NCj4gPj4gc3RydWN0IGZwZ2FfbWdyX2luZm8gew0KPiA+PiAJY29u
c3QgY2hhciAqbmFtZTsNCj4gPj4gCWNvbnN0IHN0cnVjdCBmcGdhX21hbmFnZXJfb3BzICptb3Bz
Ow0KPiA+PiAJY29uc3Qgc3RydWN0IGZwZ2FfY29tcGF0X2lkICpjb21wYXRfaWQ7DQo+ID4+IAlj
b25zdCB2b2lkICpwcml2Ow0KPiA+PiB9Ow0KPiA+Pg0KPiA+PiBUaGVuIFdlIGNhbiBzaW1wbHkg
ZGVmaW5lIGEgbG9jYWwgdmFyaWFibGUgb2YgdGhpcyBzdHJ1Y3QgZm9yDQo+ID4+IGZwZ2FfbWdy
X3JlZ2lzdGVyKCkuDQo+ID4+DQo+ID4+IG1vcmUgZGV0YWlscyBpbmxpbmUuDQo+ID4gSSBhZ3Jl
ZSB0aGUgYXQgdGhlIGR5bmFtaWMgYWxsb2NhdGlvbiBpcyBub3QgcHJlZmVycmVkLCBidXQgaXQg
aXMgb25seQ0KPiA+IHJlcXVpcmVkIGlmIGNvbXBhdF9pZCBpcyB1c2VkLiBJbiBhbGwgb3RoZXIg
Y2FzZXMsIHRoZSBzdGF0aWMgc3RydWN0dXJlDQo+ID4gY2FuIGNvbnRpbnVlIHRvIGJlIHVzZWQu
IEluIG90aGVyd29yZHMsIG9ubHkgb25lIGNhbGxlciBpcyBhZmZlY3RlZC4NCj4gPj4NCj4gPj4+
IHY0Og0KPiA+Pj4gICAtIEFkZGVkIHRoZSBjb21wYXRfaWQgcGFyYW1ldGVyIHRvIGZwZ2FfbWdy
X3JlZ2lzdGVyKCkgYW5kDQo+ID4+PiAgICAgZGV2bV9mcGdhX21ncl9yZWdpc3RlcigpIHRvIGVu
c3VyZSB0aGF0IHRoZSBjb21wYXRfaWQgaXMgc2V0IGJlZm9yZQ0KPiA+Pj4gICAgIHRoZSBkZXZp
Y2VfcmVnaXN0ZXIoKSBjYWxsLg0KPiA+Pj4gdjM6DQo+ID4+PiAgIC0gQ2xlYW5lZCB1cCBjb21t
ZW50IGhlYWRlciBmb3IgZnBnYV9tZ3JfcmVnaXN0ZXIoKQ0KPiA+Pj4gICAtIEZpeCBlcnJvciBy
ZXR1cm4gb24gaWRhX3NpbXBsZV9nZXQoKSBmYWlsdXJlDQo+ID4+PiB2MjoNCj4gPj4+ICAgLSBS
ZXN0b3JlZCBkZXZtX2ZwZ2FfbWdyX3JlZ2lzdGVyKCkgZnVuY3Rpb25hbGl0eSwgYWRhcHRlZCBm
b3IgdGhlDQo+IGNvbWJpbmVkDQo+ID4+PiAgICAgY3JlYXRlL3JlZ2lzdGVyIGZ1bmN0aW9uYWxp
dHkuDQo+ID4+PiAgIC0gQWxsIHByZXZpb3VzIGNhbGxlcnMgb2YgZGV2bV9mcGdhX21ncl9yZWdp
c3RlcigpIHdpbGwgY29udGludWUgdG8gY2FsbA0KPiA+Pj4gICAgIGRldm1fZnBnYV9tZ3JfcmVn
aXN0ZXIoKS4NCj4gPj4+ICAgLSByZXBsYWNlZCB1bm5lY2Vzc2FyeSB0ZXJuYXJ5IG9wZXJhdG9y
cyBpbiByZXR1cm4gc3RhdGVtZW50cyB3aXRoDQo+IHN0YW5kYXJkDQo+ID4+PiAgICAgaWYgY29u
ZGl0aW9ucy4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvZnBnYS9hbHRlcmEtY3ZwLmMgICAg
ICAgIHwgIDEyICstLQ0KPiA+Pj4gIGRyaXZlcnMvZnBnYS9hbHRlcmEtcHItaXAtY29yZS5jIHwg
ICA4ICstDQo+ID4+PiAgZHJpdmVycy9mcGdhL2FsdGVyYS1wcy1zcGkuYyAgICAgfCAgMTAgKy0N
Cj4gPj4+ICBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1tZ3IuYyAgICAgICB8ICA1MiArKysrKystLS0t
DQo+ID4+PiAgZHJpdmVycy9mcGdhL2RmbC1mbWUtcmVnaW9uLmMgICAgfCAgIDIgKy0NCj4gPj4+
ICBkcml2ZXJzL2ZwZ2EvZnBnYS1tZ3IuYyAgICAgICAgICB8IDE2MyArKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4+PiAgZHJpdmVycy9mcGdhL2ljZTQwLXNwaS5jICAgICAgICAg
fCAgMTAgKy0NCj4gPj4+ICBkcml2ZXJzL2ZwZ2EvbWFjaHhvMi1zcGkuYyAgICAgICB8ICAxMCAr
LQ0KPiA+Pj4gIGRyaXZlcnMvZnBnYS9zb2NmcGdhLWExMC5jICAgICAgIHwgIDE2ICsrLQ0KPiA+
Pj4gIGRyaXZlcnMvZnBnYS9zb2NmcGdhLmMgICAgICAgICAgIHwgIDEwICstDQo+ID4+PiAgZHJp
dmVycy9mcGdhL3N0cmF0aXgxMC1zb2MuYyAgICAgfCAgMTYgKy0tDQo+ID4+PiAgZHJpdmVycy9m
cGdhL3RzNzN4eC1mcGdhLmMgICAgICAgfCAgMTAgKy0NCj4gPj4+ICBkcml2ZXJzL2ZwZ2EveGls
aW54LXNwaS5jICAgICAgICB8ICAxMiArLS0NCj4gPj4+ICBkcml2ZXJzL2ZwZ2EvenlucS1mcGdh
LmMgICAgICAgICB8ICAxNiArKy0NCj4gPj4+ICBkcml2ZXJzL2ZwZ2EvenlucW1wLWZwZ2EuYyAg
ICAgICB8ICAxMCArLQ0KPiA+Pj4gIGluY2x1ZGUvbGludXgvZnBnYS9mcGdhLW1nci5oICAgIHwg
IDQzICsrKystLS0tDQo+ID4+PiAgMTYgZmlsZXMgY2hhbmdlZCwgMTUzIGluc2VydGlvbnMoKyks
IDI0NyBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdh
L2FsdGVyYS1jdnAuYyBiL2RyaXZlcnMvZnBnYS9hbHRlcmEtY3ZwLmMNCj4gPj4+IGluZGV4IGNj
ZjQ1NDZlZmYyOS4uNGZmYjlkYTUzN2Q4IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9mcGdh
L2FsdGVyYS1jdnAuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9mcGdhL2FsdGVyYS1jdnAuYw0KPiA+
Pj4gQEAgLTY1MiwxOSArNjUyLDE1IEBAIHN0YXRpYyBpbnQgYWx0ZXJhX2N2cF9wcm9iZShzdHJ1
Y3QgcGNpX2RldiAqcGRldiwNCj4gPj4+ICAJc25wcmludGYoY29uZi0+bWdyX25hbWUsIHNpemVv
Zihjb25mLT5tZ3JfbmFtZSksICIlcyBAJXMiLA0KPiA+Pj4gIAkJIEFMVEVSQV9DVlBfTUdSX05B
TUUsIHBjaV9uYW1lKHBkZXYpKTsNCj4gPj4+DQo+ID4+PiAtCW1nciA9IGRldm1fZnBnYV9tZ3Jf
Y3JlYXRlKCZwZGV2LT5kZXYsIGNvbmYtPm1ncl9uYW1lLA0KPiA+Pj4gLQkJCQkgICAmYWx0ZXJh
X2N2cF9vcHMsIGNvbmYpOw0KPiA+Pj4gLQlpZiAoIW1ncikgew0KPiA+Pj4gLQkJcmV0ID0gLUVO
T01FTTsNCj4gPj4+ICsJbWdyID0gZnBnYV9tZ3JfcmVnaXN0ZXIoJnBkZXYtPmRldiwgY29uZi0+
bWdyX25hbWUsDQo+ID4+PiArCQkJCSZhbHRlcmFfY3ZwX29wcywgY29uZik7DQo+ID4+PiArCWlm
IChJU19FUlIobWdyKSkgew0KPiA+Pj4gKwkJcmV0ID0gUFRSX0VSUihtZ3IpOw0KPiA+Pj4gIAkJ
Z290byBlcnJfdW5tYXA7DQo+ID4+PiAgCX0NCj4gPj4+DQo+ID4+PiAgCXBjaV9zZXRfZHJ2ZGF0
YShwZGV2LCBtZ3IpOw0KPiA+Pj4NCj4gPj4+IC0JcmV0ID0gZnBnYV9tZ3JfcmVnaXN0ZXIobWdy
KTsNCj4gPj4+IC0JaWYgKHJldCkNCj4gPj4+IC0JCWdvdG8gZXJyX3VubWFwOw0KPiA+Pj4gLQ0K
PiA+Pj4gIAlyZXR1cm4gMDsNCj4gPj4+DQo+ID4+PiAgZXJyX3VubWFwOg0KPiA+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZnBnYS9hbHRlcmEtcHItaXAtY29yZS5jIGIvZHJpdmVycy9mcGdhL2Fs
dGVyYS1wci1pcC0NCj4gY29yZS5jDQo+ID4+PiBpbmRleCBkZmRmMjFlZDM0YzQuLjE3YmFiZjk3
NDg1MiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9hbHRlcmEtcHItaXAtY29yZS5j
DQo+ID4+PiArKysgYi9kcml2ZXJzL2ZwZ2EvYWx0ZXJhLXByLWlwLWNvcmUuYw0KPiA+Pj4gQEAg
LTE5MSwxMSArMTkxLDExIEBAIGludCBhbHRfcHJfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2
LCB2b2lkDQo+IF9faW9tZW0gKnJlZ19iYXNlKQ0KPiA+Pj4gIAkJKHZhbCAmIEFMVF9QUl9DU1Jf
U1RBVFVTX01TSykgPj4gQUxUX1BSX0NTUl9TVEFUVVNfU0ZULA0KPiA+Pj4gIAkJKGludCkodmFs
ICYgQUxUX1BSX0NTUl9QUl9TVEFSVCkpOw0KPiA+Pj4NCj4gPj4+IC0JbWdyID0gZGV2bV9mcGdh
X21ncl9jcmVhdGUoZGV2LCBkZXZfbmFtZShkZXYpLCAmYWx0X3ByX29wcywgcHJpdik7DQo+ID4+
PiAtCWlmICghbWdyKQ0KPiA+Pj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4+PiArCW1nciA9IGRl
dm1fZnBnYV9tZ3JfcmVnaXN0ZXIoZGV2LCBkZXZfbmFtZShkZXYpLCAmYWx0X3ByX29wcywgcHJp
dik7DQo+ID4+PiArCWlmIChJU19FUlIobWdyKSkNCj4gPj4+ICsJCXJldHVybiBQVFJfRVJSKG1n
cik7DQo+ID4+Pg0KPiA+Pj4gLQlyZXR1cm4gZGV2bV9mcGdhX21ncl9yZWdpc3RlcihkZXYsIG1n
cik7DQo+ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gIH0NCj4gPj4+ICBFWFBPUlRfU1lNQk9MX0dQ
TChhbHRfcHJfcmVnaXN0ZXIpOw0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zw
Z2EvYWx0ZXJhLXBzLXNwaS5jIGIvZHJpdmVycy9mcGdhL2FsdGVyYS1wcy1zcGkuYw0KPiA+Pj4g
aW5kZXggMjNiZmQ0ZDFhZDBmLi5kM2Y3N2IwMzEyYjIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2
ZXJzL2ZwZ2EvYWx0ZXJhLXBzLXNwaS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2ZwZ2EvYWx0ZXJh
LXBzLXNwaS5jDQo+ID4+PiBAQCAtMzAyLDEyICszMDIsMTIgQEAgc3RhdGljIGludCBhbHRlcmFf
cHNfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPj4+ICAJc25wcmludGYoY29uZi0+
bWdyX25hbWUsIHNpemVvZihjb25mLT5tZ3JfbmFtZSksICIlcyAlcyIsDQo+ID4+PiAgCQkgZGV2
X2RyaXZlcl9zdHJpbmcoJnNwaS0+ZGV2KSwgZGV2X25hbWUoJnNwaS0+ZGV2KSk7DQo+ID4+Pg0K
PiA+Pj4gLQltZ3IgPSBkZXZtX2ZwZ2FfbWdyX2NyZWF0ZSgmc3BpLT5kZXYsIGNvbmYtPm1ncl9u
YW1lLA0KPiA+Pj4gLQkJCQkgICAmYWx0ZXJhX3BzX29wcywgY29uZik7DQo+ID4+PiAtCWlmICgh
bWdyKQ0KPiA+Pj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4+PiArCW1nciA9IGRldm1fZnBnYV9t
Z3JfcmVnaXN0ZXIoJnNwaS0+ZGV2LCBjb25mLT5tZ3JfbmFtZSwNCj4gPj4+ICsJCQkJICAgICAm
YWx0ZXJhX3BzX29wcywgY29uZik7DQo+ID4+PiArCWlmIChJU19FUlIobWdyKSkNCj4gPj4+ICsJ
CXJldHVybiBQVFJfRVJSKG1ncik7DQo+ID4+Pg0KPiA+Pj4gLQlyZXR1cm4gZGV2bV9mcGdhX21n
cl9yZWdpc3Rlcigmc3BpLT5kZXYsIG1ncik7DQo+ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gIH0N
Cj4gPj4+DQo+ID4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFsdGVyYV9w
c19zcGlfaWRzW10gPSB7DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1mbWUt
bWdyLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1tZ3IuYw0KPiA+Pj4gaW5kZXggZDU4NjFkMTNi
MzA2Li4xYjkzYmMyOTJkYmUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLWZt
ZS1tZ3IuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1mbWUtbWdyLmMNCj4gPj4+IEBA
IC0yNjQsMTQgKzI2NCw2IEBAIHN0YXRpYyB1NjQgZm1lX21ncl9zdGF0dXMoc3RydWN0IGZwZ2Ff
bWFuYWdlcg0KPiAqbWdyKQ0KPiA+Pj4gIAlyZXR1cm4gcHJfZXJyb3JfdG9fbWdyX3N0YXR1cyhw
cml2LT5wcl9lcnJvcik7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+IC1zdGF0aWMgY29uc3Qgc3Ry
dWN0IGZwZ2FfbWFuYWdlcl9vcHMgZm1lX21ncl9vcHMgPSB7DQo+ID4+PiAtCS53cml0ZV9pbml0
ID0gZm1lX21ncl93cml0ZV9pbml0LA0KPiA+Pj4gLQkud3JpdGUgPSBmbWVfbWdyX3dyaXRlLA0K
PiA+Pj4gLQkud3JpdGVfY29tcGxldGUgPSBmbWVfbWdyX3dyaXRlX2NvbXBsZXRlLA0KPiA+Pj4g
LQkuc3RhdGUgPSBmbWVfbWdyX3N0YXRlLA0KPiA+Pj4gLQkuc3RhdHVzID0gZm1lX21ncl9zdGF0
dXMsDQo+ID4+PiAtfTsNCj4gPj4+IC0NCj4gPj4+ICBzdGF0aWMgdm9pZCBmbWVfbWdyX2dldF9j
b21wYXRfaWQodm9pZCBfX2lvbWVtICpmbWVfcHIsDQo+ID4+PiAgCQkJCSAgc3RydWN0IGZwZ2Ff
Y29tcGF0X2lkICppZCkNCj4gPj4+ICB7DQo+ID4+PiBAQCAtMjc5LDEwICsyNzEsMzQgQEAgc3Rh
dGljIHZvaWQgZm1lX21ncl9nZXRfY29tcGF0X2lkKHZvaWQNCj4gX19pb21lbSAqZm1lX3ByLA0K
PiA+Pj4gIAlpZC0+aWRfaCA9IHJlYWRxKGZtZV9wciArIEZNRV9QUl9JTlRGQ19JRF9IKTsNCj4g
Pj4+ICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBzdHJ1Y3QgZnBnYV9tYW5hZ2VyX29wcyAqZm1l
X21ncl9nZXRfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4+ICsJCQkJCQlzdHJ1Y3QgZm1l
X21ncl9wcml2ICpwcml2KQ0KPiA+Pj4gK3sNCj4gPj4+ICsJc3RydWN0IGZwZ2FfbWFuYWdlcl9v
cHMgKm9wczsNCj4gPj4+ICsNCj4gPj4+ICsJb3BzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9m
KCpvcHMpLCBHRlBfS0VSTkVMKTsNCj4gPj4+ICsJaWYgKCFvcHMpDQo+ID4+PiArCQlyZXR1cm4g
TlVMTDsNCj4gPj4+ICsNCj4gPj4+ICsJb3BzLT5jb21wYXRfaWQgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzaXplb2Yoc3RydWN0IGZwZ2FfY29tcGF0X2lkKSwNCj4gPj4+ICsJCQkJICAgICAgR0ZQX0tF
Uk5FTCk7DQo+ID4+PiArCWlmICghb3BzLT5jb21wYXRfaWQpDQo+ID4+PiArCQlyZXR1cm4gTlVM
TDsNCj4gPj4+ICsNCj4gPj4+ICsJZm1lX21ncl9nZXRfY29tcGF0X2lkKHByaXYtPmlvYWRkciwg
b3BzLT5jb21wYXRfaWQpOw0KPiA+Pj4gKwlvcHMtPndyaXRlX2luaXQgPSBmbWVfbWdyX3dyaXRl
X2luaXQ7DQo+ID4+PiArCW9wcy0+d3JpdGUgPSBmbWVfbWdyX3dyaXRlOw0KPiA+Pj4gKwlvcHMt
PndyaXRlX2NvbXBsZXRlID0gZm1lX21ncl93cml0ZV9jb21wbGV0ZTsNCj4gPj4+ICsJb3BzLT5z
dGF0ZSA9IGZtZV9tZ3Jfc3RhdGU7DQo+ID4+PiArCW9wcy0+c3RhdHVzID0gZm1lX21ncl9zdGF0
dXM7DQo+ID4+PiArDQo+ID4+PiArCXJldHVybiBvcHM7DQo+ID4+PiArfQ0KPiANCj4gV2hhdCBk
byBvdGhlcidzIHRoaW5rPyBJcyBpdCBiZXR0ZXIgdG8gZHluYW1pY2FsbHkgYWxsb2NhdGUgdGhl
IG9wcyBzdHJ1Y3R1cmUNCj4gZm9yIHVzZXJzIG9mIGNvbXBhdF9pZCAoanVzdCBvbmUgdXNlciBh
dCB0aGlzIHRpbWUpPyBPciBiZXR0ZXIgdG8gY3JlYXRlIGFuDQo+IGluZm8gc3RydWN0dXJlIG9u
IHRoZSBzdGFjayBmb3IgYWxsIGNhbGxlcnM/IFNlZSBhYm92ZSBmb3IgYW4gZXhhbXBsZSBvZiBh
DQo+IGR5bmFtaWNhbGx5IGFsbG9jYXRlZCB0aGUgb3BzIHN0cnVjdHVyZS4NCg0KVG8gbWUsIGl0
IHNlZW1zIG5vdCBnb29kIHRvIHB1dCBjb21wYXRfaWQgaW50byBvcHMsIG9wcyBzaG91bGQgYmUg
cHJvdmlkZWQgYnkNCmRyaXZlciwgYnV0IGNvbXBhdF9pZCBpcyBzb21ldGhpbmcgZnJvbSBoYXJk
d2FyZSBmb3IgY29tcGF0aWJsZSBjaGVja2luZywgc28NCnRoaXMgaXMgd2h5IGNvbXBhdF9pZCBp
cyBpbiBmcGdhLW1nciBhbmQgZnBnYS1yZWdpb24uIGNvbXBhdF9pZCBjYW4gYmUgZnBnYSBtZ3IN
CmxldmVsIG9yIHBlciBlYWNoIGZwZ2EgcmVnaW9uLCB0aGlzIGlzIHdoeSB3ZSBoYXZlIGJvdGgg
dGhlcmUuDQoNCkN1cnJlbnRseSB3ZSBoYXZlIGFsbG9jYXRpb24gY29kZSBpbiBzcGVjaWZpYyBm
cGdhIG1nciBkcml2ZXIgKGUuZy4gZGZsKSwgYXMgbW9zdA0KZHJpdmVycyBhcmUgbm90IHVzaW5n
IHRoZW0gYXQgYWxsLiBUbyBtZSwga2VlcCB0aGUgYWxsb2NhdGlvbiBjb2RlIGhlcmUgb3IgbW92
ZQ0KaXQgaW50byBzb21lIGNvbW1vbiBjb2RlLCBib3RoIGFyZSBmaW5lIHRvIG1lLCBidXQgYWRk
IHRoaXMgdG8gb3BzIHNlZW1zIGNvbmZ1c2luZy4NCg0KVGhhbmtzDQpIYW8NCg0KPiANCj4gVG8g
bWUsIHVzaW5nIHRoZSBvcHMgc3RydWN0dXJlIHNlZW1zIG1vcmUgc3RhbmRhcmQsIGFuZCB0aGUg
ZHluYW1pYyBhbGxvY2F0aW9uLA0KPiB3aGlsZSBub3Qgb3B0aW1hbCwgZG9lcyBub3QgcmVxdWly
ZSBtdWNoIG1vcmUgc3BhY2Ugb3IgY29tcGxleGl0eSB0aGFuIHRoZQ0KPiBzdGF0aWMNCj4gYWxs
b2NhdGlvbi4gQXQgdGhpcyB0aW1lIGl0IG9ubHkgYWZmZWN0cyBvbmUgY2FsbGVyLg0KPiANCj4g
QWRkaW5nIHRoZSBpbmZvIHN0cnVjdHVyZSBhcyBhIHBhcmFtZXRlciB0byB0aGUgcmVnaXN0ZXIo
KSBmdW5jdGlvbnMgYWRkcyBhDQo+IGxpdHRsZSBtb3JlIGNvbXBsZXhpdHkgdG8gYWxsIGNhbGxl
cnMsIHdoZXRoZXIgb3Igbm90IHRoZXkgdXNlIHRoZSBkeW5hbWljDQo+IGVsZW1lbnRzIG9mIHRo
ZSBzdHJ1Y3R1cmUuDQo+IA0KPiAtIFJ1c3MNCj4gDQoNCg==
