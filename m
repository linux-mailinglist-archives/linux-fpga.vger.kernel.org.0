Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF34BB4F7
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 10:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiBRJD6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 04:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiBRJDo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 04:03:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E327769280;
        Fri, 18 Feb 2022 01:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645175006; x=1676711006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zZLovUlxA2lWHDbEKPvIC1H9jEzWTqk7xpBIMltC0pA=;
  b=GgnRSriJdBmAqcW6BUWhHpvWWrkDgTwcqFcEpjtwAnFTGMepAtvFIBvq
   ZqT9gbVHp0IjARWr2V+iavpfOnY1Px3zocmGYNDYtxlT7IDErQWYvpVAw
   sGOXU+w6lxaP96bep9MKJxJ7HXKPSrn6HzFrdWC2gi0krD7iJ31SY4PMd
   TF7uOTvUoWwtakmlTQNI8zdjs4iylHtgqpPkqoF0y4/K12tnzZTIpIBG0
   LgWmsclo0urx5e+hXUBamRje2g2NFosmYvB4VS/LUuSCUt5/AfCkYZWmi
   7hiNr81HSUoDumYpMrybEMYIcaoNd/YpE6yi0v7rD5SMfDEhPWLUj5ZPf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231071636"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="231071636"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 01:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="572233341"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 01:03:26 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 01:03:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 01:03:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 01:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5yVQ1ACBT9oRCgl5+kfF+9YBJ6S933f910EChIi1KcnlDCsxTBBRwg6HhAysY5ufQ54VElkbLPwsITD+TJmZGjm5VywNw0jPlJ74eqfwQR47RPbKsfRsBLkbn9xiW2gRFdi+HyQEsqDUpnKMObgzvgby10JhUsC29zu+cySifGdoV0mSYzkJYK+YcAExL4SnbsmAEqYyaOp1P7Xq+0qfFXcUXs4UeOEOrrBSpsS5B6n8hQlOWien+qAzKnMG/ea/J1mThgRRACdFkOQzlHcP1szBsXcBqqeAkcjopSVrqGut++Gy87CLAvdq58x30si5pS1ynnl5qu8JvH37af55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZLovUlxA2lWHDbEKPvIC1H9jEzWTqk7xpBIMltC0pA=;
 b=fsJdbjyyqLElygyiXC+s89Ls7FIeFBn0Pg/iZA8Ao3iLhrXUjcv6uFWXmke4WBHkFzqdiE3VGm5w3zV7hz9A9cVzNribbjoDKVRoWypqq7CRybpEZbpLy5mgcjVL9Bn4+oYZIgbixJ73qnbS82hFqcFQMaNZazTVaCzOcr1ikeGgVWfdQ7bG+QOsOZXSqqrbh621ZlyqWZkJyIINlGt5gKDYezXrLWN4mf62MAg+kHKzpRE3nMQYT0kmJ/p7fvXQSAGAKj+ks9tjLvBGAjRWT2meVC+V2F8kouZ9KJxljg7W4SQ8wRWVQ7+OZPzntqOCK4BuH64RHAxH3eNi2ITIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN6PR11MB1778.namprd11.prod.outlook.com (2603:10b6:404:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 09:03:22 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 09:03:22 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Topic: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Index: AQHYIZY0OPmbG/7a10yxBqZVPNMIu6yUy5EAgAQ8MZA=
Date:   Fri, 18 Feb 2022 09:03:22 +0000
Message-ID: <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
 <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
In-Reply-To: <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798d0835-8d77-4a72-2156-08d9f2bd83c7
x-ms-traffictypediagnostic: BN6PR11MB1778:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB177888C85265B2475DF58506E3379@BN6PR11MB1778.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpzeKb5atHUr15kkkf9LpjB+x60ue+wRf2wvpozUuoSASmtx91gL3qMv1J8bo19y4ebrYXa/oYIsNbx7pUwICg2mNtrRCZxB2i2wEiArdRO9sxAtpBwlcHiNu67cgwDas7zQF6BveMUWGkLs67MkTL9yBA6fxHhH8vS75fLJS8Wgg3A0/Elbp3nXtllRRC8uF8/1B9ip0Aw2+k+vhf2INu28QbUC9Y18/eo/+RbsHE3mB9jvLJJpZWm+JXVGzQEGqY+61Bpr98Fk36plva1mRcnXrWjw84Q7d0/3R+C+AHvkyNzUvbKVT9RO0UYQDc4PTH7QsdrXj6k8Tk3/73sNslM+LoF8aeWE9hiWvrG8CTkmn7NJROjc3kR9ZMWyC6xeUHWdcEyH0MF6xN6tsebiBaN1MCrZrSlgSiLDA92TMDiRwPQxkoSKZ7DjxvgS08iOJOvv1m+6UtBo3Ap53ZWiJdEP23C/wqwZB4rt1hOGaMNjHU1dqHrXk9Nd8HhS3pTKpgQy4EyQLE5SsLWuzKmIxkxGUjaF17CyR7xe1wgQTgfMPvOEG5SGxIth9ylJ+w4mV58QB/6u5E9iu0mKSUIcESFHty1KZeMGYbbzkI26KY54DuwTqtNJuwbP3IwPfFlrvlYzQ6XnZORF5/PADnQNMC30Ing06P6B+WJEfrKPxOtH2K+IsTjOcPJsv3gr5Rre20m9FXc6im9Vg1rcOH/d80vHIB1dytgMnXJ4olxfups=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(52536014)(186003)(8936002)(5660300002)(9686003)(122000001)(82960400001)(38100700002)(6506007)(7696005)(53546011)(54906003)(110136005)(316002)(2906002)(4326008)(86362001)(71200400001)(8676002)(66556008)(33656002)(66446008)(66476007)(64756008)(38070700005)(83380400001)(55016003)(66946007)(76116006)(508600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFZT0dGME41YUduaENvUmtTODZPdSt6SVBDUTk3V0pHbytKRnIxVU9PZDdx?=
 =?utf-8?B?SzVYZEI4S3gvYnhBZDVaWDB5VkN4Ym5KaC9BRnlieU5PVGtTRUFYRWU1V2Za?=
 =?utf-8?B?ZlpETHpjQVBpVFIzNENtVEloQkFMNkRTTG83VUUvR1ZnQkgrb2Zxa3BCVmJa?=
 =?utf-8?B?UWhnOE1tcWRtOTJpQm9YRllLSGZleXBsOVZVcVkxSkNUenpFQytseW92OEx1?=
 =?utf-8?B?R3c4YnhsY1JBQlVXekFKZTc0b3hmbGgrT0VOVzBoZmZ0enZML2tYNlhjZ29K?=
 =?utf-8?B?Y3Z3eWJoUHFMcG1RSmN0UDVVV3dLK1V5b2VzL29DMjFjam5sek1EckRJc29S?=
 =?utf-8?B?MVc5ZlRPR3dyOWlGVlJiZktCY004ajdOV1B4eGFyWUVoTnQrSWtYbTZZY2hM?=
 =?utf-8?B?QTYvMXJhWVVjVzk2RE1Jd09zMmhhMit4QWxFbnJpczA2dW1XVkFKNnNCSE41?=
 =?utf-8?B?NnEvWmtOWmp2OERGdVh0MWdXLzl2eWVjWGxZK2tsa0NJUktvRUFMMkhjSFRa?=
 =?utf-8?B?c3hFNXhJeVB6aVY3bzU2UzFQbkpmdTNBQXFPVUl3ZDJ6ZVRHOWFUWk9NNUtn?=
 =?utf-8?B?MXNrY0dIZE12MkhuUTNVRGVLYVBvQjV5RkM4OXZxWllhZERENkpxTlJzeDVr?=
 =?utf-8?B?OHpkSWJIbHUvL09GazZkM2czWi9ncUdTTnUzd0dGbHZEM1h3SnAxVG5LVW9z?=
 =?utf-8?B?Q2tvOWEydlJqb0dKQ2JGeWo2aFhmQU1jRDR5NkRaTS9HRE1vRDFoRHBvVSti?=
 =?utf-8?B?OC9NOXRKODN3VFNWMXhwZlVUdysxSDR0K1M1Y0Nrc2tIL1IvTWlIYktmNVRP?=
 =?utf-8?B?Mk82VHNXNSsrZjlTOEF1UGVSc1hhanlBN2xJNjNkeE01ZXNYZU1GV0t5aTU5?=
 =?utf-8?B?NGZ0ZjFOWXEzSGEvK0RZdmhKYmFxSHcxU0lobzhJbU1leWY5cU1tY0F1Ni9K?=
 =?utf-8?B?Qk56Y3h2ZUxzdmloSTkxM05mejltRWxEQjRFMitVdzBwWkg1K0h0ZzRvK3pT?=
 =?utf-8?B?VUJFRWdmRUVHR0N0d1pIYjVMVE9ZdnFkZFpldWFGM083M3NpTFV3U2tVamVi?=
 =?utf-8?B?YTVxVWo5aUFrV3NOaGVoRUpLUEE5QVNiWGJXVXdDcU8ycFMzbFJVczBJM3ZK?=
 =?utf-8?B?aDhVa1NEbXVNZ0hDVkg0Q1pNdk11NS9pdG5FVk45SlpIeTR5Ly9LTlFPdGNm?=
 =?utf-8?B?KzFsdVA2S0tWOXcwbGxlaGtTSTQ2d1hMRk0rbHpaTURzZ21MLzJPbHVSdFlF?=
 =?utf-8?B?Qm5XSjlnU0tJcmUwSW5ITWNFVU5FRkhYMW00QUlrbXZVQ3Q5aTU4MVRjL0li?=
 =?utf-8?B?ajVYSnE5K1ExSXk4U2NyN3NTVm9HUXNJekl0LzVNYVBsUndIbEh6RDM1RUpo?=
 =?utf-8?B?ck0vU0xqSU5EZVpXNkU2aXV2NzBMczlPTWxyZXA4ZllaS0poQjBmakV1VXRE?=
 =?utf-8?B?YVhuTVNwK0E2OGpOcFZtQTEwQ1VtbUVnQTR4bG9VZUNpdW8zTjBmTVhLQ0Er?=
 =?utf-8?B?MlBrL0RVbWxabjF1RXExdHBDZ05WeG8xcDZ3RjNDemRYbjUwTUsvR1FXSmVt?=
 =?utf-8?B?Mkx5dFowYUdobnVmNUpsSDR2V3hPSytyREVTWlNqaTFLenVaTG03MHp2ZnNM?=
 =?utf-8?B?TTZFZlFVdHkvdWplbnFmWVZMZnlqaUtJQmgyMlY5SnhGYjd6QlhveUJsNG9a?=
 =?utf-8?B?UEJ0OVRyck9MNzJOd2cxejhsNzBPd0xlaXNuQWcyc1RURkY1NlF3NVBYelJ4?=
 =?utf-8?B?VWZTVXI5RUF0YVYzS0tOcTAxOGNPWFdYV0pRZWdQSW0zTzZGWUJhL0haNWts?=
 =?utf-8?B?cU5Ed3V3QUtwd0RFMDJQLzVhazZRRjBGWkk2T2ZsNVBlSHNiN09YYmw5elhG?=
 =?utf-8?B?V21ENWwwK3lyM1lCQWhrY2Zmc2U3Y3R2T25tTUJKalNBNy9mVjdUUWYzSFds?=
 =?utf-8?B?YytKcWN6L21IdnRXYkRLQWFlTDlXNGl1ZlZkY3lJNC9NcTd3cmZHb0JjY3Rq?=
 =?utf-8?B?MXgwcXRtZXh5ZFowS2lCMHBNaC9xQ0pLVHFrUkZGUlFOVjkrUG5sREh6TG90?=
 =?utf-8?B?UXVndGVENytVOVVaRzJ3bVptMTRnNkpwZDR2NTNzSUJralJlWWhpQjZFM2FL?=
 =?utf-8?B?bnVkVFZDMytFdDAyL1luRUtkKy8zWTNmazh6aUFYN1A2VWNVR1UvSjVmR01V?=
 =?utf-8?Q?Eaq+iUNzh3S1eVXnCs8lrUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d0835-8d77-4a72-2156-08d9f2bd83c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 09:03:22.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cFuY+QUllko8rI/vmQGOEY1WrKvkC3RnZboi6aO24++3fYMF3Q0tUFDLkC9/nGd5zlvCWY/PIUmHhtSI1EBdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE2LCAyMDIyIDEyOjE2IEFN
DQo+IFRvOiBaaGFuZywgVGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFv
IDxoYW8ud3VAaW50ZWwuY29tPjsNCj4gbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4u
eHVAaW50ZWwuY29tPjsgbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRvY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGNvcmJl
dEBsd24ubmV0OyBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNy83XSBmcGdhOiBkZmw6IHBjaTogQWRkIGdl
bmVyaWMgT0ZTIFBDSSBQSUQNCj4gDQo+IA0KPiBPbiAyLzE0LzIyIDM6MjYgQU0sIFRpYW5mZWkg
emhhbmcgd3JvdGU6DQo+ID4gRnJvbTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hA
bGludXguaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIHRoZSBQQ0kgcHJvZHVjdCBpZCBmb3IgYW4g
T3BlbiBGUEdBIFN0YWNrIFBDSSBjYXJkLg0KPiBJcyB0aGVyZSBhIFVSTCB0byB0aGUgY2FyZCA/
DQoNClRoaXMgUENJZSBEZXZpY2UgSURzIGhhdmUgcmVnaXN0ZXJlZCBieSBJbnRlbC4NCg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGlu
dXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRpYW5mZWku
emhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9mcGdhL2RmbC1wY2kuYyB8
IDQgKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLXBj
aS5jIGluZGV4DQo+ID4gODNiNjA0ZDZkYmU2Li5jYjJmYmYzZWI5MTggMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9mcGdhL2RmbC1wY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtcGNp
LmMNCj4gPiBAQCAtNzYsMTIgKzc2LDE0IEBAIHN0YXRpYyB2b2lkIGNjaV9wY2lfZnJlZV9pcnEo
c3RydWN0IHBjaV9kZXYgKnBjaWRldikNCj4gPiAgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfSU5U
RUxfUEFDX0Q1MDA1CQkweDBCMkINCj4gPiAgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfU0lMSUNP
TV9QQUNfTjUwMTAJMHgxMDAwDQo+ID4gICAjZGVmaW5lIFBDSUVfREVWSUNFX0lEX1NJTElDT01f
UEFDX041MDExCTB4MTAwMQ0KPiA+ICsjZGVmaW5lIFBDSUVfREVWSUNFX0lEX0lOVEVMX09GUwkJ
MHhiY2NlDQo+IA0KPiBJTlRFTF9PRlMgaXMgYSBnZW5lcmljIG5hbWUsIHBjaSBpZCdzIG1hcCB0
byBzcGVjaWZpYyBjYXJkcw0KPiANCj4gSXMgdGhlcmUgYSBtb3JlIHNwZWNpZmljIG5hbWUgZm9y
IHRoaXMgY2FyZCA/DQoNCkkgdGhpbmsgdXNpbmcgSU5URUxfT0ZTIGlzIGJldHRlciwgYmVjYXVz
ZSBJTlRFTF9PRlMgaXMgdGhlIEdlbmVyaWMgZGV2ZWxvcG1lbnQgcGxhdGZvcm0gY2FuIHN1cHBv
cnQgbXVsdGlwbGUgY2FyZHMgd2hpY2ggdXNpbmcgT0ZTIHNwZWNpZmljYXRpb24sDQpsaWtlIElu
dGVsIFBBQyBONjAwMCBjYXJkLiANCg0KPiANCj4gVG9tDQo+IA0KPiA+DQo+ID4gICAvKiBWRiBE
ZXZpY2UgKi8NCj4gPiAgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfVkZfSU5UXzVfWAkJMHhCQ0JG
DQo+ID4gICAjZGVmaW5lIFBDSUVfREVWSUNFX0lEX1ZGX0lOVF82X1gJCTB4QkNDMQ0KPiA+ICAg
I2RlZmluZSBQQ0lFX0RFVklDRV9JRF9WRl9EU0NfMV9YCQkweDA5QzUNCj4gPiAgICNkZWZpbmUg
UENJRV9ERVZJQ0VfSURfSU5URUxfUEFDX0Q1MDA1X1ZGCTB4MEIyQw0KPiA+ICsjZGVmaW5lIFBD
SUVfREVWSUNFX0lEX0lOVEVMX09GU19WRgkJMHhiY2NmDQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1
Y3QgcGNpX2RldmljZV9pZCBjY2lfcGNpZV9pZF90YmxbXSA9IHsNCj4gPiAgIAl7UENJX0RFVklD
RShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lFX0RFVklDRV9JRF9QRl9JTlRfNV9YKSx9LA0KPiBA
QA0KPiA+IC05NSw2ICs5Nyw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBjY2lfcGNp
ZV9pZF90YmxbXSA9IHsNCj4gPiAgIAl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLA0K
PiBQQ0lFX0RFVklDRV9JRF9JTlRFTF9QQUNfRDUwMDVfVkYpLH0sDQo+ID4gICAJe1BDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9TSUxJQ09NX0RFTk1BUkssDQo+IFBDSUVfREVWSUNFX0lEX1NJTElD
T01fUEFDX041MDEwKSx9LA0KPiA+ICAgCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfU0lMSUNP
TV9ERU5NQVJLLA0KPiA+IFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDExKSx9LA0KPiA+
ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJRV9ERVZJQ0VfSURfSU5URUxf
T0ZTKSx9LA0KPiA+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwNCj4gUENJRV9E
RVZJQ0VfSURfSU5URUxfT0ZTX1ZGKSx9LA0KPiA+ICAgCXswLH0NCj4gPiAgIH07DQo+ID4gICBN
T0RVTEVfREVWSUNFX1RBQkxFKHBjaSwgY2NpX3BjaWVfaWRfdGJsKTsNCg0K
