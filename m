Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768DF4BEFDB
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 04:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiBVDLc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 22:11:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiBVDLc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 22:11:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DAB852;
        Mon, 21 Feb 2022 19:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645499466; x=1677035466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CEvuq5Jb4+6BrQs9qjtzNGguI8p6KZeaHoVZFIlVlCg=;
  b=G7tQ0aHgGaBK7NlYFzk7dMWQZXRvjU9eqQ5JPecY+iknuGxaQeuTDn9B
   UmBwiqbUw3Pca2ePNPCYbnimZlJPirGJuJzb2JRIU4MGEz4ltSTkij0wk
   0pN+EwE3q+y975Bs0WNlIheBIV6SJh37g1d9fv/9QhKtFVPeOljVIe14j
   cCsorPo4kRyJKRGt214CgGFHF+ToKiRlux32luqfiAXHKTssAoqVac7Fd
   SBXFSvq0cj2yC+vXafbWu17e87cRUj1GAMVzLsSOOTxoc00IM1IJiKI0I
   7fXJNfLjCUOt66MGG+jKZkA2PQaOSv8BdilaZcg7xAEcIB2HnZXdW11FP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276198266"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276198266"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 19:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532054218"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 19:11:06 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 19:11:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 19:11:05 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 19:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/RBabF4O575/Kk+ulfb7l6hPkhV/IDy1Jd0vhz4TNE0/8k21KFNlWYMhnJ5vu9oHMbzJZWCjieexryud4k5ZWjFODFVQD3u7olDGPg5bh7RejSIRa/Js6KGzW6QV4iG3YG6rMZGEqifPaLqzkMN3aj9NHfjHB2TrvdKl4hPYOOCAtPzKOLva+FYYyCTDoDOQ3TEvqKkEzvP8RZYhbjeZUmtIpbUpL/AywQZdMGMMezXVc+07Sm2CyJdFn/Nwcx5laF6iPd1/T5ARcuEqF6z6POLYFTha+ZnwjF41fetZQCTcD8ECpbYgLULJauqjk2oKEc5Nm+Pp6S8mKc49dMT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEvuq5Jb4+6BrQs9qjtzNGguI8p6KZeaHoVZFIlVlCg=;
 b=eUoe2g1Sj42Vj2rBUeUqGBcaIMPEgJtIsAj3SE473I5djxrew5LFCmuWU9tXz2jQ9ihK9HEdhac67TlHoSMsgGgGIu3y5gjBQS+UyMDqHmQHbOo8RFYpclwOJgtxb7FEn5cBqQ2024aW6EObdeqP/pfWWt+FhlqAeDCD1CZM0JezL7BhnoQWFe7JbgVjIzpfZdfL5gXSVlN6jVVIlQIDAlEqRm8fyy/tIrado5VhngUakXQw/n1cQUzgC9aVhNfgAF1uiPs3WCusezsOb0olP6WkIV+dR6dic8hfWmAPZBZN8D+kDhKSe/aeOk2veBT5OoqsUYe8KeMCfZlBDoONPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB3287.namprd11.prod.outlook.com (2603:10b6:a03:1c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 03:11:01 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 03:11:00 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Topic: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Index: AQHYIZY0OPmbG/7a10yxBqZVPNMIu6yUy5EAgAQ8MZCAAG0LgIAE3wIAgAAFcwCAAJVHoA==
Date:   Tue, 22 Feb 2022 03:11:00 +0000
Message-ID: <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
 <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
 <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
 <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1>
 <e5580849-c137-fb61-0599-198c341bf688@redhat.com>
In-Reply-To: <e5580849-c137-fb61-0599-198c341bf688@redhat.com>
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
x-ms-office365-filtering-correlation-id: 2d51e397-dea6-49ca-bc82-08d9f5b0f437
x-ms-traffictypediagnostic: BYAPR11MB3287:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB328791F8ACDA11A36366ACD2E33B9@BYAPR11MB3287.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGLIk593xGlU2vb3QD1ldHCONX0ei1y2R7oAHcP3Vcgp+VicHnh25z0pmlF9l+HSemr+ob4w7n4ul3SINgkZg4tW/BF+hAgVJ/xJXy+TRJmM/vtYFI/qqtwOLi9mhkIO4/Atbx9bTMPNMdHAGCu+Psj2HLVrpV8WYs1y1G8KlAsd9U6DXgLL9noFoeHbmStDnomW+k7FsLUesIGbdH/R/kWnCgNJy+izcC2LS1iZmqsgo0VvpWX33bSHOAEygSGfaDv4rWgXGNG+iKGG/dVy0AzpRI0ZKuIVDWxK/o3zQRwD4eoEisiV95IHhd4qKPR8Uup+Ci+gNyoEy1PgGfhmXuPZ/pJKve4p4kEgJ+Dyo0uh+fpor9LG24aQLrN2aPg5RiDLv3qqwqNz2H6N6MoYFwtDqzaBQMPWFdk/c4nXv34NjVnL/Ffv1cIKh7tWfXmtVxJoXU4gcRDJwFm1NQgw8f083EZRsThbUqocglAN/3bvOeQNDEL9BxIhBTfQyHBdqaqaZNuV1ACixwGr7di5o8NJn8HLC1oS7fzOtfWhi4ExKrhGGLkPQ7e9wQ07IMhCqwVkWFaGPbnfTfhK0jmfZMQngqg+28S9oYe7ba2aTUKyriGpI79n1VHHgUF7wvWNfcp/alw5MkcmvJzSCv6DAOA6xhFmgM2+dptKdLuH9+GMekIAG/hI35Kk12IJAsuJT740hZx6jgg/SYgBB9QeR81mLizc14UFC9WmsrvAg+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(2906002)(5660300002)(110136005)(54906003)(6506007)(316002)(83380400001)(7696005)(186003)(4326008)(508600001)(52536014)(71200400001)(122000001)(8676002)(66946007)(8936002)(38100700002)(26005)(38070700005)(53546011)(66556008)(66476007)(66446008)(64756008)(76116006)(86362001)(82960400001)(33656002)(55016003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODJGT3B6blhwNEowOUtaM2paVWl4UFJ3ZHlJcERCbDVtbzkxWUlpN2RWWmZz?=
 =?utf-8?B?ejkwWkRNV0Zsd3hoY1hPU0pQU2tKQm5hd0QwNzZmUWtYUkgrSmhYZmx6dXM0?=
 =?utf-8?B?VmtQcGkycjNsR0hRYXUwQmsyY0hRZFBRS3EzNWw2aGZiOU9uRjdBSmJuVDJn?=
 =?utf-8?B?TEREMlBnMGE0Vk4yMFVhdW51d1BidUo4SHNYeEg4UFBXWlQxRHNrWlUwOW12?=
 =?utf-8?B?bXdPcU5mc1AzSW4zc1YwMkg5WC9USVR5Z0hVRi8yaGIvb2x6U3MzaGQ5WW85?=
 =?utf-8?B?SE1hSE1NYmlCZVNVL0cvSVlXTnVSRVNWcjdLcXpYeW5ta3VYMHdlWTFnZS9H?=
 =?utf-8?B?K0VqcTRyMGJRS1cxWWJjNWtzZ2ZaZ1JQeEhOOEJFb3BYeUQ2Y2VjZTRYQnNm?=
 =?utf-8?B?UERqYlA3MGRZQ2hhRnZYMzlubkZ1dW5kNGV4RXpKc2I0R3R2eGJzaUpPYmRw?=
 =?utf-8?B?MlVJSmZpcEJSMWZ5MWMyNEhqdTd1TnJEY0lRM2x0MWRiZm1SanRYRitYa2N0?=
 =?utf-8?B?bm42VkliMitwS0NoY0RZNG1IM3REWGhwU2lmMWRIV3FpajVaWGdDUzdSeGxO?=
 =?utf-8?B?Z2RIUit5ZWw1T3NHOTNXVlRhVFU5S2hNTzJZcTZhYk4wQUE4UWNCVE9UWWd3?=
 =?utf-8?B?dCsvNkZUZ2cvZlp1S2xieGp5U2ZSL3d0RGZkeUthOWxhVWowNTdSMnpUcU1W?=
 =?utf-8?B?bTZ3L0RMcjlZUGgvNGRzcVNieEYrZERnM1RZSnBFZFVwdWFnbS9YcVEyZm1C?=
 =?utf-8?B?MHlYYWcvNjVmVHJhUHJGMCtiM05MUkJ3VTM4Q2RBS2wzZ09wSjBOT0FsRkNU?=
 =?utf-8?B?am4vbG10RHNDRUZ3Q3RWUW4xNHcxdURXdU5LK3N0bWJSNWU3bXdpV1JNa1pM?=
 =?utf-8?B?MGFsS1JKVFJsTGJqNU5pRTZDQnBhYXNWdlRSdEs3bE5ZODhKYm52ckVERy9n?=
 =?utf-8?B?NFFrYzVvcS90d3NsSStEU0NmZzBaaGZqUkM3Q0s1NERJTTdpVlNJK2wzdHJi?=
 =?utf-8?B?V2tKTEtxanA1VE50c25hdzVSMmJkVVQrRlZUK3dZVmlod2lxRzl6Smd4cndr?=
 =?utf-8?B?TFAzSUpsUUJZWGJnby9IOGlRNldrTzg5TWh4Uy9vMTBJcW50NEdRc2p1a3dq?=
 =?utf-8?B?U21tNnN2K08vdWtmNmVSbllmN2tUT1AzYjBGV3phbWlPdndjWWxUMldrNnYz?=
 =?utf-8?B?cWEzd1ZLNHNrN0ZXUU4wUVpsdm1iajhMakRpVzZKaC9YZHB0Qys5TVF4SHg0?=
 =?utf-8?B?VEVRcWx0Z3laNTNVODRjUUdIN2dNQ0lXUWVKOFJWZEl2TVFTOHhJcjFySE5l?=
 =?utf-8?B?bVE0aXVSSmpFck5GVXFBa2xFVzVqZDRpcUF5ZitvWGNqVm5kZUxURGVUbm9V?=
 =?utf-8?B?SjNsWDZMeXhRVnpuYlRLeHFRbFJtTitPNzl1NTN6RDdzQmYycHNCa1FkL2w4?=
 =?utf-8?B?LzF5WGJNdFJMNkZLY1ZhYjd6Vk04eUt6d0VkZUVKSTNjT3hJdWpRU3cwV21O?=
 =?utf-8?B?SWJCc3VjMEN4bVY4OFJxWGU4aE5PeVJUSTRYSXpBVE54MGxMQ0grWU1WUGQ0?=
 =?utf-8?B?MWNmanBwUi9MTC9CclU5NWJ4dXlHU1pXYTRSVmltdUxZcUpiNkN3em4xN3ps?=
 =?utf-8?B?eUk2cjFwcW1zK1Jxd0FhVVlwcDZ6ank5N2IzM3FnbTVBUWlYUlljUWx0cHFB?=
 =?utf-8?B?SXp0WkkvR01BdmdsSTUrZ0hlYlpITFVoMU45T0RKNWdTM1o4T2MvZlJwZldq?=
 =?utf-8?B?c0hYRXJOaXhBbG1ubGIzelZaZytiZGJVWXNrMVBtcTFuR2w4RUgvTDRLVXNU?=
 =?utf-8?B?RUllWjdGcjFZUy94ME1paHZYcWg3Z1lpQVB3Mmdmc3pFQ2hxOW1MQldmYnlr?=
 =?utf-8?B?bUVtU0dWTUxNM3FYMUZBNDlvWFZyWm5vWC9UaXJSR2N5RDdsL0RSd0pXbWtM?=
 =?utf-8?B?RlZBT0VJc3g3dHJEQmtnSWVPN0Q4N2crTGNkYW43SVNZdVh5MlNRRXJDbHAr?=
 =?utf-8?B?bytuNGd5OWJhUWxod2hEMlNodGxiczB1Mm03a1E0bEJRWGtZOXUwK1lzNjJi?=
 =?utf-8?B?Tlg3L0FsZ3RYMG5RZzBMc1VHckpieGZNOWtpNU1yVThFbng4MHFYaW8wU2o2?=
 =?utf-8?B?dUhaODNGUEZwSU5vVVpRcmFnT3VBVW1EVjdZOXBnV0RCV3F4NTRBMmozd2Y3?=
 =?utf-8?Q?tFAGJiXf22Bq0fJClJPp0GU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d51e397-dea6-49ca-bc82-08d9f5b0f437
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 03:11:00.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ce5kT3TS4eB+1ypTpzREc2SdD0ieujaGz9Taw0WO96axivvRdRZwW+9broko5l+/dn6SQURSywGA7D8+hgdLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMiwgMjAyMiAyOjEwIEFNDQo+
IFRvOiBtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tDQo+IENjOiBaaGFuZywgVGlhbmZl
aSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPjsN
Cj4gbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgbGludXgt
ZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgNy83XSBmcGdhOiBkZmw6IHBjaTogQWRkIGdlbmVyaWMgT0ZTIFBDSSBQSUQNCj4g
DQo+IA0KPiBPbiAyLzIxLzIyIDk6NTAgQU0sIG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5j
b20gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIEZyaSwgMTggRmViIDIwMjIsIFRvbSBSaXggd3Jv
dGU6DQo+ID4NCj4gPj4NCj4gPj4gT24gMi8xOC8yMiAxOjAzIEFNLCBaaGFuZywgVGlhbmZlaSB3
cm90ZToNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBG
cm9tOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSAxNiwgMjAyMiAxMjoxNiBBTQ0KPiA+Pj4+IFRvOiBaaGFuZywgVGlhbmZlaSA8dGlh
bmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFvDQo+ID4+Pj4gPGhhby53dUBpbnRlbC5jb20+
OyBtZGZAa2VybmVsLm9yZzsgWHUsIFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+Ow0KPiA+Pj4+
IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0K
PiA+Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+PiBDYzogY29yYmV0QGx3
bi5uZXQ7IE1hdHRoZXcgR2VybGFjaA0KPiA+Pj4+IDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50
ZWwuY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNy83XSBmcGdhOiBkZmw6IHBj
aTogQWRkIGdlbmVyaWMgT0ZTIFBDSSBQSUQNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMi8x
NC8yMiAzOjI2IEFNLCBUaWFuZmVpIHpoYW5nIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBNYXR0aGV3
IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4+DQo+ID4+
Pj4+IEFkZCB0aGUgUENJIHByb2R1Y3QgaWQgZm9yIGFuIE9wZW4gRlBHQSBTdGFjayBQQ0kgY2Fy
ZC4NCj4gPj4+PiBJcyB0aGVyZSBhIFVSTCB0byB0aGUgY2FyZCA/DQo+ID4+PiBUaGlzIFBDSWUg
RGV2aWNlIElEcyBoYXZlIHJlZ2lzdGVyZWQgYnkgSW50ZWwuDQo+ID4+IEEgVVJMIGlzIHVzZWZ1
bCB0byBpbnRyb2R1Y2UgdGhlIGJvYXJkLCBJcyB0aGVyZSBvbmUgPw0KPiA+Pj4NCj4gPj4+Pj4g
U2lnbmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50
ZWwuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUaWFuZmVpIFpoYW5nIDx0aWFuZmVpLnpo
YW5nQGludGVsLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+IMKgwqAgZHJpdmVycy9mcGdhL2Rm
bC1wY2kuYyB8IDQgKysrKw0KPiA+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtcGNp
LmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLXBjaS5jIGluZGV4DQo+ID4+Pj4+IDgzYjYwNGQ2ZGJlNi4u
Y2IyZmJmM2ViOTE4IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLXBjaS5j
DQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMNCj4gPj4+Pj4gQEAgLTc2LDEy
ICs3NiwxNCBAQCBzdGF0aWMgdm9pZCBjY2lfcGNpX2ZyZWVfaXJxKHN0cnVjdCBwY2lfZGV2DQo+
ID4+Pj4+ICpwY2lkZXYpDQo+ID4+Pj4+IMKgwqAgI2RlZmluZSBQQ0lFX0RFVklDRV9JRF9JTlRF
TF9QQUNfRDUwMDXCoMKgwqDCoMKgwqDCoCAweDBCMkINCj4gPj4+Pj4gwqDCoCAjZGVmaW5lIFBD
SUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDEwwqDCoMKgIDB4MTAwMA0KPiA+Pj4+PiDCoMKg
ICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfU0lMSUNPTV9QQUNfTjUwMTHCoMKgwqAgMHgxMDAxDQo+
ID4+Pj4+ICsjZGVmaW5lIFBDSUVfREVWSUNFX0lEX0lOVEVMX09GU8KgwqDCoMKgwqDCoMKgIDB4
YmNjZQ0KPiA+Pj4+IElOVEVMX09GUyBpcyBhIGdlbmVyaWMgbmFtZSwgcGNpIGlkJ3MgbWFwIHRv
IHNwZWNpZmljIGNhcmRzDQo+ID4+Pj4NCj4gPj4+PiBJcyB0aGVyZSBhIG1vcmUgc3BlY2lmaWMg
bmFtZSBmb3IgdGhpcyBjYXJkID8NCj4gPj4+IEkgdGhpbmsgdXNpbmcgSU5URUxfT0ZTIGlzIGJl
dHRlciwgYmVjYXVzZSBJTlRFTF9PRlMgaXMgdGhlIEdlbmVyaWMNCj4gPj4+IGRldmVsb3BtZW50
IHBsYXRmb3JtIGNhbiBzdXBwb3J0IG11bHRpcGxlIGNhcmRzIHdoaWNoIHVzaW5nIE9GUw0KPiA+
Pj4gc3BlY2lmaWNhdGlvbiwgbGlrZSBJbnRlbCBQQUMgTjYwMDAgY2FyZC4NCj4gPj4NCj4gPj4g
SSB3b3VsZCBwcmVmZXIgc29tZXRoaW5nIGxpa2UgUENJRV9ERVZJQ0VfSURfSU5URUxfUEFDX042
MDAwIGJlY2F1c2UNCj4gPj4gaXQgZm9sbG93cyBhbiBleGlzdGluZyBwYXR0ZXJuLsKgIE1ha2Ug
aXQgZWFzeSBvbiBhIGRldmVsb3BlciwgdGhleQ0KPiA+PiB3aWxsIGxvb2sgYXQgdGhlaXIgYm9h
cmQgb3IgYm94LCBzZWUgWCBhbmQgdHJ5IHRvIGZpbmQgc29tZXRoaW5nDQo+ID4+IHNpbWlsYXIg
aW4gdGhlIGRyaXZlciBzb3VyY2UuDQo+ID4+DQo+ID4+IFRvIHVzZSBPU0ZfICogdGhlIG5hbWUg
bmVlZHMgYSBzdWZmaXggdG8gZGlmZmVyZW50aWF0ZSBpdCBmcm9tIGZ1dHVyZQ0KPiA+PiBjYXJk
cyB0aGF0IHdpbGwgYWxzbyB1c2Ugb2ZzLg0KPiA+Pg0KPiA+PiBJZiB0aGlzIHJlYWxseSBpcyBh
IGdlbmVyaWMgaWQgcGxlYXNlIGV4cGxhaW4gaW4gdGhlIGRvYyBwYXRjaCBob3cNCj4gPj4gZXZl
cnkgZnV0dXJlIGJvYXJkIHdpdGggdXNlIHRoaXMgc2luZ2xlIGlkIGFuZCBob3cgYSBkcml2ZXIg
Y291bGQNCj4gPj4gd29yayBhcm91bmQgYSBodyBwcm9ibGVtIGluIGEgc3BlY2lmaWMgYm9hcmQg
d2l0aCBhIHBjaSBpZCBjb3ZlcmluZw0KPiA+PiBtdWx0aXBsZSBib2FyZHMuDQo+ID4+DQo+ID4+
IFRvbQ0KPiA+DQo+ID4gSGkgVG9tLA0KPiA+DQo+ID4gVGhlIGludGVudCBpcyB0byBoYXZlIGEg
Z2VuZXJpYyBkZXZpY2UgaWQgdGhhdCBjYW4gYmUgdXNlZCB3aXRoIG1hbnkNCj4gPiBkaWZmZXJl
bnQgYm9hcmRzLsKgIEN1cnJlbnRseSwgd2UgaGF2ZSBGUEdBIGltcGxlbWVudGF0aW9ucyBmb3Ig
Mw0KPiA+IGRpZmZlcmVudCBib2FyZHMgdXNpbmcgdGhpcyBnZW5lcmljIGlkLsKgIFdlIG1heSBu
ZWVkIGEgYmV0dGVyIG5hbWUgZm9yDQo+ID4gZGV2aWNlIGlkIHRoYW4gT0ZTLsKgIE1vcmUgcHJl
Y2lzZWx5IHRoaXMgZ2VuZXJpYyBkZXZpY2UgaWQgbWVhbnMgYSBQQ0kNCj4gPiBmdW5jdGlvbiB0
aGF0IGlzIGRlc2NyaWJlZCBieSBhIERldmljZSBGZWF0dXJlIExpc3QgKERGTCkuwqAgSG93IGFi
b3V0DQo+ID4gUENJRV9ERVZJQ0VfSURfSU5URUxfREZMPw0KPiA+DQo+ID4gV2l0aCBhIERGTCBk
ZXZpY2UgaWQsIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBQRi9WRiBpcyBkZXRlcm1pbmVkIGJ5
DQo+ID4gdGhlIGNvbnRlbnRzIG9mIHRoZSBERkwuwqAgRWFjaCBEZXZpY2UgRmVhdHVyZSBIZWFk
ZXIgKERGSCkgaW4gdGhlIERGTA0KPiA+IGhhcyBhIHJldmlzaW9uIGZpZWxkIHRoYXQgY2FuIGJl
IHVzZWQgaWRlbnRpZnkgImJyb2tlbiIgaHcsIG9yIG5ldw0KPiA+IGZ1bmN0aW9uYWxpdHkgYWRk
ZWQgdG8gYSBmZWF0dXJlLsKgIEFkZGl0aW9uYWxseSwgc2luY2UgdGhlIERGTCBpcw0KPiA+IHR5
cGljYWxseSB1c2VkIGluIGEgRlBHQSwgdGhlIGJyb2tlbiBoYXJkd2FyZSwgY2FuIGFuZCBzaG91
bGQgYmUgZml4ZWQNCj4gPiBpbiBtb3N0IGNhc2VzLg0KPiANCj4gSG93IGlzIGxzcGNpIHN1cHBv
c2VkIHRvIHdvcmsgPw0KDQpUaGVyZSBpcyBhbiBleGFtcGxlIGZvciBvbmUgY2FyZCB1c2luZyBJ
T0ZTIGFuZCBERkwuDQoNCiMgbHNwY2kgfCBncmVwIGFjYw0KYjE6MDAuMCBQcm9jZXNzaW5nIGFj
Y2VsZXJhdG9yczogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIGJjY2UgKHJldiAwMSkNCmIxOjAw
LjEgUHJvY2Vzc2luZyBhY2NlbGVyYXRvcnM6IEludGVsIENvcnBvcmF0aW9uIERldmljZSBiY2Nl
DQpiMTowMC4yIFByb2Nlc3NpbmcgYWNjZWxlcmF0b3JzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZp
Y2UgYmNjZQ0KYjE6MDAuMyBQcm9jZXNzaW5nIGFjY2VsZXJhdG9yczogUmVkIEhhdCwgSW5jLiBW
aXJ0aW8gbmV0d29yayBkZXZpY2UNCmIxOjAwLjQgUHJvY2Vzc2luZyBhY2NlbGVyYXRvcnM6IElu
dGVsIENvcnBvcmF0aW9uIERldmljZSBiY2NlDQoNCk5vdGU6IFRoZXJlIDUgUEZzIGluIHRoaXMg
Y2FyZCwgaXQgZXhwb3J0cyB0aGUgbWFuYWdlbWVudCBmdW5jdGlvbnMgdmlhIFBGMChiMTowMC4w
KSwNCk90aGVyIFBGcyBsaWtlIGIxOjAwLjEsIGIxOjAwLjIsIGIxOjAwLjQsIGFyZSB1c2luZyBm
b3IgdGVzdGluZywgd2hpY2ggZGVwZW5kcyBvbiBSVEwgZGVzaWduZXINCm9yIHByb2plY3QgcmVx
dWlyZW1lbnQuIFRoZSBQRjMgaW5zdGFuY2UgYSBWaXJ0SU8gbmV0IGRldmljZSBmb3IgZXhhbXBs
ZSwgd2lsbCBiaW5kIHdpdGggdmlydGlvLW5ldCBkcml2ZXINCnByZXNlbnRpbmcgaXRzZWxmIGFz
IGEgbmV0d29yayBpbnRlcmZhY2UgdG8gdGhlIE9TLg0KDQo+IA0KPiBBIGRmbCBzZXQgY2FuIGNo
YW5nZSB3aXRoIGZ3IHVwZGF0ZXMgYW5kIGluIHRoZW9yeSBkaWZmZXJlbnQgYm9hcmRzIGNvdWxk
IGhhdmUNCj4gdGhlIHNhbWUgc2V0Lg0KPiANCj4gVG9tDQo+IA0KPiA+DQo+ID4gTWF0dGhldw0K
PiA+Pg0KPiA+Pj4NCj4gPj4+PiBUb20NCj4gPj4+Pg0KPiA+Pj4+PiDCoMKgIC8qIFZGIERldmlj
ZSAqLw0KPiA+Pj4+PiDCoMKgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfVkZfSU5UXzVfWMKgwqDC
oMKgwqDCoMKgIDB4QkNCRg0KPiA+Pj4+PiDCoMKgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfVkZf
SU5UXzZfWMKgwqDCoMKgwqDCoMKgIDB4QkNDMQ0KPiA+Pj4+PiDCoMKgICNkZWZpbmUgUENJRV9E
RVZJQ0VfSURfVkZfRFNDXzFfWMKgwqDCoMKgwqDCoMKgIDB4MDlDNQ0KPiA+Pj4+PiDCoMKgICNk
ZWZpbmUgUENJRV9ERVZJQ0VfSURfSU5URUxfUEFDX0Q1MDA1X1ZGwqDCoMKgIDB4MEIyQw0KPiA+
Pj4+PiArI2RlZmluZSBQQ0lFX0RFVklDRV9JRF9JTlRFTF9PRlNfVkbCoMKgwqDCoMKgwqDCoCAw
eGJjY2YNCj4gPj4+Pj4NCj4gPj4+Pj4gwqDCoCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQg
Y2NpX3BjaWVfaWRfdGJsW10gPSB7DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoCB7UENJX0RFVklDRShQ
Q0lfVkVORE9SX0lEX0lOVEVMLA0KPiA+Pj4+PiBQQ0lFX0RFVklDRV9JRF9QRl9JTlRfNV9YKSx9
LA0KPiA+Pj4+IEBADQo+ID4+Pj4+IC05NSw2ICs5Nyw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCBjY2lfcGNpZV9pZF90YmxbXSA9IHsNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgIHtQQ0lf
REVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsDQo+ID4+Pj4gUENJRV9ERVZJQ0VfSURfSU5URUxf
UEFDX0Q1MDA1X1ZGKSx9LA0KPiA+Pj4+PiB7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1NJTElD
T01fREVOTUFSSywNCj4gPj4+PiBQQ0lFX0RFVklDRV9JRF9TSUxJQ09NX1BBQ19ONTAxMCksfSwN
Cj4gPj4+Pj4ge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9TSUxJQ09NX0RFTk1BUkssDQo+ID4+
Pj4+IFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDExKSx9LA0KPiA+Pj4+PiArwqDCoMKg
IHtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSUVfREVWSUNFX0lEX0lOVEVMX09G
UyksfSwNCj4gPj4+Pj4gK8KgwqDCoCB7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLA0K
PiA+Pj4+IFBDSUVfREVWSUNFX0lEX0lOVEVMX09GU19WRiksfSwNCj4gPj4+Pj4gwqDCoMKgwqDC
oMKgIHswLH0NCj4gPj4+Pj4gwqDCoCB9Ow0KPiA+Pj4+PiDCoMKgIE1PRFVMRV9ERVZJQ0VfVEFC
TEUocGNpLCBjY2lfcGNpZV9pZF90YmwpOw0KPiA+Pg0KPiA+Pg0KDQo=
